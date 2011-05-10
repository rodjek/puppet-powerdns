# Public: Manage ACL for hosts allowed to perform zone transfers.
#
# namevar - A String IP or CIDR address.
# cluster - A String tag to determine the DNS cluster this ACL entry applies to.
# ensure  - The state of the resource as a String.  Valid values are absent
#           and present (default: present).
#
# Examples
#
#   # Configure this server to be a slave of the 'ns1' cluster
#   @@powerdns::allow_axfr_ip { $ipaddress_eth0:
#     cluster => 'ns1',
#   }
define powerdns::allow_axfr_ip($cluster, $ensure='present') {
  if($ensure !~ /(absent|present)/) {
    fail("Invalid ensure value for Powerdns::Allow_axfr_ip[${name}].")
  }

  if($name !~ /[0-9\.\/]+/) {
    fail("Namevar for Powerdns::Allow_axfr_ip[${name}] doesn't look like a valid IP or CIDR address")
  }

  if($ensure == 'present') {
    augeas { "Adding ${name} to allow-axfr-ips":
      context => '/files/etc/powerdns/pdns.conf',
      changes => "set allow-axfr-ips/100000 ${name}",
      onlyif  => "match allow-axfr-ips/*[.='${name}'] size == 0",
      require => Class['Powerdns::Augeas_lenses'],
    }
  } else {
    augeas { "Removing ${name} from allow-axfr-ips":
      context => '/files/etc/powerdns/pdns.conf',
      changes => "rm allow-axfr-ips/*[.='${name}']",
      require => Class['Powerdns::Augeas_lenses'],
    }
  }
}
