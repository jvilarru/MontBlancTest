#dependences = tcl8.6-dev tclx8.4-dev
class environment_modules ($types = []){

	# Installation
	$ver = "3.2.10"
	$prefix = "/opt/$module_name/$ver"
	$CFLAGS="-O3"
	$CPPFLAGS="-DUSE_INTERP_ERRORLINE"
	build_source{"$module_name":
		url      => "http://sourceforge.net/projects/modules/files/Modules/modules-3.2.10/modules-3.2.10.tar.gz",
		env  	 => ["CFLAGS=$CFLAGS","CPPFLAGS=$CPPFLAGS"],
		dest     => "$prefix",
		packages => ["tcl8.6-dev","tclx8.4-dev"]
	}

	# Configuration files
	File {
		owner => 'root',
		group => 'root',
	}
        environment_modules::folders{$types:
                prefix => $prefix
        }

	file { 
	"$module_name default":
		path    => "$prefix/Modules/default",
		ensure  => "$prefix/Modules/$ver",
		require => Build_source["$module_name"];
	"$module_name wrapper":
		path => "/etc/profile.d/environent_modules.sh",
		ensure => "file",
		mode => '644',
		content => template("$module_name/environment_modules.erb"),
		require => Build_source["$module_name"];
	"$module_name modulefiles":
		path => "$prefix/Modules/default/modulefiles",
		ensure => "directory",
		mode => '755',
		require => File["$module_name default"];
	"$module_name modulespath":
		path => "$prefix/Modules/default/init/.modulespath",
		ensure => "file",
		mode => '664',
#		content => template("$module_name/modulespath.erb"),
		require => File["$module_name default"];
	}
}
