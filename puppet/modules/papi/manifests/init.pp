class papi{
	$CFLAGS="-O3"
	$FFLAGS="-O3"
	build_source::install{"papi":
		url          => "http://icl.cs.utk.edu/projects/papi/downloads/papi-5.4.1.tar.gz",
		environment  => ["CFLAGS=$CFLAGS","FFLAGS=$FFLAGS"],
		options      => template("papi/options.erb"),
		version      => "5.4.1",
		workDir      => "src",
	}
}
