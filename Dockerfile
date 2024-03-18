FROM ubuntu:22.04

ENV GIT_NAME John Example
ENV GIT_EMAIL john@example.org

ARG USERNAME=br
ARG USER_UID=1000
ARG USER_GID=$USER_UID

WORKDIR /build

RUN \
	apt-get update && apt-get -y install \
	android-tools-adb android-tools-fastboot autoconf automake \
	bc bison build-essential cscope curl device-tree-compiler flex \
	ftp-upload gdisk iasl libattr1-dev libcap-dev libfdt-dev \
	libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev \
	libpixman-1-dev libssl-dev libtool make \
	mtools netcat unzip uuid-dev \
	xdg-utils xterm xz-utils zlib1g-dev git nano wget cpio rsync && \
	groupadd --gid $USER_GID $USERNAME && \
        useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
        mkdir -p /etc/sudoers.d/ && \
        echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    	chmod 0440 /etc/sudoers.d/$USERNAME
    
RUN \
	git config --global user.name $GIT_NAME && \
	git config --global user.email $GIT_EMAIL

USER $USERNAME

