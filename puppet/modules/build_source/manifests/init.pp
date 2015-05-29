class build_source (){
	$dependences = ['gcc','make','g++']
	package { $dependences:
		ensure => latest,
	}
	file {"build_source extractor":
		path   => '/usr/local/bin/extract.pl',
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '755',
		source => "puppet:///modules/$module_name/extract.pl"
	}
}
