# This class configures r10k
class r10k (
  $remote                    = $r10k::params::remote,
  $sources                   = $r10k::params::sources,
  $purgedirs                 = $r10k::params::r10k_purgedirs,
  $cachedir                  = $r10k::params::r10k_cache_dir,
  $configfile                = $r10k::params::r10k_config_file,
  $version                   = $r10k::params::version,
  $modulepath                = $r10k::params::modulepath,
  $manage_modulepath         = $r10k::params::manage_modulepath,
  $r10k_basedir              = $r10k::params::r10k_basedir,
  $package_name              = $r10k::params::package_name,
  $provider                  = $r10k::params::provider,
  $gentoo_keywords           = $r10k::params::gentoo_keywords,
  $install_options           = $r10k::params::install_options,
  $mcollective               = $r10k::params::mcollective,
  $manage_configfile_symlink = $r10k::params::manage_configfile_symlink,
  $configfile_symlink        = $r10k::params::configfile_symlink,
  $include_prerun_command    = false,
) inherits r10k::params {

  if type($include_prerun_command) == 'string' {
    $include_prerun_command_real = str2bool($include_prerun_command)
  } else {
    $include_prerun_command_real = $include_prerun_command
  }
  validate_bool($include_prerun_command_real)

  if $include_prerun_command_real == true {
    include r10k::prerun_command
  }

  class { 'r10k::install':
    package_name    => $package_name,
    version         => $version,
    provider        => $provider,
    keywords        => $gentoo_keywords,
    install_options => $install_options,
  }

  class { 'r10k::config':
    cachedir                  => $cachedir,
    configfile                => $configfile,
    sources                   => $sources,
    purgedirs                 => $purgedirs,
    modulepath                => $modulepath,
    remote                    => $remote,
    manage_modulepath         => $manage_modulepath,
    r10k_basedir              => $r10k_basedir,
    manage_configfile_symlink => $manage_configfile_symlink,
    configfile_symlink        => $configfile_symlink,
  }

  if $mcollective {
    class { 'r10k::mcollective': }
  }
}
