FROM apache/spark:3.5.5 AS builder

USER root

# Copy the requirements file from the engo-spark image
COPY engo-spark:3.5.5-py312.requirements.txt requirements.txt

# Essential packages for Python 3.12 compilation
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libsqlite3-dev \
    libreadline-dev \
    libffi-dev \
    libbz2-dev \
    liblzma-dev \
    libxml2-dev \
    libxmlsec1-dev

# Python 3.12 installation
RUN wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz \
    && tar -xf Python-3.12.2.tgz \
    && cd Python-3.12.2 \
    && ./configure --enable-optimizations \
    && make -j$(nproc) \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.12.2 Python-3.12.2.tgz

# Install required Python packages
RUN /usr/local/bin/pip3.12 install --upgrade pip \
    && /usr/local/bin/pip3.12 install -r requirements.txt --no-cache-dir

# Final image
FROM apache/spark:3.5.5

USER root

# Copy Python from builder stage
COPY --from=builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=builder /usr/local/bin/python3.12 /usr/local/bin/python3.12
COPY --from=builder /usr/local/bin/pip3.12 /usr/local/bin/pip3.12

# Create symlinks
RUN ln -sf /usr/local/bin/python3.12 /usr/local/bin/python3 \
    && ln -sf /usr/local/bin/python3.12 /usr/local/bin/python \
    && ln -sf /usr/local/bin/pip3.12 /usr/local/bin/pip3 \
    && ln -sf /usr/local/bin/pip3.12 /usr/local/bin/pip

# Environment variables
ENV PYSPARK_PYTHON=/usr/local/bin/python3.12
ENV PYSPARK_DRIVER_PYTHON=/usr/local/bin/python3.12
ENV PATH=$PATH:/usr/local/bin

# Change back to the default user
USER 185
