class slurm_client {
	# installation
	build_source{"$module_name":
		url      => "$module_name/slurm-14.11.7.tar.bz2",
		options  => template("$module_name/options.erb"),
		version  => "14.11.7",
		packages => ["munge","libmunge-dev","libcr-dev","libpam0g-dev","libssl-dev","openssl","libmysqld-dev","mysql-common","pkg-config","libxml2-dev","hwloc","libmysqlclient-dev","libhwloc-dev"]
	}
	
	# SLURM user configuration
	group { "$module_name group":
		name   => "slurm",
		ensure => present,
		gid    => "999",
		system => "yes"
	}
	user {  "$module_name user":
		name    => "slurm",
		ensure  => present,
		uid     => '999',
		system  => "yes",
		gid     => '999',
		require => Group["$module_name group"]
	}

	# SLURM needed folders
}
