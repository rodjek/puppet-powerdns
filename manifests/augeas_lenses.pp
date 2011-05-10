class powerdns::augeas_lenses {
  file { '/usr/share/augeas/lenses/pdns.aug':
    source => 'puppet:///modules/powerdns/usr/share/augeas/lenses/pdns.aug',
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
  }
}
