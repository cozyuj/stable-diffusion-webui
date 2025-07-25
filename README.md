# stable-diffusion-webui
stable-diffusion-webui

아래의 Shell script 파일로 python 3.10 및 관련 라이브러리 모두 설치 가능함
./install_sd_webui_mac.sh 

CPU 렌더링을 하는 경우
python launch.py --skip-torch-cuda-test

GPU 렌더링을 하는 경우
python launch.py


https://civitai.com/?query=lora
여기에서 마음에 드는 LoRA model을 다운로드
CyberRealistic XL 를 다운로드했음  
(참고: https://civitai.com/models/312530?modelVersionId=1962475)


다운로드한 model을 stable-diffusion-webui가 있는 해당 경로에 추가
stable-diffusion-webui/models/Lora 


prompt에 <lora:filename:multiplier> 입력(확장자 제외) 
<lora:cyberrealisticXL_v60.safetensors:multiplier> 입력 그리고 선택 후
prompt에 명령어와 Negative prompt 입력

끗~ 
