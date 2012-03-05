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

  include mumble-server::params

  if ("${mumble-server::params::supported}" == false) {
    fail("${operatingsystem} is not supported with ${module_name} at this time.")
  }
  else {

    package { 'mumble-server':
      name => "${mumble-server::params::pkg_name}",
      ensure => present,
    }

    file { 'mumble-server.ini':
      path => "${mumble-server::params::config}",
      ensure => file,
      content => template('puppet:///modules/mumble-server/mumble-server.ini.erg'),
      replace => false,
      require => Package['mumble-server'],
      owner => 'root',
      group => 'mumble-server',
      mode => '0640',
    }

    service { 'mumble-service':
      name => "${mumble-server::params::svc_name}",
      ensure => running,
      enable => true,
      subscribe => File['mumble-server.ini'],
      require => Package['mumble-server'],
      hasrestart => "${mumble-server::params::restart}",
      hasstatus => "${mumble-server::params::status}",
    }

  }

}
