.. _readme:

vscode-formula
===============

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/vscode-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/vscode-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Formula to install Visual Studio Code on GNU/Linux, MacOS, and Windows.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Available states
----------------

.. contents::
   :local:

``vscode``
^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs VSCode and Newman packages

``vscode.package``
^^^^^^^^^^^^^^^^^^

This state will install VSCode package on MacOS (brew) and GNU/Linux (snap).

``vscode.archive``
^^^^^^^^^^^^^^^^^^

This state will install VSCode on GNU/Linux and Windows from archive.

``vscode.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove VSCode archive from GNU/Linux and Windows.

``vscode.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove VSCode package from MacOS and GNU/Linux.

``vscode.clean``
^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``vscode`` meta-state in reverse order.

``vscode.installer``
^^^^^^^^^^^^^^^^^^^

This state runs the interactive Visual Studio Installer on Windows (BuildTools, etc).

``vscode.installer.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state cleans up Visual Studio Installer download on Windows.



Testing
-------

GNU/Linux testing is done with ``kitchen-salt``.

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

Creates the docker instance and runs the ``vscode`` main state, ready for testing.

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

