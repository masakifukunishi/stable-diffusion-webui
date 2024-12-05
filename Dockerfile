FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /stable-diffusion-webui

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui .

# Install dependencies
RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip3 install --no-cache-dir xformers

# Download the model
RUN mkdir -p models/Stable-diffusion
RUN wget -O models/Stable-diffusion/animagine-xl-3.0.safetensors https://civitai.com/api/download/models/[MODEL_ID]

EXPOSE 7860

# Set up the entry point
COPY start.sh /start.sh
RUN chmod +x /start.sh