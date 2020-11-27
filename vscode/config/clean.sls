# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- set sls_package_clean = tplroot ~ '.archive.clean' %}

include:
  - {{ sls_package_clean }}

vscode-config-clean-file-absent:
  file.absent:
    - name: {{ vscode.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
