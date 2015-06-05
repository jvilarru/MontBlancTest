define secure_package {
	require stdlib
	$command = "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'"
	ensure_resource('exec','apt-update',{'command' => "/usr/bin/apt-get update",'user'=>'root','group'=>'root','onlyif' => "$command"})
	ensure_packages($title)
	Exec['apt-update'] -> Package<| |>
}
