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

# For installing Java 8
add-apt-repository ppa:webupd8team/java

# For Mesos
apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list

apt-get -y update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y install oracle-java8-installer
apt-get -y install oracle-java8-set-default
apt-get -y install libcurl3
apt-get -y install zookeeperd
apt-get -y install aria2

echo "${PREFIX} installing Mesos version: ${MESOS_VERSION}..."
apt-get -y install mesos
echo "Done"

ln -s /usr/lib/jvm/java-8-oracle/jre/lib/amd64/server/libjvm.so /usr/lib/libjvm.so

echo "${PREFIX} starting Mesos master"
start mesos-master

echo "${PREFIX} starting Mesos slave"
start mesos-slave

echo "${PREFIX} successfully provisioned EC2 instance with Mesos"

# setup-yarn-{1|2}.sh

echo "${PREFIX} now setting up YARN"

# install Gradle and ./gradlew build
 
echo "${PREFIX} now building Myriad"


echo "${PREFIX} successfully provisioned Myriad"