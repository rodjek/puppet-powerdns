define powerdns::server($ensure=present) {
  package { 'pdns-server':
    ensure => $ensure,
  }
}
