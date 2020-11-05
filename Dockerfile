FROM debian:stretch-20200327-slim
LABEL maintainer="Milan Das <milan.das77@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive
ENV KUBE_LATEST_VERSION="v1.15.1"
RUN apt-get update
RUN apt-get install apt-utils wget curl git jq dnsutils nmap netcat -yq
RUN apt-get update && apt-get install -y gnupg2
#RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl && chmod +x /usr/bin/kubectl 
# RUN apt-get update && apt-get install -y apt-transport-https
# RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
# RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
# RUN apt-get update
# RUN apt-get install -y kubectl
# 
# RUN apt-get install python3 python-pip3 -yq
# RUN pip install awscli
# RUN mkdir -p /usr/share/man/man1
# 
# RUN apt-get update
# RUN apt-get install openjdk-8-jdk-headless -yq
# Clean up APT when done.
RUN  apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev -y
RUN /tmp
RUN curl -O https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tar.xz 
RUN tar -xf Python-3.8.6.tar.xz  && cd Python-3.8.6 && ./configure --enable-optimizations && make -j 4 &&   make altinstall
RUN /tmp
RUN curl -O http://download.redis.io/redis-stable.tar.gz
RUN tar xvzf redis-stable.tar.gz && cd redis-stable && make &&  cp src/redis-cli /usr/local/bin/ &&  chmod 755 /usr/local/bin/redis-cli
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


