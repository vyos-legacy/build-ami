FROM debian:jessie-slim

ENV debian_frontend=noninteractive
RUN apt-get update && apt-get install -y \
  python-pip \
  python-dev \
  libssl-dev \
  libyaml-dev \
  libffi-dev \
  ssh \
&& rm -rf /var/lib/apt/lists/*

# AWSCLI
RUN pip install awscli boto

# ANSIBLE
RUN pip install --upgrade cffi
RUN pip install ansible

# REMOVE host_key_checking in ansible
ENV ANSIBLE_HOST_KEY_CHECKING=False

WORKDIR /build-ami
