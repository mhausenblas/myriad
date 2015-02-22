# EC2 setup

You can use the following guide to set up Myriad on AWS [EC2](http://aws.amazon.com/ec2/) in two ways as described below.

* OPTION 1: as a _single instance_, similar to the local Vagrant setup, or
* OPTION 2: as a _cluster_, based on the [Mesos EC2 Script](http://mesos.apache.org/documentation/latest/ec2-scripts/).

## OPTION 1: single instance

### Prerequisites

In order to perform the cluster EC2 provisioning you'll need:

* An [AWS account](http://aws.amazon.com/account/)
* An [EC2 key pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* To have the [AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html) installed

Before you start, you need to make sure that the environment variables `AWS_ACCESS_KEY_ID`
and `AWS_SECRET_ACCESS_KEY` are set properly (see also `Account` > `Security Credentials` > `Access Credentials` on AWS).

```shell
$ ssh ...
$ wget https://raw.githubusercontent.com/mhausenblas/myriad/phase1/provision-ec2.sh
$ ./provision-ec2.sh
```

### Provisioning on EC2



## OPTION 2: cluster

### Prerequisites

In order to perform the cluster EC2 provisioning you'll need:

* An [AWS account](http://aws.amazon.com/account/)
* An [EC2 key pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* To have [boto](http://docs.pythonboto.org/en/latest/) installed

Before you start, you need to make sure that the environment variables `AWS_ACCESS_KEY_ID`
and `AWS_SECRET_ACCESS_KEY` are set properly (see also `Account` > `Security Credentials` > `Access Credentials` on AWS).

The following will be provisioned during the installation process and you do *NOT* need to take care of it explicitly:

* EC2 instances
* Myriad

### Provisioning on EC2

To start the provisioning process, make sure the above prerequisites are met and then follow the steps below.

#### 1. Provision Mesos cluster

See also the [Mesos EC2 Script](http://mesos.apache.org/documentation/latest/ec2-scripts/) doc for details:

```shell
$ cd ~
$ wget http://archive.apache.org/dist/mesos/0.21.0/mesos-0.21.0.tar.gz
$ tar vxzf mesos-0.21.0.tar.gz
$ cd mesos-0.21.0/ec2
$ ./mesos-ec2 -i ~/.ssh/$KEYFILENAME -k $KEYPAIRNAME -z $EC2ZONE -a ami-436ee734 -d git launch $CLUSTER_NAME
```

Note the following concerning the last line, that is calling the Mesos EC2 Script to launch the cluster:

* Make sure you select the `$EC2ZONE` nearest to you, because time and distance is money ;)
* I had to patch the [mesos_ec2.py](https://github.com/apache/mesos/blob/master/ec2/mesos_ec2.py#L466) script to `boto.ec2.connect_to_region('eu-west-1')` otherwise there was an `Invalid availability zone ...` error from the EC2 API.
* The `-a ami-436ee734` is deliberate as otherwise the `mesos_ec2.py` script throws an `The image id '[ami-4517dc2c]' does not exist` error, presumably because the EC2 API call is not working as expecting but YMMV so you might get away with the default Mesos image if it's available in your region.

After the above step you should see something like:

```shell
Setting up security groups...
Checking for running cluster...
Launching instances...
Launched slaves, regid = r-XXXXXXXX
Launched master, regid = r-XXXXXXXX
Waiting for instances to start up...
Waiting 60 more seconds...
Deploying files to master...
...
```

Note that I had to patch the [mesos_ec2.py](https://github.com/apache/mesos/blob/master/ec2/mesos_ec2.py#L508) script to `ubuntu@` otherwise the login wouldn't work. This is due to my choice of the AMI, see above. Now we can log into the cluster:

```shell
$ ./mesos-ec2 -i ~/.ssh/$KEYFILENAME -k $KEYPAIRNAME -z $EC2ZONE login $CLUSTER_NAME
Searching for existing cluster $CLUSTER_NAME...
Found 1 master(s), 1 slaves, 0 ZooKeeper nodes
Logging into master ec2-XXXXXXXXXXXX.compute.amazonaws.com...
Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-44-generic x86_64)
...
ubuntu@ip-XXXXXXXXXXXX:~$
```

#### 2. Install Myriad

TBD.

## Test Cases

TBD 