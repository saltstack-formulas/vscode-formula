# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

    {%- if vscode.environ_file %}
        {%- set sls_package_clean = tplroot ~ '.archive.clean' %}
        {%- set sls_installer_clean = tplroot ~ '.installer.clean' %}

include:
  - {{ sls_installer_clean if grains.os|lower == 'windows' else sls_package_clean }}

vscode-config-clean-file-absent:
  file.absent:
    - name: {{ vscode.environ_file }}
    - require:
      - sls: {{ sls_installer_clean if grains.os|lower == 'windows' else sls_package_clean }}

    {%- endif %}
