# TODO: Multiarch Prefix on Architecture

```
RUN DOWNLOAD_ARCH=$(uname -m) && \
    wget -O /tmp/cef.tar.xz https://cdn-fastly.obsproject.com/downloads/cef_binary_5060_linux_${DOWNLOAD_ARCH}_v3.tar.xz \
```

https://docs.docker.com/build/building/multi-platform/

example:
```Dockerfile
...
ARG TARGETOS
ARG TARGETARCH
WORKDIR /app
ADD https://github.com/dvdksn/buildme.git#eb6279e0ad8a10003718656c6867539bd9426ad8 .
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o server .
```
- `uname -m` -> `x86_64` or `aarch64`
- TARGETARCH is a built-in BuildKit variable in Docker that indicates the CPU architecture
    - like `amd64`, `arm64`, `arm/v7` for multi-platform builds
