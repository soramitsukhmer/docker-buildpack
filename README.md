# soramitsukhmer/docker-buildpack
[Experimental] Docker Global Entrypoint Scripts

## Usage

**Vue.js version 2 project**

```Dockerfile
FROM --platform=$BUILDPLATFORM node:16-alpine

# Automatic platform ARGs
# This feature is only available when using the BuildKit backend.
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

# Docker Metadata Actions
ARG DOCKER_META_IMAGES=
ARG DOCKER_META_VERSION=
ENV DOCKER_META_IMAGES=${DOCKER_META_IMAGES}
ENV DOCKER_META_VERSION=${DOCKER_META_VERSION}

WORKDIR /usr/src/app

# Dependencies layer
ENV CI=1
ENV CYPRESS_INSTALL_BINARY=0

COPY .npmrc .yarnrc ./
COPY package.json yarn.lock ./
RUN yarn install

# Transfer project source to Docker context
COPY .browserslistrc ./
COPY .eslintrc.js .eslintignore ./
COPY babel.config.js vue.config.js ./
COPY public ./public
COPY src ./src

# Transfer environment files
COPY .env .env.* ./
RUN rm .env.*.local

# Build application
ADD https://raw.githubusercontent.com/soramitsukhmer/docker-entrypoints/main/nodejs/vue2/buildpack /buildpack
RUN sh /buildpack
```
