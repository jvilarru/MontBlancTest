class compilers_runtime($opencl='') {
	include gnu_compiler
	class{"openmpi":
		slurm => "/opt/slurm/14.11.7"
		require => Class['slurm_client']
	}
	class{"mpich":
		slurm   => "/opt/slurm/14.11.7",
		require => Class['slurm_client']
	}
	if($opencl == ''){
		$requirementOmpss=[Class['mpich'],Class['extrae']]
	}else{
		$requirementOmpss=[Class['mpich'],Class['extrae'],Class['opencl']]
	}
	class{"ompss":
		mpi     => "/opt/mpich/3.1.4",
		extrae  => "/opt/extrae/3.1.0/mpich",
		opencl  => $opencl,
		require => $requirementOmpss,
	}
