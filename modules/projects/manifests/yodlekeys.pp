class projects::yodlekeys {
  require wget
  include boxen::config

  if $osfamily=='Darwin' {
    include homebrew
    package { 'augeas':
      ensure => present
    }
  }
  elsif $osfamily=='Debian' {
    include apt
    package { "libaugeas-ruby1.9.1": 
      provider => apt,
    }
  }

  $home = "/Users/${::boxen_user}"
  $sshdir = "$home/.ssh"

  file { $sshdir:
    ensure => directory,
    owner  => $::boxen_user,
    mode   => 0700
  }

  wget::fetch { "download private yodle ssh key":
    source             => 'https://dev-git.dev.yodle.com/projects/SUPERLUMINAL/repos/macguffin/browse/roles/node/files/yodle-denv-bootstrap.key?at=9b7f2f392172535d862954c4d86ac03ee5737cea&raw',
    destination        => "$sshdir/yodle-denv-bootstrap",
    verbose            => true,
    nocheckcertificate => true,
  }

  file { "$sshdir/yodle-denv-bootstrap":
    ensure => file,
    owner  => $::boxen_user,
    mode   => 0600
  }

  wget::fetch { "download public yodle ssh key":
    source             => 'https://dev-git.dev.yodle.com/projects/SUPERLUMINAL/repos/macguffin/browse/roles/node/files/yodle-denv-bootstrap.key.pub?at=cb94d7d0bdbc6ba5ab78a74a1e9c096ea1157a31&raw',
    destination        => "$sshdir/yodle-denv-bootstrap.pub",
    verbose            => true,
    nocheckcertificate => true,
  }

  file { "$sshdir/yodle-denv-bootstrap.pub":
    ensure => file,
    owner  => $::boxen_user,
    mode   => 0644
  }

  file { "$sshdir/config":
    ensure  => present,
    owner   => $::boxen_user,
    require => [File[$sshdir],File["$sshdir/yodle-denv-bootstrap"]],
    content => "
Host hg
HostName dev-hg.dev.yodle.com
User hg
IdentityFile $sshdir/yodle-denv-bootstrap
StrictHostKeyChecking no
"
   }
}
