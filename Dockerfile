From centos:latest


yum install openssh-server -y 

yum install openjedk-8-jre -y

RUN mkdir /var/run/sshd

RUN echo 'root:redhatRUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' | chpasswd

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


#now_kubetcl_setup

Run yum install curl -y

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl


CMD ["/usr/sbin/sshd", "-D"]








