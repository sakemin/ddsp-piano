FROM tensorflow/tensorflow:2.11.0-gpu

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies with specific versions
RUN pip install --no-cache-dir --upgrade \
    protobuf==3.20.3 \
    ddsp==3.7.0 \
    tensorflow-addons \
    tensorflow-probability==0.19.0 \
    google-cloud-storage

# Copy repository files
COPY . /app/

# Default working directory for mounted volumes
RUN mkdir -p /data/input /data/output

# Set entrypoint
ENTRYPOINT ["python", "synthesize_midi_file.py"] 