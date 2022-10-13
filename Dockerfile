FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

# Prevent stop building ubuntu at time zone selection.  
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH /opt/conda/bin:$PATH


# Change apt source
RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
RUN sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
RUN apt-get clean
RUN apt-get -y update --fix-missing
RUN apt-get -y install wget vim git tmux build-essential

# Install MiniConda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda init bash

RUN cd ~ && git clone --recursive https://ghproxy.com/github.com/taconite/arah-release.git
RUN . ~/.bashrc && \
    cd ~/arah-release && \
    conda env create -f environment.yml
RUN . ~/.bashrc && \
    cd ~/arah-release && \
    conda activate arah && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install cython==0.29.23 && \
    pip install gdown==4.5.1 && \
    pip install imageio==2.13.5 && \
    pip install imageio-ffmpeg==0.4.7 && \
    pip install kornia==0.5.10 && \
    pip install lpips==0.1.4 && \
    pip install matplotlib==3.4.2 && \
    pip install opencv-python==4.5.5.62 && \
    pip install pandas==1.2.4 && \
    pip install plyfile==0.7.4 && \
    pip install scikit-image==0.18.1 && \
    pip install scikit-learn==0.24.2 && \
    pip install trimesh==3.9.20 && \
    pip install wandb==0.12.15 && \
    python setup.py build_ext --inplace
