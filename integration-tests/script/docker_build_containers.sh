#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Build Druid Cluster Image
if [ -z "$DRUID_INTEGRATION_TEST_JVM_RUNTIME" ]
then
  echo "\$DRUID_INTEGRATION_TEST_JVM_RUNTIME is not set. Build druid-cluster with Java 8"
  docker build -t druid/cluster --build-arg DOCKER_IMAGE=imply/druiditbase:openjdk-1.8.0_191-1 $SHARED_DIR/docker
else
  echo "\$DRUID_INTEGRATION_TEST_JVM_RUNTIME is set with value ${DRUID_INTEGRATION_TEST_JVM_RUNTIME}"
  case "${DRUID_INTEGRATION_TEST_JVM_RUNTIME}" in
  8)
    echo "Build druid-cluster with Java 8"
    docker build -t druid/cluster --build-arg DOCKER_IMAGE=imply/druiditbase:openjdk-1.8.0_191-1 $SHARED_DIR/docker
    ;;
  11)
    echo "Build druid-cluster with Java 11"
    docker build -t druid/cluster --build-arg DOCKER_IMAGE=imply/druiditbase:openjdk-11.0.5-1 $SHARED_DIR/docker
    ;;
  *)
    echo "Invalid JVM Runtime given. Stopping"
    exit 1
    ;;
  esac
fi

# Build Hadoop docker if needed
docker build -t druid-it/hadoop:2.8.5 $HADOOP_DOCKER_DIR