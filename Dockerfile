FROM ubuntu:20.04

# Set environment variables for dynamic versioning
ENV PACKER_VERSION=1.9.1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    unzip \
    python3-pip \
    git \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && pip3 install ansible

RUN curl -Lo /tmp/packer.zip "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    unzip /tmp/packer.zip -d /usr/bin/ && \
    chmod +x /usr/bin/packer


# Verify Packer and Ansible installation

RUN ansible --version && packer --version

# Set default command
CMD ["bash"]