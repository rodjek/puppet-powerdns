# Public: Manage PowerDNS instances on a host.
#
# namevar - A unique String to identify the DNS cluster this server belongs to.
# ensure  - The state of the resource as a String.  Valid values are absent and
#           present (default: absent).
#
# Examples
#
#   # Install PowerDNS on this host and make it part of the 'ns1' cluster
#   powerdns::server { 'ns1': }
define powerdns::server($ensure=present) {
  include powerdns::augeas_lenses

  package { 'pdns-server':
    ensure => $ensure,
    before => Class['Powerdns::Augeas_lenses'],
  }

  Powerdns::Allow_axfr_ip<<| cluster == $name |>>
}
