FROM --platform=$TARGETPLATFORM ubuntu:24.04

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

RUN apt-get update && apt-get install -y nodejs npm make xz-utils wget && \
    git config --global --add safe.directory '*' && \
    npm install -g conventional-changelog-cli && \
    case "$TARGETARCH" in \
        "amd64") \
            wget https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz -O /tmp/toolchain.tar.xz \
            ;; \
        "arm64") \
            wget https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-aarch64-arm-none-eabi.tar.xz -O /tmp/toolchain.tar.xz \
            ;; \
    esac && \
    mkdir -p /opt/armgcc && \
    tar -xf /tmp/toolchain.tar.xz -C /opt/armgcc --strip-components=1 && \
    rm /tmp/toolchain.tar.xz

ENV PATH="/opt/armgcc/bin:${PATH}:"
