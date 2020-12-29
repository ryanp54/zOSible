FROM ubuntu:20.04

RUN apt update \
	&& apt install --yes software-properties-common \
	&& apt-add-repository --yes --update ppa:ansible/ansible; \
	apt install --yes ansible \
	&& ansible-galaxy collection install --force ibm.ibm_zos_core:1.2.1

RUN apt install -y sshpass; apt install -y expect

COPY bin/ /usr/local/bin/
COPY lib/zos_tso_command.py /root/.ansible/collections/ansible_collections/ibm/ibm_zos_core/plugins/modules/

WORKDIR /mnt

ENTRYPOINT ["/usr/local/bin/.zosbash"]