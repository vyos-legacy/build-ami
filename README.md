VyOS build-ami
--------------

**NOTE:** You can support the VyOS development by using the official VyOS AMI from the marketplace: https://aws.amazon.com/marketplace/pp/B074KJK4WC
(starting from $50/year).

The official AMIs are built with these exact scripts so if you build one for yourself, your own AMI will be functionally identical to the official ones.

## Requirements

The build scripts are based on ansible and awscli.

To install and configure awscli, follow the user guide: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html
Make sure the python module boto also gets installed.

Ansible is available from the repositories on most Linux distributions.

These scripts and playbooks should work on any Linux system, or, theoretically, on any system supported by ansible and awscli.

## Usage

```
./vyos-build-ami.sh <VyOS ISO URL>
```

**NOTE:** At this time the playbooks have some limitations:
* The argument must be a URL, e.g. http://packages.vyos.net/iso/release/1.1.7/vyos-1.1.7-amd64.iso , local files are not supported
* There **must** be a GPG signature file for the image in the same dir on the server
* 1.2.0 beta images are not yet supported
* No way to specify the region, so make sure you configure it in awscli settings

These limitations will be fixed in the future.

So, for VyOS 1.1.7 the command will be:
```
./vyos-build-ami.sh http://packages.vyos.net/iso/release/1.1.7/vyos-1.1.7-amd64.iso
```

## Operation

Since there is no way to upload a disk image to AWS directly, the playbooks create an Ubuntu instance and run a sequence of commands to create an EBS disk and unpack the
VyOS image to it, emulating the installation procedure.

## Troubleshooting

**NOTE:** If playbook fails, a medium size instance is left running. Make sure to clean up any leftover instances if you restart the playbook after failures.

Sometimes playbook tasks fail through no one's fault, for example, SSH timeouts if an instance takes too long to create.

Note that AMI name is fixed, and registering the AMI will fail if you try to run the playbooks when you already have one in your account. De-register the old one first.

## License

These scripts are available under the MIT license. See the LICENSE file for more info.

build-ami playbooks were originally written by hydrajump (https://github.com/hydrajump) and are now maintained
by the VyOS team.
