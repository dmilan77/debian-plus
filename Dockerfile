FROM debian:stretch-20191014-slim
LABEL maintainer="Milan Das <milan.das77@gmail.com>"
ENV KUBE_LATEST_VERSION="v1.15.1"
RUN apt update
RUN apt install curl git jq dnsutils nmap -y 
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl && chmod +x /usr/bin/kubectl 
RUN apt-get install python python-pip -y
RUN pip install awscli
RUN mkdir -p /usr/share/man/man1

RUN apt-get update
RUN apt-get install openjdk-8-jdk-headless -y
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


