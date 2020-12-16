# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import vscode with context %}
{%- set p = vscode.pkg %}

include:
        {%- if grains.os|lower == 'windows' %}
  - .installer
        {%- else %}
  - .archive
        {%- endif %}
  - .config
