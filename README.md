# vyos-build-ami [![Build Status](https://travis-ci.org/vyos/vyos-build-ami.svg?branch=master)](https://travis-ci.org/vyos/vyos-build-ami)

>vyos-build-ami is a fully automated build system for VyOS AMIs (Amazon Machine Images)

>Builds the official [VyOS AMIs](https://aws.amazon.com/marketplace/pp/B00JK5UPF6) available on the AWS Marketplace

vyos-build-ami is a fully automated build system for VyOS AMIs defined in [Ansible](http://ansible.com/) playbooks. The build process is self-contained in an EC2 instance launched by the playbooks and the resulting AMIs are never booted prior to release. This is no different from installing VyOS via a release ISO image on a non-AWS (Amazon Web Services) platform.

## Background and Motivation

[VyOS](http://vyos.net) is a fork of Vyatta, which came in two flavours: open-source and commerical. Unfortunately, the only official AMI available on the [AWS Marketplace](https://aws.amazon.com/marketplace/) is the latter. Until now...**UPDATE 11th April 2014 the official VyOS AMIs are now [available](https://aws.amazon.com/marketplace/pp/B00JK5UPF6).**

Initially, I created a [recipe]() to build a VyOS AMI based on [j3tm0t0's blog post](http://d.hatena.ne.jp/j3tm0t0/20131026/1382797766) with some linguistic help from Google Translate. However, the process required manual intervention and is not suitable for building and releasing dependable AMIs.

`vyos-build-ami` is a culmination of the lessons I learnt from creating my manual build recipe and a lot of head bashing. The build process is 100% automated through all phases: building, testing and releasing. In addition, build parameters are easily set in a single configuration file to accomodate new VyOS releases.

I've built this project using Ansible, which offers a number of advantages over custom scripting including:

>- Simplicity and maximum ease of use.
>- Strong focus on security and reliability.
>- Uses a language that is designed around auditability by humans – even those not familiar with the program.


## AMI Features

- Architecture: x86_64
- Virtualization type: HVM (Hardware Virtual Machine)
    - Only current generation instances e.g. M3 instances providing better and more consistent performance at lower prices than M1 instances.
- EBS root volume: 4 GB
- Enhanced networking (higher packet per second performance, lower latencies and lower network jitter).
    - Only available with C3 and I2 instances.
- Only SSH passwordless access using SSH key pair.

### Cost Comparison

A quick comparison between running a VyOS AMI and the commercial Vyatta VSE AMI.

- Region: N. Virginia (us-east-1)
- Comparable instance type for each AMI
- 4 GB EBS volume
- 1 month run time ~730 hours

```shell
Vyatta VSE AMI m1.medium (PV)

Software: $0.60/Hour
Instance m1.medium (1 vCPU, 2 ECU, 3.75 GiB Memory): $0.087/Hour
Storage Standard EBS: $0.05/ GB /Month

Total = ( $0.60 + $0.087 ) * 730 + ( $0.05 * 4 ) = $501.71/Month
```

```shell
VyOS AMI m3.medium (HVM)

Software: FREE
Instance m3.medium (1 vCPU, 3 ECU, 3.75 GiB Memory): $0.070/Hour
Storage Standard EBS: $0.05/ GB /Month

Total = ( FREE + $0.070 ) * 730 + ( $0.05 * 4 ) = $51.3/Month
```

Note: Calculations do not account for data transfer costs. Amazon EC2 prices effective April 1st, 2014.


## Requirements

You will need the following:

- AWS CLI (AWS Command Line Interface)
    - An AWS account
    - Your AWS access key ID and secret access key
- Ansible
- `vyos-build-ami` playbooks


## Installation

Follow these simple steps if you are missing any of the requirements.

### 1. Sign up for an AWS account and get your access key ID and secret access key

```shell
Sign Up
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#cli-signup
```

### 2. Install AWS CLI

```shell
Install the AWS CLI Using the MSI Installer (Windows)
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#install-msi-on-windows

Install the AWS CLI Using the Bundled Installer (Linux, OS X, or Unix)
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#install-bundle-other-os

Install the AWS CLI Using pip (Windows, Linux, OS X, or Unix)
http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#install-with-pip

Install the AWS CLI Using the Homebrew package manager on Mac OS X
brew install awscli
```

### 3. Test the AWS CLI installation

```shell
$ aws help
```

If the test is successful, you will see the help displayed.

### 4. Install Ansible

```shell
Install Ansible (all platforms)
http://docs.ansible.com/intro_installation.html

Mac OS X using Homebrew
brew install ansible
```

### 5. Test the Ansible installation

```shell
$ ansible --help
```

If the test is successful, you will see the help displayed.

### 6. Get vyos-build-ami playbooks

```shell
$ git clone https://github.com/hydrajump/vyos-build-ami.git
```


## Configuration

### 1. Configure AWS CLI

You need to configure the AWS CLI with your AWS access key ID and secret access key from step 1 in the installation section above.

```shell
$ aws configure
AWS Access Key ID [None]: YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_AWS_SECRET_ACCESS_KEY
Default region name [None]: SELECT_A_REGION_FROM_THE_LIST_BELOW
Default output format [None]: text
```

Note: `Default output format` **must** be set to `text` for `vyos-build-ami`.

You can select a `Default region name` from the following list:

```shell
US East (Northern Virginia) Region    us-east-1
US West (Oregon) Region               us-west-2
US West (Northern California) Region  us-west-1
EU (Ireland) Region                   eu-west-1
Asia Pacific (Singapore) Region       ap-southeast-1
Asia Pacific (Sydney) Region          ap-southeast-2
Asia Pacific (Tokyo) Region           ap-northeast-1
South America (Sao Paulo) Region      sa-east-1
```

Note: It doesn't matter which region you choose, but you **must** set a region.

### 2. Configure vyos-build-ami

Coming soon...


## Usage

Run the vyos-build-ami playbooks.

```shell
$ cd vyos-build-ami
$ ./vyos-build-ami.sh
```

VyOS AMIs built, tested and released.

Have fun ;)

## How It Works

Coming soon...


## Contact

[hydrajump](https://github.com/hydrajump)

[@hydrajump](https://twitter.com/hydrajump)


## License

`vyos-build-ami` is available under the MIT license. See the LICENSE file for more info.
