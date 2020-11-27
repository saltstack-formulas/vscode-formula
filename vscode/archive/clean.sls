# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

vscode-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ vscode.pkg.archive.name }}
      - {{ vscode.config.path }}
      - {{ vscode.dir.tmp }}
