class projects::yodlekeys {
	require wget
	include boxen::config

	$home = "/Users/${::boxen_user}"

	file { "$home/.ssh":
	  ensure => directory,
	  owner  => $::boxen_user,
	  mode   => 0700
	}

  wget::fetch { "download private yodle ssh key":
    source             => 'https://dev-git.dev.yodle.com/projects/SUPERLUMINAL/repos/macguffin/browse/roles/node/files/yodle-denv-bootstrap.key?at=9b7f2f392172535d862954c4d86ac03ee5737cea&raw',
    destination        => "$home/.ssh/yodle-denv-bootstrap",
    verbose            => true,
    nocheckcertificate => true,
  }

	file { "$home/.ssh/yodle-denv-bootstrap":
	  ensure => exists,
	  owner  => $::boxen_user,
	  mode   => 0600
	}

  wget::fetch { "download public yodle ssh key":
    source             => 'https://dev-git.dev.yodle.com/projects/SUPERLUMINAL/repos/macguffin/browse/roles/node/files/yodle-denv-bootstrap.key.pub?at=cb94d7d0bdbc6ba5ab78a74a1e9c096ea1157a31&raw',
    destination        => "$home/.ssh/yodle-denv-bootstrap.pub",
    verbose            => true,
    nocheckcertificate => true,
  }

	file { "$home/.ssh/yodle-denv-bootstrap.pub":
	  ensure => exists,
	  owner  => $::boxen_user,
	  mode   => 0644
	}
}
