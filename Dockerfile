# syntax=docker/dockerfile:1
FROM debian:bookworm
ARG DUCKDB_VERSION_TAG
ARG TARGETARCH

ADD lib/$DUCKDB_VERSION_TAG/linux-$TARGETARCH/libduckdb.so /usr/lib/$TARGETARCH-linux-gnu/
ADD extensions/$DUCKDB_VERSION_TAG/linux_$TARGETARCH/ /extensions/$DUCKDB_VERSION_TAG/linux_$TARGETARCH/