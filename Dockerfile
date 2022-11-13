FROM rust:1.65 as builder
WORKDIR /asdf
COPY app .
RUN cargo install --path .
RUN ls /usr/local/cargo/bin/
RUN grep "^name.*=" Cargo.toml | cut -d'=' -f2 | tr -d '"' > /tmp/appname

################################
FROM debian:stable-slim
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*
# DEBIAN_FRONTEND=noninteractive apt-get -qq install

COPY --from=builder /tmp/appname /tmp/appname
COPY --from=builder /usr/local/cargo/bin/app /usr/local/bin/app
CMD ["app"]
RUN export TEST="$(cat /tmp/appname)"
RUN echo $TEST
