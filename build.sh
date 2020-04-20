#!/usr/bin/env bash

source setenv.sh

echo "Criando imagem $DOCKER_REGISTRY/maven-$MAVEN_VERSION-openjdk-$JAVA_VERSION"
docker build -t $DOCKER_REGISTRY/maven-$MAVEN_VERSION-openjdk-$JAVA_VERSION .
