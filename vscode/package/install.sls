# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

    {%- if grains.os_family == 'MacOS' %}

vscode-package-install-cmd-run-cask:
  cmd.run:
    - name: brew cask install {{ vscode.pkg.name }}
    - runas: {{ vscode.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

vscode-package-install-cmd-run-snap:
  cmd.run:
    - name: snap install code
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- elif grains.os|lower == 'windows' %}

vscode-package-install-choco:
  chocolatey.installed:
    - name: vscode.install
    - force: {{ vscode.misc.force }}

    {%- endif %]
