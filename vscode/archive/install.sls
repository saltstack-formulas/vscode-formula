# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

vscode-package-archive-install-extract:
  pkg.installed:
    - names: {{ vscode.pkg.deps }}
  file.directory:
    - name: {{ vscode.pkg.archive.name }}
                 {%- if vscode.pkg.archive.name != '/Applications' %}
    - user: {{ vscode.rootuser }}
    - group: {{ vscode.rootgroup }}
    - mode: 755
                 {%- endif %}
    - makedirs: True
    - require_in:
      - archive: vscode-package-archive-install-extract
  archive.extracted:
    {{- format_kwargs(vscode.pkg.archive) }}
    - archive_format: {{ vscode.pkg.format }}
    - retry: {{ vscode.retry_option }}
    - user: {{ vscode.rootuser }}
    - group: {{ vscode.rootgroup }}
  cmd.run:
    - onlyif: {{ grains.kernel|lower == 'linux' }}
    - name: mv {{ vscode.dir.archive }}/VSCode-linux-x64 {{ vscode.config.path }}
    - require:
      - archive: vscode-package-archive-install-extract

    {%- if vscode.kernel|lower == 'linux' and vscode.linux.altpriority|int == 0 %}

vscode-archive-install-file-symlink-vscode:
  file.symlink:
    - onlyif: {{ vscode.kernel|lower == 'linux' }}
    - name: {{ vscode.dir.archive }}/bin/code
    - target: {{ vscode.config.path }}/bin/code
    - force: True
    - require:
      - archive: vscode-package-archive-install-extract
    {%- endif %}
