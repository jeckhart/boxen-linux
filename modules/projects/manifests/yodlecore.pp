class projects::yodlecore {
	require projects::yodlekeys
	include vcsrepo

	if $osfamily=='Darwin'
	  $group = 'staff'
  else
    $group = $::boxen_user
  end

	file { 'workspace':
	  path => '/workspace',
	  owner => $::boxen_user,
    group => $group,
    ensure => directory,
    before => vcsrepo['yodlecore']
	}
	
	vcsrepo {
		'yodlecore':
			source   => 'http://dev-hg.dev.yodle.com/yodlecore-central',
			provider => 'mercurial',
			path     => '/workspace/src/yodlecore';
	}
}
