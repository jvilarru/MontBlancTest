class admin_tools {
	require stdlib
	$packages = ['screen','vim','bash-completion','command-not-found','htop','mlocate','zsh','bc']
	ensure_resource('secure_package',$packages,{})
	#some public keys to acess root and various stuff
}