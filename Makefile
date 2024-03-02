SHELL := /bin/bash

DUCKDB_VERSION_TAG ?= v0.10.0
DUCKDB_RELEASE_URL := https://github.com/duckdb/duckdb/releases/download/${DUCKDB_VERSION_TAG}/
DUCKDB_EXTENSION_URL := http://extensions.duckdb.org/${DUCKDB_VERSION_TAG}/
DUCKDB_EXTENSION_PATH := extensions/${DUCKDB_VERSION_TAG}
DUCKDB_LIB_PATH := lib/${DUCKDB_VERSION_TAG}

ARCH ?= aarch64

ifeq ($(ARCH),arm64)
ARCH := aarch64
endif

.PHONY: default
default: download-linux-${ARCH} download-extensions-linux-${ARCH} docker-build

.PHONY: download
download: download-linux-${ARCH} download-extensions-linux-${ARCH}

.PHONY: download-linux-${ARCH}
download-linux-${ARCH}:
	mkdir -p ${DUCKDB_LIB_PATH}/linux-${ARCH}
	set -ex && source scripts/download.sh && \
		cd ${DUCKDB_LIB_PATH}/linux-${ARCH} && \
		unzip-from-link ${DUCKDB_RELEASE_URL}libduckdb-linux-${ARCH}.zip .

.PHONY: download-extensions-linux-${ARCH}
download-extensions-linux-${ARCH}:
	mkdir -p ${DUCKDB_EXTENSION_PATH}/linux_${ARCH}
	cd ${DUCKDB_EXTENSION_PATH}/linux_${ARCH} && \
		curl -OL ${DUCKDB_EXTENSION_URL}linux_${ARCH}/iceberg.duckdb_extension.gz && \
		curl -OL ${DUCKDB_EXTENSION_URL}linux_${ARCH}/httpfs.duckdb_extension.gz

.PHONY: docker-build
docker-build:
	docker build -t duckdb-lib-iceberg:${DUCKDB_VERSION_TAG} \
		--build-arg ARCH=${ARCH} \
		--build-arg DUCKDB_VERSION_TAG=${DUCKDB_VERSION_TAG} .

.PHONY: clean
clean:
	rm -rf lib
	rm -rf extensions