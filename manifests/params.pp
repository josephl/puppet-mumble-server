class mumble-server::params ($database='UNSET',
                             $dbus='system',
                             $logfile='UNSET',
                             $pidfile='UNSET',
                             $welcometext="Welcome to $fqdn running\
                             <b>Murmur</b>.",
                             $port='64738',
                             $serverpassword='',
                             $bandwidth='7200',
                             $users='100') {

  $supported = true

  case $operatingsystem {
    debian, ubuntu: {
      $pkg_name = 'mumble-server'
      $svc_name = 'mumble-server'
      $config = '/etc/mumble-server.ini'
      $status = false
      $restart = true
      if ($database == 'UNSET') {
        $database = '/var/lib/mumble-server/mumble-server.sqlite'
      }
      if ($logfile == 'UNSET') {
        $logfile = '/var/log/mumble-server/mumble-server.log'
      }
      if ($pidfile == 'UNSET') {
        $pidfile = '/var/run/mumble-server/mumble-server.pid'
      }
    }

    default: {
      $supported = false
    }
  }

}
