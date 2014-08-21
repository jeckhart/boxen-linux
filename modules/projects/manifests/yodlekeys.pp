class projects::yodlekeys {
	require wget
	include boxen::config
	include augeas

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

	augeas { "$sshdir/config hg":
    incl    => "$sshdir/config",
    lens    => 'Ssh.lns',
    changes => [
      'defnode host Host[. = "hg dev-hg.dev.yodle.com"] "hg dev-hg.dev.yodle.com"',
      'set $host/HostName "dev-hg.dev.yodle.com"',
      'set $host/User "hg"',
      "set \$host/IdentityFile \"$sshdir/yodle-denv-bootstrap\"",
      'set $host/StrictHostKeyChecking no',
      'defnode host Host[. = "git-ro ro.dev-git.dev.yodle.com"] "git-ro ro.dev-git.dev.yodle.com"',
      'set $host/HostName "dev-git.dev.yodle.com"',
      'set $host/User "git"',
      "set \$host/IdentityFile \"$sshdir/yodle-denv-bootstrap\"",
      'set $host/StrictHostKeyChecking no',
    ],
    require => [File[$sshdir],File["$sshdir/yodle-denv-bootstrap"]]
  }
}
