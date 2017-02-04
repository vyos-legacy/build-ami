FROM debian:jessie-slim
ENV debian_frontend=noninteractive

RUN apt-get update && apt-get install python-pip python-dev libssl-dev -y
RUN apt-get install libffi-dev libyaml-dev -y
# AWSCLI
RUN pip install awscli boto

# ANSIBLE
RUN pip install --upgrade cffi
RUN pip install ansible
RUN apt-get update && apt-get install ssh -y
RUN mkdir -p /root/.ssh/ && echo Host * > /root/.ssh/config
RUN echo StrictHostKeyChecking no >> /root/.ssh/config
RUN echo UserKnownHostsFile=/dev/null >> /root/.ssh/config
