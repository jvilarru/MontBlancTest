class lapack {
	$VERSION="3.5.0"
	$PREFIX="/opt/lapack"
	$URL="http://www.netlib.org/lapack/lapack-3.5.0.tgz"
	package { "cmake":
		ensure  => latest,
	}->
	exec { "wget $URL -O /usr/src/lapack.tar.gz":
		creates => "/usr/src/lapack.tar.gz",
		path    => ["/bin","/usr/bin"],
	}->
	exec { "tar xf /usr/src/lapack.tar.gz -C /usr/src":
		creates => "/usr/src/lapack-3.5.0",
		path    => ["/bin","/usr/bin"],
	}->
	exec { "cmake -D CMAKE_INSTALL_PREFIX=$PREFIX/$VERSION /usr/src/lapack-3.5.0":
		path    => ["/bin","/usr/bin","/usr/local/bin","/sbin","/usr/sbin","/usr/local/sbin"],
		cwd     => "/usr/src/lapack-3.5.0",
	}->
	exec { "make":
		path    => ["/bin","/usr/bin","/usr/local/bin","/sbin","/usr/sbin","/usr/local/sbin"],
		cwd     => "/usr/src/lapack-3.5.0",
	}->
	exec { "make install":
		path    => ["/bin","/usr/bin","/usr/local/bin","/sbin","/usr/sbin","/usr/local/sbin"],
		cwd     => "/usr/src/lapack-3.5.0",
	}
}
