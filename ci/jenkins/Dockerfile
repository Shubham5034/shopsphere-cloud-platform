FROM jenkins/jenkins:lts

USER root

# ---------------------------------------------------------
# Base packages + Docker CLI
# ---------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        curl \
        unzip \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*


# ---------------------------------------------------------
# AWS CLI v2
# ---------------------------------------------------------
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
        -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip


# ---------------------------------------------------------
# kubectl
# ---------------------------------------------------------
RUN curl -LO \
    "https://dl.k8s.io/release/v1.35.0/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl


# ---------------------------------------------------------
# Helm
# ---------------------------------------------------------
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    | bash


USER jenkins
