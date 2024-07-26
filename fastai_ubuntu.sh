# Install CUDNN
wget https://developer.download.nvidia.com/compute/cudnn/9.2.1/local_installers/cudnn-local-repo-ubuntu2204-9.2.1_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu2204-9.2.1_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2204-9.2.1/cudnn-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cudnn


# Setup FastAI
## Install Python
sudo apt update
sudo apt install python3 python3-pip

## Create virtual environment
mkdir test
cd test
python3 -m venv fastai_env
source fastai_env/bin/activate

## Install python with CUDA support 
pip install --upgrade pip
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

## Install FastAI
pip install fastai

# Install jupyter notebooks
pip install jupyterlab
pip install notebook
pip install voila
pip install gradio
pip install fastbook