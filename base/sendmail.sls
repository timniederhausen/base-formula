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

{% if base.root_email_alias %}
root_mail_alias:
  file.replace:
    - name: /etc/mail/aliases
    - pattern: '^#?root: (.*?)$'
    - repl: 'root: {{ base.root_email_alias }}'
    - append_if_not_found: true

sendmail_reload:
  service.running:
    - name: sendmail
    - reload: True
    - onchanges:
      - file: root_mail_alias
{% endif %}
