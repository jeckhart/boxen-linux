class projects::yodlekeys {
	require wget

  wget::fetch { "download private yodle ssh key":
    source      => 'https://dev-git.dev.yodle.com/projects/SUPERLUMINAL/repos/macguffin/browse/roles/node/files/yodle-denv-bootstrap.key?at=9b7f2f392172535d862954c4d86ac03ee5737cea&raw',
    destination => '${HOME}/.ssh/yodle-denv-bootstrap.key',
    verbose     => true,
  }

  wget::fetch { "download public yodle ssh key":
    source      => 'https://dev-git.dev.yodle.com/projects/SUPERLUMINAL/repos/macguffin/browse/roles/node/files/yodle-denv-bootstrap.key.pub?at=cb94d7d0bdbc6ba5ab78a74a1e9c096ea1157a31&raw',
    destination => '${HOME}/.ssh/yodle-denv-bootstrap.key.pub',
    verbose     => true,
  }
}
