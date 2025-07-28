#!/bin/bash

echo "🚀 Stable Diffusion WebUI + SDXL 자동 설치 시작 (Mac 전용)"

# 1. Homebrew
if ! command -v brew &> /dev/null; then
  echo "🍺 Homebrew 설치 중..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. pyenv
brew install pyenv

# 3. pyenv 설정
if ! grep -q 'pyenv init' ~/.bash_profile; then
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
  source ~/.bash_profile
fi

# 4. Python 설치
pyenv install 3.10.13 -s
pyenv global 3.10.13

# 5. Rust
if ! command -v rustc &> /dev/null; then
  echo "🦀 Rust 설치 중..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# 6. WebUI 클론
cd ~ || exit
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui || exit

# 7. 가상환경
python -m venv sd-env
source sd-env/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 8. 모델 폴더 생성
mkdir -p models/Stable-diffusion

# 9. SDXL 모델 다운로드
echo "⬇️ SDXL 모델 다운로드 중 (Base + Refiner)..."
curl -L -o models/Stable-diffusion/sdxl_base_1.0.safetensors https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
curl -L -o models/Stable-diffusion/sdxl_refiner_1.0.safetensors https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors

# 10. 모델 config 파일 다운로드
curl -L -o models/Stable-diffusion/sd_xl_base.yaml https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/raw/main/sd_xl_base.yaml
curl -L -o models/Stable-diffusion/sd_xl_refiner.yaml https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/raw/main/sd_xl_refiner.yaml

# 11. 완료 안내
echo "🎉 SDXL 자동 설치 완료!"
echo ""
echo "👉 실행 방법:"
echo "cd ~/stable-diffusion-webui"
echo "source sd-env/bin/activate"
echo "python launch.py --xformers"
echo ""
echo "SDXL Base 모델: sdxl_base_1.0.safetensors"
echo "SDXL Refiner 모델: sdxl_refiner_1.0.safetensors"