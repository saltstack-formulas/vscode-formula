# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}

    {%- if grains.os == 'Windows' and 'installer' in vscode.pkg and vscode.pkg.installer %}

vscode-installer-software-install:
  file.managed:
    - name: {{ d.dir.tmp }}{{ d.div }}vscode-installer.exe
    - source: {{ d.pkg.installer.source }}
    - source_hash: {{ d.pkg.installer.source_hash }}
    - skip_verify: {{ d.pkg.installer.skip_verify }}
    - unless: test -f {{ d.dir.tmp }}{{ d.div }}vscode-installer.exe
    - makedirs: True
    - retry: {{ d.retry_option|json }}
  cmd.run:
    - name: {{ d.dir.tmp }}{{ d.div }}vscode-installer.exe
    - require:
      - file: vscode-installer-software-install

    {%- else %}

vscode-buildtols-software-install:
  test.show_notification:
    - text: |
        The installer software is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
