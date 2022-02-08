# docker-entrypoints
[Experimental] Docker Global Entrypoint Scripts

## Usage

**Vue.js version 2 project**

```Dockerfile
FROM --platform=$BUILDPLATFORM node:14-alpine AS builder

WORKDIR /usr/src/app

# Docker Metadata Actions
ARG DOCKER_META_IMAGES=
ARG DOCKER_META_VERSION=
ENV DOCKER_META_IMAGES=${DOCKER_META_IMAGES}
ENV DOCKER_META_VERSION=${DOCKER_META_VERSION}

# Dependencies layer
COPY .npmrc .yarnrc ./
COPY package.json yarn.lock ./
RUN yarn install

# Add buildpack
ADD https://raw.githubusercontent.com/soramitsukhmer/docker-entrypoints/main/nodejs/vue2/buildpack /buildpack
RUN chmod +x /buildpack

# Transfer project source to Docker context
COPY .env .env.* ./
COPY .eslintrc.js .eslintignore ./
COPY babel.config.js vue.config.js ./
COPY src ./src
COPY public ./public

# Build application
RUN /buildpack
```
