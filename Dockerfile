FROM ubuntu:20.04

RUN apt update \
	&& apt install --yes software-properties-common \
	&& apt-add-repository --yes --update ppa:ansible/ansible; \
	apt install --yes ansible \
	&& ansible-galaxy collection install --force ibm.ibm_zos_core

RUN apt install -y sshpass; apt install -y expect

WORKDIR /usr/local/bin

COPY zosible ./
COPY .zosible/ ./.zosible/

WORKDIR /mnt

ENTRYPOINT ["/usr/local/bin/.zosible/zosbash"]