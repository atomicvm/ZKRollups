#!/usr/bin/env bash

echo "Submodule Cloning..."
git submodule update --init --recursive

echo "Build ZkSync Contracts..."
(
cd test
yarn
yarn build
)

echo "Pull Container Images..."
docker pull docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
docker pull docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
docker pull docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
docker pull docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
docker pull matterlabs/dev-ticker:latest

echo "Start Integration Test..."
docker-compose -f docker-compose.ci.yml build setup test
docker-compose -f docker-compose.ci.yml up -d substrate postgres ticker setup
docker-compose -f docker-compose.ci.yml up -d operator prover
docker-compose -f docker-compose.ci.yml up test
