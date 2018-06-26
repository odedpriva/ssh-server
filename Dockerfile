FROM alpine:3.6
MAINTAINER Luminate Security
RUN adduser -D -s /bin/ash user && passwd -u user && chown -R user:user /home/user
RUN adduser -D -s /bin/ash user2 && passwd -u user2 && chown -R user2:user2 /home/user2

RUN apk add --no-cache openssh
COPY ca_key.pub /etc/ssh/luminate.pub

RUN echo 'LogLevel DEBUG3' >> /etc/ssh/sshd_config
RUN echo 'TrustedUserCAKeys /etc/ssh/luminate.pub' >> /etc/ssh/sshd_config

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]