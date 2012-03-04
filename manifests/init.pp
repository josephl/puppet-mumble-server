# Class: mumble-server
#
# This module manages mumble-server
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class mumble-server {

  package { 'mumble-server':
    ensure => present,
  }

  file { 'mumble-server.ini':
    path => '/etc/mumble-server.ini',
    ensure => file,
    source => 'puppet:///modules/mumble-server/mumble-server.ini',
    replace => false,
    require => Package['mumble-server'],
    owner => 'root',
    group => 'mumble-server',
    mode => '0640',
  }

  service { 'mumble-service':
    ensure => running,
    enable => true,
    subscribe => File['mumble-server.ini'],
    require => Package['mumble-server'],
    hasrestart => true,
    hasstatus => true,
  }

}
