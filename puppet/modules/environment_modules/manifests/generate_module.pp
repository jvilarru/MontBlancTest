################################################################################
################################################################################
# This modules is used to ....
# Parameters:
#   type      => module type (compiler, application, tool, etc.)
#   prefix    => installation path
#   conflicts => array containing all the conflicts of the modulefile
#   desc      => application name
#	app_name  => Application name (long)
#   modname   => name of the module, spaces are not allowed
#   version   => version of the application, needed to make default this module
################################################################################
################################################################################
define environment_modules::generate_module(	$type,
					$prefix,
					$modname=$title,
					$app_name,
					$conflicts=$title,
					$desc='',
					$version=''
){
	require stdlib
	File {
		owner => 'root',
		group => 'root'
	}

	ensure_resource('environment_modules::folder',"$type",{'prefix' => '/opt/environment_modules/3.2.10'})

	$MODULE_FOLDER_PATH = "/opt/environment_modules/3.2.10/Modules/default/modulefiles/$type"
	file { "modulefile folder $modname":
		path    => "$MODULE_FOLDER_PATH/$modname",
		ensure  => 'directory',
		mode    => '755',
		require => Environment_modules::Folder["$type"]
	}
	
	if ( $desc != '' ) {
		$APP_DESC = "($desc)"
	}

	$APP_PREFIX = $prefix
	$APP_CONFLICTS = $conflicts
	$APP_NAME = $app_name
	if ( $version != '' ) {
		$APP_VER = $version
		file { "$modname modulefile":
			path    => "$MODULE_FOLDER_PATH/$modname/$version",
			ensure  => 'file',
			mode    => '644',
			content => template("environment_modules/generic_module.erb"),
			require => File["modulefile folder $modname"]
		}
		file { "$modname default_version":
			path    => "$MODULE_FOLDER_PATH/$modname/.version",
			ensure  => file,
			content => template("environment_modules/generic_version.erb"),
			mode    => '644',
			require => File["$modname modulefile"]
		}
	} else {
		$APP_VER = $version
		file { "$modname modulefile":
			path    => "$MODULE_FOLDER_PATH/$modname/default",
			ensure  => 'file',
			mode    => '644',
			content => template("environment_modules/generic_module.erb"),
			require => File["modulefile folder $modname"]
		}
		file { "$modname default_version":
			path    => "$MODULE_FOLDER_PATH/$modname/.version",
			ensure  => file,
			content => template("environment_modules/generic_version.erb"),
			mode    => '644',
			require => File["$modname modulefile"]
		}
	}
}
