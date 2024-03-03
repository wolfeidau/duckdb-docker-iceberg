# syntax=docker/dockerfile:1
FROM alpine:3.19
ARG DUCKDB_VERSION_TAG
ARG TARGETARCH

RUN apk add ca-certificates
ADD lib/$DUCKDB_VERSION_TAG/linux-$TARGETARCH/libduckdb.so /usr/lib/$TARGETARCH-linux-gnu/
ADD extensions/$DUCKDB_VERSION_TAG/linux_$TARGETARCH/ /extensions/$DUCKDB_VERSION_TAG/linux_$TARGETARCH/