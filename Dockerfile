# Base image with the necessary dependencies
#FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
#FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu22.04
#FROM adamrehn/vulkan-minimal-example:latest
FROM ubuntu:latest
#FROM nvidia/cuda:12.2.0-devel-ubuntu22.04
# Set the working directory
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV DEBIAN_FRONTEND=noninteractive
#ENV DISPLAY=:0
RUN apt-get update && \  
    apt-get -y install \
    pciutils \
    vulkan-tools \
    mesa-utils
#RUN apt-get update \
#    && apt-get install -y \
#    libxext6 \
#    libvulkan1 \
#    libvulkan-dev \
#    vulkan-tools
RUN apt-get update && apt-get install -y ca-certificates
#COPY x.json /etc/vulkan/icd.d
WORKDIR /app
#RUN apt-get update && apt-get install -y \
#    mesa-vulkan-drivers \
#    vulkan-tools

EXPOSE 8888
EXPOSE 8888/udp
RUN groupadd -r myuser && useradd -r -g myuser myuser
# Install additional dependencies
# && \
#    apt-get install -y --no-install-recommends \
#    libglu1 libxcursor1 libxrandr2 libxinerama1 libxi6 libpulse0 \
#    pulseaudio xvfb mesa-utils && \
#    rm -rf /var/lib/apt/lists/*
RUN chown -R myuser:myuser /app
#RUN apt-get update && apt-get install -y libsdl2-dev
ENV NVIDIA_DRIVER_CAPABILITIES=all  
ENV NVIDIA_VISIBLE_DEVICES=all
# Copy the packaged Unreal project into the container
COPY . /app
USER myuser
#Set the entry point
#CMD bash Pixel_Streaming_demo.sh -RenderOffScreen -ResX=1920 -ResY=1080 -PixelStreamingIp=ss -PixelStreamingPort=8888 
#-ForceRes
ENTRYPOINT ["/bin/bash", "Pixel_Streaming_demo.sh", "-RenderOffScreen", "-ResX=1920", "-ResY=1080"]

# Define the default values for the runtime parameters
CMD ["-PixelStreamingIp=localhost", "-PixelStreamingPort=8888"]

#CMD vulkaninfo


