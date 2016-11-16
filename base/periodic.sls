{% from 'base/map.jinja' import base with context %}

{% for entry in base.periodic_conf %}
periodic_{{ entry.option }}:
  sysrc.managed:
    - name: {{ entry.option }}
    - value: {{ entry.value | yaml_encode }}
    - file: /etc/periodic.conf
{% endfor %}
