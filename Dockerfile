FROM rust:1.65 as builder

WORKDIR /workdir
COPY app .
RUN cargo install --path .
RUN cargo clean

################################
FROM debian:stable-slim
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*
# DEBIAN_FRONTEND=noninteractive apt-get -qq install

COPY --from=builder /usr/local/cargo/bin/app /usr/local/bin/app
CMD ["app"]
