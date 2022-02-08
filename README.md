# docker-entrypoints
[Experimental] Docker Global Entrypoint Scripts

## Usage

**Vue.js version 2 project**

```Dockerfile
# Stage 1 - Bootstrap
#
FROM --platform=$BUILDPLATFORM node:16-alpine AS build-dep

ENV CI=1
ENV CYPRESS_INSTALL_BINARY=0

COPY .config/bootstrap.sh /bootstrap.sh
RUN sh /bootstrap.sh

# Stage 2 - Builder
#
FROM build-dep AS builder

# Docker Metadata Actions
ARG DOCKER_META_IMAGES=
ARG DOCKER_META_VERSION=
ENV DOCKER_META_IMAGES=${DOCKER_META_IMAGES}
ENV DOCKER_META_VERSION=${DOCKER_META_VERSION}

WORKDIR /usr/src/app

# Dependencies layer
COPY .npmrc .yarnrc ./
COPY package.json yarn.lock ./
RUN yarn install

# Transfer project source to Docker context
COPY .env .env.* ./
COPY .eslintrc.js .eslintignore ./
COPY babel.config.js vue.config.js ./
COPY src ./src
COPY public ./public
COPY submodules ./submodules

# Build application
ADD https://raw.githubusercontent.com/soramitsukhmer/docker-entrypoints/main/nodejs/vue2/buildpack /buildpack
RUN sh /buildpack
```
