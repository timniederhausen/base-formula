{% from 'base/map.jinja' import base, includes with context %}

{% for pkg in base.packages %}
pkg_{{ pkg }}:
  pkg.installed:
    - name: {{ pkg }}
{% endfor %}

{% if includes %}
include:
{% for include in includes %}
  - base.{{ include }}
{% endfor %} 
{% endif %}

{% if grains.os_family == 'FreeBSD' %}
python_cert_symlink:
  file.symlink:
    - name: /etc/ssl/cert.pem
    - target: /usr/local/etc/ssl/cert.pem
{% endif %}

# seems to be required by certain applications.
# (e.g. CAS)
# http://stackoverflow.com/questions/1881546/inetaddress-getlocalhost-throws-unknownhostexception
hostname_in_hosts:
  host.present:
    - name: {{ salt['grains.get']('fqdn') }}
    - ip: {{ salt['grains.get']('ipv4') | yaml }}
