########### Base Ubuntu ###########
# Base Container Microsoft: https://hub.docker.com/_/microsoft-vscode-devcontainers
FROM mcr.microsoft.com/vscode/devcontainers/python:3.9

########### ARGS ###########
ARG PAS_CLASSIC_USER
ARG PAS_CLASSIC_TOKEN

########### ONNX2C Preparation ###########
# Update and install tools
RUN apt-get update && apt-get install -y libprotobuf-dev protobuf-compiler cmake

# Clone repo onnx2c
RUN mkdir repos
RUN chmod 777 /repos
RUN cd /repos && git clone https://github.com/kraiskil/onnx2c.git
RUN cd /repos/onnx2c && git submodule update --init

# Build onnx2c
RUN mkdir /repos/onnx2c/build && cd /repos/onnx2c/build && cmake /repos/onnx2c && make onnx2c
RUN git config --global --add safe.directory /repos/onnx2c

# Extend Path
ENV PATH /repos/onnx2c/build:$PATH
