#!/bin/bash
set -euo pipefail

echo "==> Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
source "$HOME/.local/bin/env"

echo "==> Creating venv (Python 3.12)..."
uv venv --python 3.12 --seed
source .venv/bin/activate

echo "==> Installing vllm..."
uv pip install vllm==0.19.0 --torch-backend=auto

echo "==> Installing vllm[audio]..."
uv pip install "vllm[audio]"
uv pip install orjson

echo "==> Cloning and installing vllm-omni..."
git clone https://github.com/vllm-project/vllm-omni.git
cd vllm-omni
uv pip install -e .

echo "==> Installing system dependencies..."
apt-get update && apt-get install -y ffmpeg vim netcat

echo "==> Done! Activate the venv with: source .venv/bin/activate"
