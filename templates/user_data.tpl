#cloud-config
# vim: syntax=yaml
hostname: ${host_name}
manage_etc_hosts: true
users:
  - name: vmadmin
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/ubuntu
    shell: /bin/bash
    lock_passwd: false
    ssh_authorized_keys:
      - ${auth_key}
  - name: ansible
    groups: users, admin
    home: /home/ubuntu
    shell: /bin/bash
    lock_passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${auth_key}
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    vmadmin:linux-pass
    ansible:ansiblepass
  expire: false
write_files:
  - path: /etc/ssh/sshd_config
    content: |
      #   Port 22
      #   Protocol 2
         HostKey /etc/ssh/ssh_host_rsa_key
         HostKey /etc/ssh/ssh_host_dsa_key
         HostKey /etc/ssh/ssh_host_ecdsa_key
         HostKey /etc/ssh/ssh_host_ed25519_key
         UsePrivilegeSeparation yes
         KeyRegenerationInterval 3600
         ServerKeyBits 1024
         SyslogFacility AUTH
         LogLevel INFO
         LoginGraceTime 120
         PermitRootLogin yes
         StrictModes yes
         RSAAuthentication yes
         PubkeyAuthentication yes
         IgnoreRhosts yes
         RhostsRSAAuthentication no
         HostbasedAuthentication no
         PermitEmptyPasswords yes
         ChallengeResponseAuthentication no
      #   X11Forwarding yes
      #   X11DisplayOffset 10
         PrintMotd no
         PrintLastLog yes
         TCPKeepAlive yes
         AcceptEnv LANG LC_*
         Subsystem sftp /usr/lib/openssh/sftp-server
         UsePAM yes
         AllowUsers ansible
growpart:
  mode: auto
  devices: ['/']

package_update: true
package_upgrade: true
package_reboot_if_required: true

packages:
  - python3
  - ansible
