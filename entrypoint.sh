#!/bin/sh

# generate host keys if not present
ssh-keygen -A

chmod g-w /home/user
chmod 700 /home/user/.ssh
chmod 600 /home/user/.ssh/authorized_keys
chown -R user:user /home/user/.ssh
ls -alt /etc/ssh >/tmp/before
# we first mount the key to the temp folder and now we copy it 
# to prevent mounting issues (probably a docker windows issue)
cp /tmp/luminate.pub /etc/ssh/luminate.pub
ls -alt /etc/ssh >/tmp/after_copy

/usr/sbin/sshd -E /var/log/ssh-$HOSTNAME.log
sleep 10000000
