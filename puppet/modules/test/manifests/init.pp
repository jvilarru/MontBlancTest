#dependences = binutils-dev, libxml2-dev gfortran
class test {
	$test = getTarNumFiles("/tmp/test2.tar.gz")
	notify{"$test":}
}
