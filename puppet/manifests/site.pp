class all {
	build_source{ "fftw":
	        url     => "http://www.fftw.org/fftw-3.3.4.tar.gz",
	}
	include mpich
	include extrae
	include openmpi
	include papi
	include hdf5
	include boost
	include lapack
}
node default {
	include all
}
#node 'xubuntu-1404' {
#	include boost
#}
class test {
	$arr1=["a","b"]
	$arr2=["c","d"]
	$arr3 = concat($arr1,$arr2)
	notice( "arr1=$arr1 arr3=$arr3")
}
node 'laptop' {
	include all
}
