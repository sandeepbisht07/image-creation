FROM alpine:3.18 AS build

ARG PACKER_VERSION

COPY packer_1.9.1_linux_amd64.zip .

RUN /usr/bin/unzip packer_1.9.1_linux_amd64.zip


FROM gcr.io/google.com/cloudsdktool/cloud-sdk:slim
RUN apt-get -y update && apt-get -y install ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build packer /usr/bin/packer
ENTRYPOINT ["/usr/bin/packer"]