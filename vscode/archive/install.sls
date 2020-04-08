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
  archive.extracted:
    {{- format_kwargs(vscode.pkg.archive) }}
    - archive_format: {{ vscode.pkg.format }}
    - retry: {{ vscode.retry_option }}
    - user: {{ vscode.rootuser }}
    - group: {{ vscode.rootgroup }}
       {%- if grains.kernel|lower == 'linux' %}
    - enforce_toplevel: false
    - options: '--strip-components=1'
       {%- elif grains.os == 'MacOS' %}endif %}
  cmd.run:
    - name: mv {{ vscode.dir.archive }}/VSCode-linux-x64 {{ vscode.config.path }}
    - require:
      - archive: vscode-package-archive-install-extract
