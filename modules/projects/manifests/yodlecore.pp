class projects::yodlecore {
	include java
	require mercurial
	require projects::yodlekeys
	
	repository {
		'yodlecore':
			source   => 'http://dev-hg.dev.yodle.com/yodlecore-central/',
			provider => 'mercurial',
			path     => '/workspace/src/yodlecore';
	}
}
