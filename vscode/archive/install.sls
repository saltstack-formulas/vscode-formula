# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if vscode.pkg.deps %}

vscode-archive-install-deps:
  pkg.installed:
    - names: {{ vscode.pkg.deps }}
    - require_in:
      - file: vscode-archive-install-extract

    {%- endif %}

vscode-archive-install-extract:
  file.directory:
    - name: {{ vscode.pkg.archive.name }}
    - makedirs: True
    - require_in:
      - archive: vscode-archive-install-extract
        {%- if grains.os|lower != 'windows' and vscode.pkg.archive.name != '/Applications' %}
    - user: {{ vscode.identity.rootuser }}
    - group: {{ vscode.identity.rootgroup }}
    - mode: 755
        {%- endif %}
  archive.extracted:
    {{- format_kwargs(vscode.pkg.archive) }}
    - archive_format: {{ vscode.pkg.format }}
    - retry: {{ vscode.retry_option }}
        {%- if grains.os != 'Windows' %}
    - user: {{ vscode.identity.rootuser }}
    - group: {{ vscode.identity.rootgroup }}
        {%- endif %}

    {%- if vscode.kernel|lower == 'linux' %}

  cmd.run:
    - name: mv {{ vscode.dir.archive }}/VSCode-linux-x64 {{ vscode.config.path }}
    - require:
      - archive: vscode-archive-install-extract

        {%- if vscode.linux.altpriority|int == 0 %}

vscode-archive-install-file-symlink-vscode:
  file.symlink:
    - name: {{ vscode.dir.archive }}/bin/code
    - target: {{ vscode.config.path }}/bin/code
    - force: True
    - require:
      - archive: vscode-archive-install-extract

        {%- endif %}
    {%- elif grains.kernel|lower == 'windows' %}

vscode-archive-install-windows-shortcut-vscode:
  file.shortcut:
    - name: C:\Users\{{ vscode.identity.rootuser }}\Desktop\Visual Studio Code.lnk
    - target: {{ vscode.pkg.archive.name }}/Code
    - working_dir: {{ vscode.config.path }}/bin
    - makedirs: True
    - force: True
    - user: {{ vscode.identity.rootuser }}
    - require:
      - archive: vscode-archive-install-extract

    {%- endif %}
