FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    curl \
    git \
    vim \
    python3-pip && \
    add-apt-repository universe && \
    rm -rf /var/lib/apt/lists/*

# ROS 2
RUN export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}') && \
	curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb" && \
	dpkg -i /tmp/ros2-apt-source.deb && \
	rm /tmp/ros2-apt-source.deb && \
	apt-get update && \
    apt-get install -y \
    ros-humble-desktop \
    ros-dev-tools && \
    rm -rf /var/lib/apt/lists/*
    
# Automatically source ROS 2
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
    
# Python
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && \
	rm /tmp/requirements.txt
	
WORKDIR /root
    
CMD ["/bin/bash"]

