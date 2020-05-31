From centos:latest


RUN yum install openssh-server -y 

RUN yum install java-11-openjdk.x86_64 -y


RUN yum install httpd -y

RUN mkdir /var/run/sshd


RUN echo 'root:redhat' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' | chpasswd

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


COPY code.html /var/www/html/


#now_kubetcl_setup

Run yum install curl -y

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

EXPOSE 80


EXPOSE 22


CMD ["/usr/sbin/sshd", "-D"]


CMD ["/usr/sbin/httpd","-D","FOREGROUND"]










