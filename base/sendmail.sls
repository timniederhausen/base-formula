{% from 'base/map.jinja' import base with context %}

{% for entry in base.sendmail_conf %}
sendmail_cfg_{{ entry.option }}:
  sysrc.managed:
    - name: {{ entry.option }}
    - value: {{ entry.value | yaml_encode }}
    - watch_in:
      - service: sendmail
{% endfor %}

sendmail:
  service.running:
    - enable: True
