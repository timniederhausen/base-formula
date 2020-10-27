{% from 'base/map.jinja' import base with context %}

{# needed to prevent sysrc from exiting with != 0 #}
periodic_conf:
  file.exists:
    - name: /etc/periodic.conf

{% for entry in base.periodic_conf %}
periodic_{{ entry.option }}:
  sysrc.managed:
    - name: {{ entry.option }}
    - value: {{ entry.value | yaml_encode }}
    - file: /etc/periodic.conf
    - requires:
      - file: periodic_conf
{% endfor %}
