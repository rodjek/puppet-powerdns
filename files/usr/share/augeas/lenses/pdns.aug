module Pdns =
  autoload xfm

  let equals = del /=/ "="
  let store_to_eol = store /([^ \t\n].*[^ \t\n]|[^ \t\n])/
  let space = del /[ \t]+/ " "
  let eol = Util.eol
  let entry (kw:regexp) = [ key kw . equals . store_to_eol . eol ]
  let generic_entry_key = /[A-Za-z0-9\._-]+(\[[0-9]+\])?/ - /allow-axfr-ips/
  let ip = /[0-9\.\/]+/
  let comment = Util.comment
  let empty = Util.empty

  let generic_entry = entry generic_entry_key
  let allow_axfr_ips_entry = [ label "allow-axfr-ips" . Util.del_str "allow-axfr-ips"
                              . equals . counter "ips"
                              . [ seq "ips" . store ip . space ]* 
                              . [ seq "ips" . store ip ] . eol
                             ]

  let lns = (comment|empty|allow_axfr_ips_entry|generic_entry)*

  let filter      = Util.stdexcl
                    . incl "/etc/powerdns/pdns.conf"

  let xfm         = transform lns filter
