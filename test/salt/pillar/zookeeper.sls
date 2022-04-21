# -*- coding: utf-8 -*-
# vim: ft=yaml
---
zookeeper:
  pkg:
    name: zookeeper
    downloadurl: >
      https://dlcdn.apache.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz 
    version: 3.8.0
    installdir: /opt

    # OpenJDK package name on system; defaults to an empty string, which avoids
    # installing OpenJDK.  Overridden in the `os*map.yaml` files.
    javajdk: ''

  systemdconfig:
    user: root
    group: root
    limitnofile: 50000
    limitnproc: 10000

  rootgroup: root
  config: 'zoo.cfg'
  service:
    name: zookeeper

  zookeeperproperties:
    tickTime: 2000
    dataDir: ./state/zookeeper
    clientPort: 2181
    initLimit: 5
    syncLimit: 2

    customservers: {}
