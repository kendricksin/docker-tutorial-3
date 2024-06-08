# Use an appropriate base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    virt-manager \
    openssh-server

# Set up the SSH server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/Port 22/Port 2222/' /etc/ssh/sshd_config
EXPOSE 2222

# Copy a VM image into the container (assuming you have an image called 'vm.img')
COPY vm.img /root/vm.img

# Start the SSH service and QEMU VM
CMD service ssh start && qemu-system-x86_64 -hda /root/vm.img -m 1024 -enable-kvm
