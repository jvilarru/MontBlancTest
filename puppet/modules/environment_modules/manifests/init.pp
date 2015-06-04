#dependences = tcl8.6-dev tclx8.4-dev
$ver = "3.2.10"
$prefix = "/opt/$module_name/$ver"
class environment_modules {
	$CFLAGS="-O3"
	$CPPFLAGS="-DUSE_INTERP_ERRORLINE"
	build_source::install{"$module_name":
		url          => "http://sourceforge.net/projects/modules/files/Modules/modules-3.2.10/modules-3.2.10.tar.gz",
		environment  => ["CFLAGS=$CFLAGS","CPPFLAGS=$CPPFLAGS"],
		dest        => "$prefix",
		dependences => ["tcl8.6-dev","tclx8.4-dev"]
	}

	file { "default":
		path => "$prefix/Modules/default",
		target => "$prefix/Modules/$ver",
		require => Build_source::Install["$module_name"],
		ensure => "present"
	}
	
	file { "wrapper":
		path => "/etc/profile.d/environent_modules.sh",
		content => template("$module_name/environment_modules.erb"),
		ensure => "present",
		mode => '644',
		owner => 'root',
		group => 'root',
		require => Build_source::Install["$module_name"],
	}
	
	file { "modulefiles":
		path => "$prefix/Modules/default/modulefiles",
		ensure => "present",
		mode => '755',
		owner => 'root',
		group => 'root',
		require => File["default"]
	}
	file { "compilers":
		path => "$prefix/Modules/default/modulefiles/compilers",
		ensure => "present",
		mode => '755',
		owner => 'root',
		group => 'root',
		require => File["modulefiles"]
	}
	file { "applications":
		path => "$prefix/Modules/default/modulefiles/applications",
		ensure => "present",
		mode => '755',
		owner => 'root',
		group => 'root',
		require => File["modulefiles"]
	}
	file { "tools":
		path => "$prefix/Modules/default/modulefiles/tools",
		ensure => "present",
		mode => '755',
		owner => 'root',
		group => 'root',
		require => File["modulefiles"]
	}
	
	file { "modulespath":
		path => "$prefix/default/init/.modulespath",
		ensure => "present",
		mode => '664',
		owner => 'root',
		group => 'root',
		content => template("$module_name/modulespath.erb"),
		require => File["default"]
	}
}
