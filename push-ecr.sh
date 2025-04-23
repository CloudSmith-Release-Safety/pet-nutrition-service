#!/usr/bin/env bash
export REPOSITORY_PREFIX=${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com

aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REPOSITORY_PREFIX}

aws ecr create-repository --repository-name nodejs-petclinic-nutrition-service --region ${REGION} --no-cli-pager || true
docker build -t nutrition-service ./pet-nutrition-service --no-cache
docker tag nutrition-service:latest ${REPOSITORY_PREFIX}/nodejs-petclinic-nutrition-service:latest
docker tag nutrition-service:latest ${REPOSITORY_PREFIX}/nodejs-petclinic-nutrition-service:${COMMIT_SHA}
docker push ${REPOSITORY_PREFIX}/nodejs-petclinic-nutrition-service:latest
docker push ${REPOSITORY_PREFIX}/nodejs-petclinic-nutrition-service:${COMMIT_SHA}
