# Class: build_source
#
# This module manages build_source
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class build_source (){
	package {"gcc":
		ensure => latest
	}    
# para un cortex a15 (NOTE 1)
# --mcpu=cortex-a15 --mtune=cortex-a15(hca:~/facts/cortex_cpu.rb --mfpu=vfpv4(guarrear por features)
  
}
