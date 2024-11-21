FROM ubuntu:20.04 AS build

COPY packer_1.9.1_linux_amd64.zip .

RUN apt-get -y update && apt-get -y install ca-certificates python3-pip git unzip && rm -rf /var/lib/apt/lists/*

COPY packer_1.9.1_linux_amd64.zip .

RUN /usr/bin/unzip packer_1.9.1_linux_amd64.zip
COPY --from=build packer /usr/bin/packer

RUN pip3 install ansible

# Verify Packer and Ansible installation
RUN packer --version
RUN ansible --version

# Default command (can be overridden in Cloud Build steps)
CMD ["bash"]