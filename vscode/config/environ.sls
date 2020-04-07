# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if vscode.environ and 'path' in vscode.config %}
           {%- set sls_package_install = tplroot ~ '.archive.install' %}

include:
  - {{ sls_package_install }}

vscode-config-file-managed-environ_file:
  file.managed:
    - name: {{ vscode.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='vscode-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ vscode.rootuser }}
    - group: {{ vscode.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        path: {{ vscode.config.path|json }}
        environ: {{ vscode.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}
