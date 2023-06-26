# soramitsukhmer/docker-buildpack
[Experimental] Docker Global Entrypoint Scripts

## Usage

```Dockerfile
# https://github.com/soramitsukhmer/docker-buildpack
ARG SORA_BUILDPACK=vue3 \
    SORA_BUILDPACK_BIN=buildpack-vite \
    SORA_BUILDPACK_VERSION=v0.2.1
ADD --chmod=0765 https://raw.githubusercontent.com/soramitsukhmer/docker-buildpack/${SORA_BUILDPACK_VERSION}/nodejs/${SORA_BUILDPACK}/${SORA_BUILDPACK_BIN} /usr/bin/buildpack
# ...
RUN /usr/bin/buildpack
```
