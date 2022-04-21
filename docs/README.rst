.. _readme:

zookeeper-formula
================

Installs and Configures Apache Zookeeper from a tar file.

|img_travis| |img_sr| |img_pc|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/zookeeper-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/zookeeper-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release
.. |img_pc| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :alt: pre-commit
   :scale: 100%
   :target: https://github.com/pre-commit/pre-commit

A SaltStack formula that is empty. It has dummy content to help with a quick
start on a new formula and it serves as a style guide.

.. contents:: **Table of Contents**
   :depth: 1

Apply notes
-------------
Based on zookeeper formula from github.
This state setup standalone or clustered zookeeper.
For clustered zookeeper we must create a zookeeper_cluster variable in
pillar/servers/nameofenv.sls like that:

zookeeper_cluster:
{{macros.select_cluster_list(id,'zookeeper')}} *

This will return a list with all the members of the cluster. Later this list will be change to a dict(needed by formula) in the pillar/zookeeper/init.sls file.If the zookeeper_cluster is missing then it will proceed to standalone setup.

In the pillar file we can
- Pass some variables that will replace the defaults from zookeeper/defaults.yaml.

- Specify java version in the pillar file. If not it defaults to java-11 from zookeeper/osfamilymap.yaml.

- Specify the user that zookeeper service run at pillar file in systemdconfig.user and systemdconfig.group

- Specify downloadurl and version of zookeeper to be installed. If not it default to 3.6.2 version.


With state.apply zookeeper.clean it removes the serivce file the pkg and the conf folder.

* for that macro to return list we must specify in the roster file grain.roles zookeeper or zookeeper-cluster.

NOTE there is an example pillar file that i worked in the testing. 

Available states
----------------

.. contents::
   :local:

``zookeeper``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the zookeeper package,
manages the zookeeper configuration file and then
starts the associated zookeeper service.

``zookeeper.package``
^^^^^^^^^^^^^^^^^^^^

This state will install the zookeeper package only.

``zookeeper.config``
^^^^^^^^^^^^^^^^^^^

This state will configure the zookeeper service and has a dependency on ``zookeeper.install``
via include list.

``zookeeper.service``
^^^^^^^^^^^^^^^^^^^^

This state will start the zookeeper service and has a dependency on ``zookeeper.config``
via include list.

``zookeeper.clean``
^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``zookeeper`` meta-state in reverse order, i.e.
stops the service,
removes the configuration file and
then uninstalls the package.

``zookeeper.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the zookeeper service and disable it at boot time.

``zookeeper.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the zookeeper service and has a
dependency on ``zookeeper.service.clean`` via include list.

``zookeeper.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the zookeeper package and has a depency on
``zookeeper.config.clean`` via include list.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``zookeeper`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

