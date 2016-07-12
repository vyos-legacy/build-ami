VyOS build-ami
--------------

**NOTE:** There are official VyOS AMIs on the AWS Marketplace: https://aws.amazon.com/marketplace/pp/B00JK5UPF6


[![Build Status](https://travis-ci.org/vyos/build-ami.svg?branch=master)](https://travis-ci.org/vyos/build-ami)

# Overview

These are ansible playbooks VyOS maintainers use to create the official AMI (Amazon Machine Image, for EC2) that is available from the AWS Marketplace.

Even if you are not a VyOS maintainer, they still may be useful for you if you want to make your own customized AMIs or bring VyOS to regions
where it is not available yet.

## AMI Features

- Architecture: x86_64
- Virtualization type: HVM (Hardware Virtual Machine)
    - Only current generation instances e.g. M3 instances providing better and more consistent performance at lower prices than M1 instances.
- EBS root volume: 4 GB
- Enhanced networking (higher packet per second performance, lower latencies and lower network jitter).
    - Only available with C3 and I2 instances.
- Only SSH passwordless access using SSH key pair.


## Requirements

You will need the following:

- AWS CLI (AWS Command Line Interface)
    - An AWS account
    - Your AWS access key ID and secret access key
- Ansible
- `build-ami` playbooks


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
On Linux, it's usually in the repositories.

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
$ git clone https://github.com/vyos/build-ami.git
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

## Usage

Run the vyos-build-ami playbooks.

```shell
$ cd vyos-build-ami
$ ./vyos-build-ami.sh -e iso=<VyOS ISO URL>
```


## License

`build-ami` is available under the MIT license. See the LICENSE file for more info.

build-ami playbooks were originally written by hydrajump (https://github.com/hydrajump) and are now maintained
by the VyOS team.
