define secure_package {
	require stdlib
	ensure_resource('exec','apt-update',{'command' => "/usr/bin/apt-get update",'user'=>'root','group'=>'root','refreshonly' => 'true'})
	exec{"$title not installed":
		command => "echo noop",
		path    => "/bin:/usr/bin",
		notify  => Exec["apt-update"],
		unless  => "dpkg -l $title",
	}
	ensure_resource('package',$title,{'ensure' => 'installed','require' => Exec["apt-update"]})
}
