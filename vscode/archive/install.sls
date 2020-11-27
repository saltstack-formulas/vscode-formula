# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

        {%- if vscode.pkg.deps %}

vscode-package-archive-install-deps:
  pkg.installed:
    - names: {{ vscode.pkg.deps }}
    - require_in:
      - file: vscode-package-archive-install-extract

        {%- endif %}

vscode-package-archive-install-extract:
  file.directory:
    - name: {{ vscode.pkg.archive.name }}
    - makedirs: True
    - require_in:
      - archive: vscode-package-archive-install-extract
        {%- if grains.os|lower == 'windows' and vscode.pkg.archive.name != '/Applications' %}
    - user: {{ vscode.identity.rootuser }}
    - group: {{ vscode.rootgroup }}
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
      - archive: vscode-package-archive-install-extract

        {%- if vscode.linux.altpriority|int == 0 %}

vscode-archive-install-file-symlink-vscode:
  file.symlink:
    - onlyif: {{ vscode.kernel|lower == 'linux' }}
    - name: {{ vscode.dir.archive }}/bin/code
    - target: {{ vscode.config.path }}/bin/code
    - force: True
    - require:
      - archive: vscode-package-archive-install-extract

        {%- endif %}
    {%- endif %}
