class test($env){
	exec { 'foo':
 		environment => $env,
		command => '/bin/echo CFLAGS=$CFLAGS CXXFLAGS=$CXXFLAGS FCFLAGS=$FCFLAGS > /tmp/bar'
	}
}
node 'xubuntu-1404' {
	include build_source
	$CFLAGS="-O3 -mcpu=$processor0 -mtune=$processor0 -mfloat-abi=hard -mfpu=$architecture"
	class{"test":
		env => ["CFLAGS=\"$CFLAGS\"","CXXFLAGS=\"$CFLAGS\"","FCFLAGS=\"-O3\""]
	}
	include ompss
}
node 'laptop' {
	include build_source
	include ompss
}
