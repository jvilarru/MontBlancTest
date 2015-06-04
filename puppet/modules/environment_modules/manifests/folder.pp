define environment_modules::folder($prefix){
        require stdlib
	file {"environment_modules $title":
                path => "$prefix/Modules/default/modulefiles/$title",
                ensure => "directory",
                mode => '755',
		require => File["environment_modules modulefiles"],
	}
	file_line {"modulespath $title":
		path => "$prefix/Modules/default/init/.modulespath",
		line => "$prefix/Modules/default/modulefiles/$title"
	}
}
