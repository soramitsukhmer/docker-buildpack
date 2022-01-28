#!/bin/sh
set -e

build() {
	local DOCKER_META_IMAGES=${DOCKER_META_IMAGES}
	local DOCKER_META_VERSION=${DOCKER_META_VERSION}

	case "${DOCKER_META_VERSION}" in
		pr-*|v*-alpha.*|v*-beta.*)
			NODE_ENV=development
		;;
		develop)
			NODE_ENV=development
		;;
		main|master)
			NODE_ENV=production
		;;
		*)
			NODE_ENV=production
		;;
	esac

	echo "Docker Metadata:"
	echo "- DOCKER_META_IMAGES=${DOCKER_META_IMAGES}"
	echo "- DOCKER_META_VERSION=${DOCKER_META_VERSION}"
	echo

	yarn run build --mode ${NODE_ENV}
}

build
