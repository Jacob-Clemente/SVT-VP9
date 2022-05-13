# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nasm

## Add source code to the build stage.
ADD . /SVT-VP9
WORKDIR /SVT-VP9/Build/linux

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN ./build.sh release

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /SVT-VP9/Bin/Release/SvtVp9EncApp /
COPY --from=builder /SVT-VP9/Bin/Release/libSvtVp9Enc.so /
COPY --from=builder /SVT-VP9/Bin/Release/libSvtVp9Enc.so.1 /
