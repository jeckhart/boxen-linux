class projects::yodlecore {
	include mercurial
	include java

	#file { "${HOME}/.ssh/yodle-denv-bootstrap.key":
		#ensure => 

	repository {
		'yodlecore':
			source   => 'http://dev-hg.dev.yodle.com/yodlecore-central/',
			provider => 'mercurial',
			path     => '/workspace/src/yodlecore';
		
	}
}
