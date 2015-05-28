class test {
	exec {"test":
		environment => ["TEST=test spaces"],
		command     => "/usr/bin/env > /tmp/test"
	}
}
