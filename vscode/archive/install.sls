# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

vscode-package-archive-install-extract:
  pkg.installed:
    - names:
      - curl
      - tar
      - unzip
  file.directory:
    - name: {{ vscode.pkg.archive.name }}
    - user: {{ vscode.rootuser }}
    - group: {{ vscode.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: vscode-package-archive-install-extract
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(vscode.pkg.archive) }}
    - archive_format: {{ vscode.pkg.format }}
    - retry: {{ vscode.retry_option }}
    - user: {{ vscode.rootuser }}
    - group: {{ vscode.rootgroup }}
       {%- if grains.kernel|lower == 'linux' %}
    - enforce_toplevel: false
    - options: '--strip-components=1'
       {%- endif %}
  cmd.run:
    - names:
      - mv {{ vscode.pkg.archive.name }}/VSCode-linux-x64/* {{ vscode.pkg.archive.name }}/
      - rm -fr {{ vscode.pkg.archive.name }}/VSCode-linux-x64 

