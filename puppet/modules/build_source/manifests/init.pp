#########################################################################
# This module is used to install software from sources 			#
# Parameters:							  	#
# type      => (default = 'configure') it is used to specify the type 	#
#	       of build required by the software			#
# url       => url of the software files, i can be a git repository or  #
#	       a compressed package(see archive.pp for more info)	#
# env       => (optional) Array of environment variables		#
# options   => (optional) options for the configuration of the software	#
# version   => (optional) version of the software(used to infer the 	#
#	       destination folder) more details at Folders section	#
# srcDest   => (optional) Location of the source files			#
# dest      => (optional) Where to install the software			#
# defPrefix => (default = /opt) part of the install folder path when 	#
#	       no dest is specified, more details at Folders section	#
# buildDir  => (optional) Subfolder where to build the software		# 
# builder   => (optional and only useful to bootstrap) name of the 	#
#	       binary that is in chanrge of building and installing	#
# configDir => (optional) Subfolder where to fins the configure tool	#
# preConf   => (optional) command to execute before the configuration	# 
# packages  => (optional) array of the packages needed by this software	#
# buildArgs => (optional) arguments to pass to the builder		#
# Folders:								#
#   Source folder  => If srcDest is undefined, the source folder is:	#
#		      /usr/src/$name/$version				#
#   Install folder => If dest is undefined the install folder is:	#
#		      $defPrefix/$name/$version 			#
#   In both cases if version is unspecified the $version subfolder will #
#   not be created							#
#########################################################################
define build_source (	$type = 'configure',
			$url,
			$env = '',
			$options ='',		
			$env='',
			$options = '',
			$version = '',
			$srcDest = '',
			$dest = '',
			$defPrefix ='/opt',
			$buildDir = '',
			$builder = '',
			$configDir = '',
			$preConf ='',
			$packages ='',
			$buildArgs = ''
){
	require stdlib
	if($srcDest == ''){
                if($version == ''){
                        $sourceFolder = "/usr/src/$name"
                }
                else {
                        $sourceFolder = "/usr/src/$name/$version"
                }
        }
        else {
                $sourceFolder = $srcDest
        }
	if($configDir != '') {
		$confLoc = "$configDir"
		$srcConfFolder = "$sourceFolder/$confLoc"
	} else {
		$confLoc = ''
		$srcConfFolder = $sourceFolder
	}
	case $type {
                'cmake': {		
			$reqInst = Build_source::Cmake["$title"]
			$creates = "${confLoc}/CMakeLists.txt"
			$generalDependences = ["gcc","make","g++","cmake"]
		}
                'configure': { 
			$reqInst = Build_source::Compile["$title"]
			$creates = "${confLoc}/configure"
			$generalDependences = ["gcc","make","g++"]
		}
                'bootstrap': { 
			$reqInst = Build_source::Bootstrap["$title"]
			$creates = "${confLoc}/bootstrap.sh"
			$generalDependences = []
		}
                default: { fail('Type of installation not supported')}
        }
	if($packages != ''){
		$allDeps = concat($packages,$generalDependences)
		ensure_resource('secure_package',$allDeps,{})
		Secure_package[$packages] -> $reqInst
	}
	if($dest == ''){
                if($version == ''){
                        $destFolder = "$defPrefix/$name"
                }
                else {
                        $destFolder = "$defPrefix/$name/$version"
                }
        }
        else {
                $destFolder = $dest
        }
	$extension = inline_template('<%= File.extname(@url) %>')
        if($extension == ".git"){
                build_source::git{"$title":
                        url    => $url,
                        dest   => $sourceFolder,
                        before => $reqInst
                }
                $requirement=Build_source::Git["$title"]
        } else {
                build_source::archive{"$title":
                        url     => $url,
                        dest    => $sourceFolder,
                        creates => $creates,
                        before  => $reqInst
                }
                $requirement=Build_source::Archive["$title"]

        }	
	if ($preConf != '') {
		exec {"preconfigure of $title":
                        command => $preConf,
                        path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
                        user    => 'root',
                        group   => 'root',
                        cwd     => $sourceFolder,
                        creates => $destFolder,
                        before  => $reqInst,
                        require => $requirement
                }
	}
	case $type {
                'cmake': {
			build_source::cmake{"$title":
				sourceFolder => $srcConfFolder,
				dest 	     => $destFolder, 
				options      => $options,
				environment  => $env,
				buildDir     => $buildDir,
				buildArgs    => $buildArgs
			}
                }
                'configure': {
			build_source::compile{"$title":
				sourceFolder => $srcConfFolder,
				dest 	     => $destFolder, 
				options      => $options,
				environment  => $env,
				buildDir     => $buildDir,
				buildArgs    => $buildArgs
			}
                }
                'bootstrap': {
			build_source::bootstrap{"$title":
				sourceFolder => $srcConfFolder,
				dest 	     => $destFolder, 
				options      => $options,
				builder	     => $builder,
				environment  => $env,
				buildDir     => $buildDir,
				buildArgs    => $buildArgs
			}
        	}
		default: {}
	} 
}

