class boost {
	$VERSION="1.58.0"
	$PREFIX="/opt/boost"
	$URL="http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz"
	exec { "wget $URL -O /usr/src/boost.tar.gz":
		creates => "/usr/src/boost.tar.gz",
		path    => ["/bin","/usr/bin"],
	}->
	exec { "tar xf /usr/src/boost.tar.gz -C /usr/src":
		creates => "/usr/src/boost_1_58_0",
		path    => ["/bin","/usr/bin"],
	}->
	exec { "./bootstrap.sh --prefix=$PREFIX/$VERSION":
		path    => ["/bin","/usr/bin","/usr/local/bin","/sbin","/usr/sbin","/usr/local/sbin"],
		cwd     => "/usr/src/boost_1_58_0",
	}->
	exec { "./b2 install":
		path    => ["/bin","/usr/bin","/usr/local/bin","/sbin","/usr/sbin","/usr/local/sbin"],
		cwd     => "/usr/src/boost_1_58_0",
	}
}
