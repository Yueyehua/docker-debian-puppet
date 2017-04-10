FROM yueyehua/debian-ruby:latest
MAINTAINER Richard Delaplace "rdelaplace@yueyehua.net"
LABEL version="1.0.0"

# Install puppet with lint tools
RUN \
  apt-get -qq update && \
  apt-get -qq install -y puppet puppet-lint && \
  apt-get -qq clean autoclean

# Install gems
RUN \
  /root/.rbenv/shims/gem install \
    -q --no-rdoc --no-ri --no-format-executable --no-user-install \
    berkshelf busser busser-serverspec serverspec webmock librarian-puppet;

# Mask failing services
RUN \
  systemctl mask -- \
    sys-fs-fuse-connections.mount \
    dev-hugepages.mount \
    systemd-tmpfiles-setup.service;

VOLUME ["/sys/fs/cgroup", "/run", "/run/lock"]
CMD  ["/lib/systemd/systemd"]
