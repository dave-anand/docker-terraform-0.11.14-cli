FROM anand000/docker-aws-cli

# Get - Terraform
RUN \
    export TERRAFORM_VERSION=0.11.14 \
    && export TERRAFORM_CHECKSUM=$( \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS | \
    grep linux_amd64.zip | \
    awk '{print $1}') \
    && curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip\
    && echo "$TERRAFORM_CHECKSUM  /tmp/terraform.zip" | sha256sum -c - \
    && unzip /tmp/terraform.zip -d /usr/local/bin \
    && rm /tmp/terraform.zip

# Config - Terraform
ENV TF_DATA_DIR "/root/.terraform"
COPY dot_terraformrc /root/.terraformrc

# Entrypoint
ENTRYPOINT /bin/bash
