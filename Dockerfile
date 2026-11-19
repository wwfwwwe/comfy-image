FROM pytorch/pytorch:2.7.1-cuda12.8-cudnn9-runtime
ENV DEBIAN_FRONTEND=noninteractive PIP_NO_CACHE_DIR=1
RUN apt-get update && apt-get install -y --no-install-recommends git wget rsync openssh-client libgl1 libglib2.0-0 gcc libc6-dev && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 https://github.com/Comfy-Org/ComfyUI /opt/ComfyUI && pip install -r /opt/ComfyUI/requirements.txt
WORKDIR /opt/ComfyUI/custom_nodes
RUN for r in ltdrdata/ComfyUI-Impact-Pack ltdrdata/ComfyUI-Impact-Subpack cubiq/ComfyUI_IPAdapter_plus Acly/comfyui-tooling-nodes weilin9999/WeiLin-Comfyui-Tools; do d=${r#*/}; git clone --depth 1 https://github.com/$r && if [ -f $d/requirements.txt ]; then pip install -r $d/requirements.txt; fi; done
RUN wget -qO /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && chmod +x /usr/local/bin/cloudflared
WORKDIR /opt/ComfyUI
