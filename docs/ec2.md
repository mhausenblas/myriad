# EC2 setup

You can use following guide to setup a cluster on AWS [EC2](http://aws.amazon.com/ec2/).

## Prerequisites

In order to perform the EC2 provisioning you'll need:

* An [AWS account](http://aws.amazon.com/account/)
* An [EC2 key pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* To have [boto](http://docs.pythonboto.org/en/latest/) installed

Before you start, you need to make sure that the environment variables `AWS_ACCESS_KEY_ID`
and `AWS_SECRET_ACCESS_KEY` are set properly (see also `Account` > `Security Credentials` > `Access Credentials` on AWS).

The following will be provisioned during the installation process and you do *NOT* need to take care of it explicitly:

* EC2 instance
* Mesos 0.21.1
* Myriad

## Provisioning on EC2

To start the provisioning process, make sure the above prerequisites are met and then follow the steps below.

0. Provision Mesos cluster

See also the [Mesos EC2 Scripts](http://mesos.apache.org/documentation/latest/ec2-scripts/) doc for details:

```shell
$ cd ~
$ wget http://archive.apache.org/dist/mesos/0.21.0/mesos-0.21.0.tar.gz
$ tar vxzf mesos-0.21.0.tar.gz
$ cd mesos-0.21.0/ec2
$ ./mesos-ec2 -i ~/.ssh/$KEY_FILE_NAME -z $EC2_ZONE launch $CLUSTER_NAME
```

1. Log into the EC2 cluster

```shell
$ ssh ...
$ wget https://raw.githubusercontent.com/mhausenblas/myriad/phase1/provision-ec2.sh
$ ./provision-ec2.sh
```

## Test Cases

TBD 