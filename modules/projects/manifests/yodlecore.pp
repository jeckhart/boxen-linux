class projects::yodlecore {
  require projects::yodlekeys

  if $osfamily=='Darwin' {
    $group = 'staff'
  } else {
    $group = $::boxen_user
  }

  file { 'workspace':
    path => '/workspace',
    owner => $::boxen_user,
    group => $group,
    ensure => directory,
    before => Repository['yodlecore']
  }
  
  repository {
    'yodlecore':
      source   => 'http://dev-hg.dev.yodle.com/yodlecore-central',
      provider => 'mercurial',
      path     => '/workspace/src/yodlecore';
  }
}
