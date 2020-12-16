# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

vscode-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ vscode.dir.archive }}
      - {{ vscode.dir.tmp }}
      {%- if vscode.config.path != None %}
      - {{ vscode.config.path }}
      {%- endif %}

