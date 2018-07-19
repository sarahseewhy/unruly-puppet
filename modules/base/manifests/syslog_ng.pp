# == Class: base::syslog_ng
#
# Installs syslog-ng for system logging and removes known incompatible logging packages
#
class base::syslog_ng(
  $version = hiera('base::syslog_ng::version')
) {
  package { 'syslog-ng' :
    ensure => $version,
  }

  file { '/etc/syslog-ng/syslog-ng.conf' :
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => file('base/syslog_ng/syslog-ng.conf'),
    require => Package['syslog-ng'],
    notify  => Service['syslog-ng'],
  }

  service { 'syslog-ng' :
    ensure  => 'running',
    require => Package['syslog-ng']
  }

  package { 'rsyslog' :
    ensure => 'absent',
  }

}
