#dependences = bison, flex
class gnu_compiler {
	#GMP
	$GMP_ver = "6.0.0a"
	$GMP_dest = "/opt/gmp/$GMP_ver"
	$CFLAGS_GMP="-O3"
	build_source::install{"gmp":
		url         => "https://gmplib.org/download/gmp/gmp-6.0.0a.tar.xz"
		environment => ["CFLAGS=$CFLAGS_GMP"],
		options     => template("$module_name/options_gmp.erb"),
		dest        => $GMP_dest,
		dependences => ["bison","flex"]
	}
	
	#MPFR
	$CFLAGS_MPFR="-O3 -fPIC"
	$CFLAGS_MPC="-O3 -fPIC"
	$CFLAGS_ISL="-O3 -fPIC"
	$CFLAGS_CLOOG="-O3 -fPIC"
	$CFLAGS_GCC="-O3"
	build_source::install{"mpfr":
		url         => "http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.xz"
		environment => ["CFLAGS=$CFLAGS_MPFR"],
		options     => template("$module_name/options_mpfr.erb"),
		version     => "3.1.2",
		require     =>  Build_source::Install["gmp"]
	}->
	build_source::install{"mpc":
		url          => "ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz"
		environment  => ["CFLAGS=$CFLAGS_MPC"],
		options      => template("$module_name/options_mpc.erb"),
		version      => "1.0.3",
	}->
	build_source::install{"isl":
		url          => "http://mirror1.babylon.network/gcc/infrastructure/isl-0.14.tar.bz2"
		environment  => ["CFLAGS=$CFLAGS_ISL"],
		options      => template("$module_name/options_isl.erb"),
		version      => "0.14",
	}->
	build_source::install{"cloog":
		url          => "http://www.bastoul.net/cloog/pages/download/cloog-0.18.3.tar.gz"
		environment  => ["CFLAGS=$CFLAGS_CLOOG"],
		options      => template("$module_name/options_cloog.erb"),
		version      => "0.18.3",
	}->
	build_source::install{"gcc":
		url          => "http://mirror1.babylon.network/gcc/releases/gcc-5.1.0/gcc-5.1.0.tar.gz"
		environment  => ["CFLAGS=$CFLAGS_GCC"],
		options      => template("$module_name/options_gcc.erb"),
		version      => "5.1.0",
	}
}
