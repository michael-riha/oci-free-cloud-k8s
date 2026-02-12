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

## Build postfix

`docker compose --profile postfix build`

## Test postfix-relay

> [Postfix daemon processes rund in a chroot jail.<br>A chroot jail is a way to isolate a process and its children from the rest of the system. It should only be used for processes that don't run as root, as root users can break out of the jail very easily.](https://www.postfix.org/BASIC_CONFIGURATION_README.html#:~:text=in%20Postfix%20logging.-,Running%20Postfix%20daemon%20processes%20chrooted,-Postfix%20daemon%20processes)

This is the reason why DNS is not working out of the box [so we needed to do line 19 in the `entrypoint.sh`](./postfix-service/entrypoint.sh#L19)

### Run the postfix container
`docker compose --profile postfix exec postfix /bin/bash`

`echo "This is a test message" | mail -s "Test" -r <approved sender email address> <recipient email address>`

echo "This is a test message" | mail -s "Test" -r noreply@oke1.bey.media michael.riha@gmail.com
