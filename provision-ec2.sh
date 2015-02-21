#!/bin/bash

###############################################################################
#  
# Installs Myriad on EC2
#
# Usage:
#
#    ./provision-ec2.sh [AMI_ID]
#
# Example
#
#    ./provision-ec2.sh 
#
# Author: Michael Hausenblas
# Init: 2015-02-21
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

PREFIX="Myriad EC2 provisioner:"
MESOS_VERSION="0.21.1"

# if no CLI parameter is provided by user, use an AMI as follows:
# Ubuntu trusty 64, 14.04 LTS, instance-store in eu-west-1
EC2_ZONE=${1:-"ami-0de9627a"} 

set -e

echo "${PREFIX} starting installation ..."

# setup-yarn-{1|2}.sh

# install Gradle

# ./gradlew build

echo "${PREFIX} successfully provisioned Myriad"