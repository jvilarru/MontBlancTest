class papi{
	$CFLAGS="-O3"
	$FFLAGS="-O3"
	build_source{"$module_name":
		url       => "http://icl.cs.utk.edu/projects/papi/downloads/papi-5.4.1.tar.gz",
		env       => ["CFLAGS=$CFLAGS","FFLAGS=$FFLAGS"],
		version   => "5.4.1",
		configDir => "src",
	}
	if defined("environment_modules") {
         environment_modules::generate_module{"$module_name":
             type     => "tools",
             prefix   => "/opt/papi/5.4.1",
             app_name => "PAPITO", 
             version  => "5.4.1",
             require  => [Build_source[$module_name],Build_source['environment_modules']]
         }
     }	
}
