# syntax=docker/dockerfile:1
FROM alpine:3.19
ARG DUCKDB_VERSION
ARG ARCH
ARG DUCKDB_ARCH

RUN apk add ca-certificates
ADD lib/$DUCKDB_VERSION/linux-$ARCH/libduckdb.so /usr/lib/$ARCH-linux-gnu/
ADD extensions/$DUCKDB_VERSION/${DUCKDB_ARCH}/ /extensions/$DUCKDB_VERSION/$DUCKDB_ARCH/