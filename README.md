VyOS build-ami
--------------

**NOTE:** You can support VyOS development by using the official VyOS AMI from the marketplace: https://aws.amazon.com/marketplace/pp/B074KJK4WC
(starting from $50/year).

The official AMIs are built with these exact scripts so if you build one for yourself, your own AMI will be functionally identical to the official ones.

## Prerequisites

VyOS images built with default `make iso` options *do not* include EC2 autoconfiguration mechanism).

To make an image suitable for an AMI, do this instead:

```
./configure
sudo make AWS
```

## Requirements

The build scripts are based on ansible and awscli.

To install and configure awscli, follow the user guide: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html
Make sure the python modules boto, botocore, and boto3 also gets installed.

Ansible is available from the repositories on most Linux distributions.

These scripts and playbooks should work on any Linux system, or, theoretically, on any system supported by ansible and awscli.

At this time Python3 support is limited by its supports by ansible, so it's safer to use Python 2.7.

## Usage

```
./vyos-build-ami <VyOS ISO URL>
```

The baseline code now supports only VyOS >=1.2.0. If you want to build an AMI from VyOS 1.1.x, check out the 1.1.x tag.

## Operation

Since there is no easy way to upload a disk image to AWS directly, the playbooks create a Debian Jessie instance and run a sequence of commands to create an EBS disk and unpack the
VyOS image to it, emulating the installation procedure.

## Troubleshooting

**NOTE:** If playbook fails, it leaves behind a t2.micro instance, an SSH key pair names "vyos-build-ami", and a security group also named "vyos-build-ami".
If you want to restart the process from the beginning, remove those by hand.

Sometimes playbook tasks fail through no one's fault, for example, SSH timeouts if an instance takes too long to create.

Note that AMI name is fixed, and registering the AMI will fail if you try to run the playbooks when you already have one in your account. De-register the old one first.

## License

These scripts are available under the MIT license. See the LICENSE file for more info.

build-ami playbooks were originally written by hydrajump (https://github.com/hydrajump) and are now maintained
by the VyOS team.
