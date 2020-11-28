FROM debian:buster-slim
# FROM debian:stretch-20200327-slim
LABEL maintainer="Milan Das <milan.das77@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive
ENV KUBE_LATEST_VERSION="v1.15.1"
RUN apt-get update
RUN apt-get install apt-utils wget curl git jq dnsutils nmap netcat -yq
RUN apt-get update && apt-get install -y gnupg2

# 
# RUN apt-get install python3 python-pip3 -yq
# RUN pip install awscli
# RUN mkdir -p /usr/share/man/man1
# 
# RUN apt-get update
# RUN apt-get install openjdk-8-jdk-headless -yq
# Clean up APT when done.
RUN  apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev iputils-ping -y
RUN apt-get install python3.7 -y
RUN cd /tmp
RUN cd /tmp && curl -O http://download.redis.io/redis-stable.tar.gz
RUN cd /tmp && tar xvzf redis-stable.tar.gz && cd redis-stable && make &&  cp src/redis-cli /usr/local/bin/ &&  chmod 755 /usr/local/bin/redis-cli
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN  apt-get update &&  apt-get install -y apt-transport-https gnupg2 lsb-release ca-certificates  python-pip
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" |  tee -a /etc/apt/sources.list.d/kubernetes.list
RUN  apt-get update
RUN  apt-get install -y kubectl
# Install Azure CLI
RUN cd /tmp && curl -sL https://aka.ms/InstallAzureCLIDeb |  bash

# Install python3
RUN  apt-get install -y python-pip python3-venv unzip
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
RUN python --version
# Install gcloud CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |  tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN  apt-get update &&  apt-get install google-cloud-sdk -y

# Install AWS CLI

RUN cd /tmp
RUN cd /tmp && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN cd /tmp && unzip awscli-bundle.zip
RUN cd /tmp && ./awscli-bundle/install -b ~/bin/aws
RUN cd /tmp && curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN cd /tmp && mv /tmp/eksctl /usr/local/bin;eksctl version
RUN cd /tmp && curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator
RUN cd /tmp && chmod 755 ./aws-iam-authenticator
RUN cd /tmp && mv aws-iam-authenticator /usr/local/bin


# Install helm
RUN cd /tmp
RUN cd /tmp && curl --silent --location "https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz" | tar xz -C /tmp
RUN cd /tmp && pwd && ls -l

RUN cd /tmp && chmod 755 linux-amd64/helm
RUN cd /tmp && mv linux-amd64/helm  /usr/local/bin

# Install JDK
RUN mkdir -p /usr/share/man/man1
RUN apt-get install -y openjdk-11-jdk
RUN java -version
# Clean up

# Install other tools
RUN apt-get install -y fzf
RUN rm -rf /tmp/*
