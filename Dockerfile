FROM debian:stretch-20191014-slim
LABEL maintainer="Milan Das <milan.das77@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive
ENV KUBE_LATEST_VERSION="v1.15.1"
RUN apt-get update
RUN apt-get install apt-utils wget curl git jq dnsutils nmap netcat -yq
RUN apt-get update && apt-get install -y gnupg2
#RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl && chmod +x /usr/bin/kubectl 
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

RUN apt-get install python python-pip -yq
RUN pip install awscli
RUN mkdir -p /usr/share/man/man1

RUN apt-get update
RUN apt-get install openjdk-8-jdk-headless -yq
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


