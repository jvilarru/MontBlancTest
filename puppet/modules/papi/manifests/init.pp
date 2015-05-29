class papi{
	$CFLAGS="-O3"
	$FFLAGS="-O3"
	build_source::install{"$module_name":
		url          => "http://icl.cs.utk.edu/projects/papi/downloads/papi-5.4.1.tar.gz",
		environment  => ["CFLAGS=$CFLAGS","FFLAGS=$FFLAGS"],
		version      => "5.4.1",
		configureLocation => "src",
	}
}
