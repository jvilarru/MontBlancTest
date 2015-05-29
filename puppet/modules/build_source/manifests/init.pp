class build_source (){
	require stdlib
	$dependences = ['gcc','make','g++','cmake']
	ensure_packages($dependences)
	file {"build_source extractor":
		path   => '/usr/local/bin/extract.pl',
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '755',
		source => "puppet:///modules/$module_name/extract.pl"
	}
}
