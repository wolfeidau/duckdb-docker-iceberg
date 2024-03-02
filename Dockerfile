# syntax=docker/dockerfile:1
FROM alpine:3.19
ARG DUCKDB_VERSION

RUN apk add ca-certificates
ADD lib/$DUCKDB_VERSION/linux-aarch64/libduckdb.so /usr/lib/aarch64-linux-gnu/
ADD extensions/$DUCKDB_VERSION/linux_arm64/ /extensions/$DUCKDB_VERSION/linux_arm64/