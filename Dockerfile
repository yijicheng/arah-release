FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

# Prevent stop building ubuntu at time zone selection.  
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH /opt/conda/bin:$PATH


# Change apt source
RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
RUN sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
RUN apt-get clean
RUN apt-get -y update --fix-missing
RUN apt-get -y install wget vim git tmux build-essential libgl1-mesa-glx libglib2.0-0

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
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    conda env create -f environment.yml && \
    conda activate arah && \
    python setup.py build_ext --inplace
