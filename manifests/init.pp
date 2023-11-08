class rclocal_unit {
  file {"/etc/systemd/system/rc-local.service":
    source => "puppet:///modules/rclocal_unit/rc-local.service",
  } ~>
  file {"/etc/rc.local":
    ensure => present,
    owner => 'root',
    mode => '0755',
  } ->
  service {"rc-local":
    enable => true,
  }
  exec {"rc-local magick hash":
    command=>'echo "#!/bin/bash" >> /etc/rc.local',
    unless=>'cat /etc/rc.local | grep "#!/bin/bash"',
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
}
