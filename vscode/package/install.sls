# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

    {%- if grains.os_family == 'MacOS' %}

vscode-package-install-cmd-run-cask:
  cmd.run:
    - name: brew cask install {{ vscode.pkg.package.name }}
    - runas: {{ vscode.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

vscode-package-install-cmd-run-snap:
  cmd.run:
    - name: snap install {{ vscode.pkg.package.name }}
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- endif %]
