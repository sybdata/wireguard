FROM debian:buster-slim
LABEL description="Wireguard VPN" org.opencontainers.image.authors="github.com/denisix"

MAINTAINER denisix <denisix@gmail.com>
# NAT=1                  - Should we use NAT for our clients? - Yes, by default
# INTERFACE=eth0         - Which interface to use?
# PORT=55555             - Port to use for WireGuard
# PUBLIC_IP=1.2.3.4      - Server's public IP address
# DNS=1.1.1.1            - Custom DNS servers
# SUBNET=10.88           - Your private subnet without dynamic part
# SUBNET_PREFIX=16       - Your private subnet prefix, i.e. 10.88.0.0/16
# SUBNET_IP=10.88.0.1/16 - fist IP in private subnet (with subnet declaration)
# CLIENTCONTROL_NO_LOGS=0 - Turn off clientcontrol logs
# WG_CLIENTS_UNSAFE_PERMISSIONS=0 - Use unsafe (744) permissions in /etc/wireguard/clients

ENV \
  SUBNET_PREFIX=16 \
  NAT=1 \
  INTERFACE=eth0 \
  PORT=55555 \
  PUBLIC_IP=1.2.3.4 \
  DNS="1.1.1.1, 1.0.0.1" \
  SUBNET=10.88 \
  SUBNET_PREFIX=16 \
  SUBNET_IP=10.88.0.1/16 \
  CLIENTCONTROL_NO_LOGS=0 \
  WG_CLIENTS_UNSAFE_PERMISSIONS=0 \
  PATH="/srv:$PATH"

ARG DEBIAN_FRONTEND=noninteractive
VOLUME /etc/wireguard
EXPOSE 55555/udp

# Copy tools
WORKDIR /srv
COPY start restart addclient clientcontrol /srv/

# Install WireGuard and dependencies
# hadolint ignore=DL3008
RUN chmod 755 /srv/* \
    && echo "deb http://deb.debian.org/debian/ buster-backports main" > /etc/apt/sources.list.d/buster-backports.list \
    && apt-get update \
    && apt-get -qq install -y --no-install-recommends wireguard-tools iptables inotify-tools net-tools qrencode openresolv procps curl iproute2 \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=5s --timeout=5s CMD /sbin/ip -o li sh wg0 || exit 1

# Entrypoint
CMD [ "start" ]
