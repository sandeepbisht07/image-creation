FROM ubuntu:20.04 AS build

# Set environment variables for dynamic versioning
ENV PACKER_VERSION=1.9.1

# Install required packages, download and set up Packer, and install Ansible
RUN apt-get update && apt-get install -y \
    ca-certificates python3-pip git unzip curl && \
    curl -Lo /usr/bin/packer "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    chmod +x /usr/bin/packer && \
    pip3 install ansible && \
    rm -rf /var/lib/apt/lists/*

# Verify Packer and Ansible installation
RUN packer --version && ansible --version

# Set default command
CMD ["bash"]