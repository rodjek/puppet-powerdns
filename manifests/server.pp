define powerdns::server($cluster, $ensure=present) {
  include powerdns::augeas_lenses

  package { 'pdns-server':
    ensure => $ensure,
    before => Class['Powerdns::Augeas_lenses'],
  }

  Powerdns::Allow_axfr_ip<<| cluster == $cluster |>>
}
