################################################################################
################################################################################
# This modules is used to ....
# Parameters:
#   type => module type (compiler, application, tool, etc.)
#   prefix => installation path
#   conflicts => array containing all the conflicts of the modulefile
#   desc => application name
#   modname => name of the module, spaces are not allowed
#   version => version of the application, needed to make default this module
################################################################################
################################################################################
define environment_modules::generate_module(	$type,
					$prefix,
					$modname=$title,
					$conflicts=[$modname],
					$desc='',
					$version=''
){
	$MODULEFILES_PATH = "/opt/environment_modules/3.2.10/Modules/default/modulefiles/$type"
	
	if ( $desc != '' ) {
		$APP_DESC = "($desc)"
	}


	File {
		owner => 'root',
		group => 'root'
	}

	file { "modulefile folder $type":
		path   => "$MODULEFILES_PATH/$modname",
		ensure => 'directory',
		mode   => '755'
	}
	
	if ( $version != '' ) {
		$APP_VER = $version
		$APP_PREFIX = $prefix
		$APP_CONFLICTS = $conflicts
		file { "$modname modulefile":
			path    => "$MODULEFILES_PATH/$modname/$version",
			ensure  => 'file',
			mode    => '644',
			content => template("environment_modules/generic_module.erb"),
			require => File["modulefile folder $type"
		}
		file { "default_version":
			path    => "$MODULEFILES_PATH/$modname/.version",
			ensure  => file,
			content => template("environment_modules/generic_version.erb"),
			mode    => '644',
			require => File["$modname modulefile"]
		}
	} else {
		$APP_VER = $version
		$APP_PREFIX = "default"
		$APP_CONFLICTS = $conflicts
		file { "$modname modulefile":
			path    => "$MODULEFILES_PATH/$modname/default",
			ensure  => 'file',
			mode    => '644',
			content => template("environment_modules/generic_module.erb"),
			require => File["modulefile folder $type"]
		}
		file { "default_version":
			path    => "$MODULEFILES_PATH/$modname/.version",
			ensure  => file,
			content => template("environment_modules/generic_version.erb"),
			mode    => '644',
			require => File["$modname modulefile"]
		}
	}
}
