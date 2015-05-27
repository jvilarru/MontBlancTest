module Puppet::Parser::Functions
	newfunction(:getTarNumFiles, :type => :rvalue) do |args|
		#filename = args[0]
		cmd = "tar --exclude=\"*/*\" -tf "+ args[0]
		res = %x[#{cmd}]
		res.lines.any?{|line| line == "configure\n"}
	#	arr.each do |linia|
	#		if linia == "configure\n"
	#			return true
	#		end
	#	end
	#	false
	end
end
