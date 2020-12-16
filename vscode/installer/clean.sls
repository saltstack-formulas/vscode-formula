# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

vscode-installer-clean-download:
  file.absent:
    - name: {{ vscode.dir.tmp }}

