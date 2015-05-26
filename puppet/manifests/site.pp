class test::test(	$unwind='',
                $papi='',
                $mpi='',
                $opencl='',
                $boost='',
                $fft='',
                $ver = '',

){
}
node 'xubuntu-1404' {
	#	include build_source
	#$CFLAGS="-O3 -mcpu=$processor0 -mtune=$processor0 -mfloat-abi=hard -mfpu=$architecture"
	#class{"test":
	#		env => ["CFLAGS=\"$CFLAGS\"","CXXFLAGS=\"$CFLAGS\"","FCFLAGS=\"-O3\""]
	#}
	#include ompss
}
node 'laptop' {
	include stdlib
	include build_source
	class{"extrae":
	}
#	include ompss
}
