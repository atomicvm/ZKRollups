FROM rustlang/rust:nightly as builder

WORKDIR /app

COPY evmchain .

RUN apt-get update -y && \
	apt-get install -y cmake pkg-config libssl-dev git gcc build-essential clang libclang-dev

RUN rustup target add wasm32-unknown-unknown

RUN rustup toolchain install nightly-2020-08-23 &&\
    rustup target add wasm32-unknown-unknown --toolchain nightly-2020-08-23 &&\
    cargo +nightly-2020-08-23 build

FROM node:12.11.1-alpine

WORKDIR /app

COPY --from=builder /app/target target

COPY zkrollup zkrollup

COPY scripts scripts

RUN apk add --update --upgrade --no-cache \
    rust=1.44.0-r0 \
    cargo=1.44.0-r0 &&\
    sh scripts/init.sh

RUN cd zkrollup &&\
    npm i &&\
    npm run test

ENTRYPOINT sleep 9000