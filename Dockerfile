# syntax=docker/dockerfile:1
FROM alpine:3.19
ARG DUCKDB_VERSION_TAG
ARG ARCH

RUN apk add ca-certificates
ADD lib/$DUCKDB_VERSION_TAG/linux-$ARCH/libduckdb.so /usr/lib/$ARCH-linux-gnu/
ADD extensions/$DUCKDB_VERSION_TAG/linux_$ARCH/ /extensions/$DUCKDB_VERSION/linux_$ARCH/