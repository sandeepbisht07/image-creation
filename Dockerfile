FROM alpine:3.18 AS build

COPY packer_1.9.1_linux_amd64.zip .

RUN /usr/bin/unzip packer_1.9.1_linux_amd64.zip


FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim
RUN apt-get -y update && apt-get -y install ca-certificates python3-pip git && rm -rf /var/lib/apt/lists/*
COPY --from=build packer /usr/bin/packer

RUN pip3 install ansible

# Verify Packer and Ansible installation
RUN packer --version
RUN ansible --version

# Default command (can be overridden in Cloud Build steps)
CMD ["bash"]