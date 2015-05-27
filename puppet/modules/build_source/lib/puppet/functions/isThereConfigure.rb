module Puppet::Parser::Functions
	newfunction(:isThereConfigure, :type => :rvalue) do |args|
		cmd = "tar --exclude=\"*/*\" -tf "+ args[0]
		res = %x[#{cmd}]
		res.lines.any?{|line| line == "configure\n"}
	end
end
