FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies and Ansible
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible curl git sudo && \
    useradd -m -s /bin/bash anant && \
    echo "anant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    apt-get clean


# Copy Ansible playbook and roles
COPY . /ansible

# Add script to run Ansible playbook
RUN echo '#!/bin/bash\nansible-playbook /ansible/local.yml' > /ansible/run-ansible.sh && \
    chmod +x /ansible/run-ansible.sh

# Set working directory
WORKDIR /ansible

# Switch to user anant
USER anant

# Start a bash shell
CMD ["/bin/bash"]