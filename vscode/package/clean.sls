# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

    {%- if grains.os_family == 'MacOS' %}

vscode-package-remove-cmd-run-cask:
  cmd.run:
    - name: brew cask remove {{ vscode.pkg.name }}
    - runas: {{ vscode.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

vscode-package-remove-cmd-run-snap:
  cmd.run:
    - name: snap remove code
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- elif grains.os|lower == 'windows' %}

vscode-package-remove-choco:
  chocolatey.uninstalled:
    - name: vscode.install

    {%- endif %}
