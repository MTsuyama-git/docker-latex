#!/usr/bin/env bash
source versionInfo
docker image build --rm --no-cache -f ./Dockerfile -t ${IMGNAME}:${TAG} .
