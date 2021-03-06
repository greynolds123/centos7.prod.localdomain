<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
# == Class: ldap::server
#
#  This class manages the installation and configuration of an OpenLDAP Server
#
# === Parameters
#
# [*suffix*]
#   The domain for which the LDAP server provides information for.
#
# [*rootdn*]
#   The administrative user which has root access to the database schema.
#
# [*rootpw*]
#   The password for the rootdn administrative user.
#
# [*directory*]
#   Path to where the slapd database files should be stored.
#
# [*log_level*]
#   Daemon logging level, see http://www.openldap.org/doc/admin24/slapdconfig.html.
#
# [*schemas*]
#   An array of schema files which should be loaded in.
#
# [*modules*]
#   An array of modules which should be loaded in.
#
# [*indexes*]
#   An array of indexes which should be created in the database.
#
# [*overlays*]
#   An array of overlays which should be added to the database.
#
# [*ssl*]
#   Whether the server should listen on port 636 (SSL).
#   Default: false
#
# [*ssl_cacert*]
#   Path to the certificate authority file for the LDAP SSL certificate.
#
# [*ssl_cert*]
#   Path to the SSL certificate file.
#
# [*ssl_key*]
#   Path to the SSL certificate key.
#
# [*config*]
#   Whether the config database should be built (cn=config).
#
# [*configdn*]
#   The root dn for the config database (Default: rootdn).
#
# [*configpw*]
#   The password for the configdn user (Default: rootpw).
#
# [*monitor*]
#   Whether the monitor database should be built (cn=Monitor).
#
# [*monitordn*]
#   The root dn for the monitor database (Default: rootdn).
#
# [*monitorpw*]
#   The password for the monitordn user (Default: rootpw).
#
# [*bind_anon*]
#   Allow anonymous (unauthenticated) binding to the LDAP server.
#   Default: false
#
# [*bind_v2*]
#   Whether to support LDAPv2.
#   Default: true
#
# === Examples
#
#  class { 'ldap::server':
#    suffix => 'dc=example,dc=com',
#    rootdn => 'cn=admin,dc=example,dc=com',
#    rootpw => 'llama',
#  }
#
class ldap::server (
  $suffix,
  $rootdn,
  $rootpw,
  $configdn         = $rootdn,
  $configpw         = $rootpw,
  $monitordn        = $rootdn,
  $monitorpw        = $rootpw,
  $directory        = $ldap::params::server_directory,
  $log_level        = $ldap::params::server_log_level,
  $schemas          = $ldap::params::server_schemas,
  $modules          = $ldap::params::server_modules,
  $indexes          = $ldap::params::server_indexes,
  $overlays         = $ldap::params::server_overlays,
  $ssl              = $ldap::params::server_ssl,
  $ssl_cacert       = $ldap::params::server_ssl_cacert,
  $ssl_cert         = $ldap::params::server_ssl_cert,
  $ssl_key          = $ldap::params::server_ssl_key,
  $config           = $ldap::params::config,
  $monitor          = $ldap::params::monitor,
  $bind_anon        = $ldap::params::server_bind_anon,
  $bind_v2          = $ldap::params::server_bind_v2,
  $package_name     = $ldap::params::server_package_name,
  $package_ensure   = $ldap::params::server_package_ensure,
  $service_manage   = $ldap::params::server_service_manage,
  $service_name     = $ldap::params::server_service_name,
  $service_enable   = $ldap::params::server_service_enable,
  $service_ensure   = $ldap::params::server_service_ensure,
  $config_directory = $ldap::params::ldap_config_directory,
  $config_file      = $ldap::params::server_config_file,
  $config_template  = $ldap::params::server_config_template,
  $default_file     = $ldap::params::server_default_file,
  $default_template = $ldap::params::server_default_template,
  $db_config_file     = $ldap::params::server_db_config_file,
  $db_config_template = $ldap::params::server_db_config_template,
  $gem_name         = $ldap::params::gem_name,
  $gem_ensure       = $ldap::params::gem_ensure,
) inherits ldap::params {

  include stdlib

  validate_string($suffix)
  validate_string($rootdn)
  validate_string($rootpw)
  validate_absolute_path($directory)
  validate_string($log_level)
  validate_array($schemas)
  validate_array($modules)
  validate_array($indexes)
  validate_array($overlays)
  validate_bool($ssl)
  if $ssl == true {
    validate_absolute_path($ssl_cacert)
    # RedHat is linked against Mozilla NSS.
    # $ssl_ca is pointing to the cert db directory, /etc/openldap/certs
    # $ssl_cert is the name of the server certificate in that db, "OpenLDAP Server"
    # $ssl_key is file containing the password for the db, /etc/openldap/certs/password
    if $::osfamily != 'RedHat' {
      validate_absolute_path($ssl_cert)
    }
    validate_absolute_path($ssl_key)
  }
  validate_bool($bind_anon)
  validate_bool($bind_v2)

  anchor { 'ldap::server::begin': } ->
  class { '::ldap::server::install': } ->
  class { '::ldap::server::config': } ~>
  class { '::ldap::server::service': } ->
  anchor { 'ldap::server::end': }
<<<<<<< HEAD
=======
=======

>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
define ldap::server (
  $ensure                = $ldap::server::config::ensure,
  $server_nodes          = $ldap::server::config::server_nodes,
  $client_nodes          = $ldap::server::config::client_nodes,
  $utils_nodes           = $ldap::server::config::utils_nodes,
  $admin_user            = $ldap::server::config::admin_user,
  $user                  = $ldap::server::config::user,
  $group                 = $ldap::server::config::group,
  $base_dn               = $ldap::server::config::base_dn,
  $password              = $ldap::server::config::password,
  $protocols             = $ldap::server::config::protocols,
  $protocol              = $ldap::server::config::protocol,
  $ldap_version          = $ldap::server::config::ldap_version,
  $server_addr           = $ldap::server::config::server_addr,
  $port                  = $ldap::server::config::port,
  $ssl_port              = $ldap::server::config::ssl_port,
  $search_timelimit      = $ldap::server::config::search_timelimit,
  $bind_timelimit        = $ldap::server::config::bind_timelimit,
  $idle_timelimit        = $ldap::server::config::idle_timelimit,
  $misc_dir              = $ldap::server::config::misc_dir,
  $ldap_conf_dir         = $ldap::server::config::ldap_conf_dir,
  $directory_base        = $ldap::server::config::directory_base,
  $directories           = $ldap::server::config::directories,
  $args_file             = $ldap::server::config::args_file,
  $log_level             = $ldap::server::config::log_level,
  $pid_file              = $ldap::server::config::pid_file,
  $tool_threads          = $ldap::server::config::tool_threads,
  $ssl_verify_certs      = $ldap::server::config::ssl_verify_certs,
  $ssl_cacert_file       = $ldap::server::config::ssl_cacert_file,
  $ssl_cacert_path       = $ldap::server::config::ssl_cacert_path,
  $ssl_cert_file         = $ldap::server::config::ssl_cert_file,
  $ssl_key_file          = $ldap::server::config::ssl_key_file,
  $ssl_cipher_suite      = $ldap::server::config::ssl_cipher_suite,
  $ssl_rand_file         = $ldap::server::config::ssl_rand_file,
  $ssl_ephemeral_file    = $ldap::server::config::ssl_ephemeral_file,
  $ssl_minimum           = $ldap::server::config::ssl_minimum,
  $ssl_mode              = $ldap::server::config::ssl_mode,
  $sasl_minssf           = $ldap::server::config::sasl_minssf,
  $sasl_maxssf           = $ldap::server::config::sasl_maxssf,
  $ssl_cert_country      = $ldap::server::config::ssl_cert_country,
  $ssl_cert_state        = $ldap::server::config::ssl_cert_state,
  $ssl_cert_city         = $ldap::server::config::ssl_cert_city,
  $ssl_cert_organization = $ldap::server::config::ssl_cert_organization,
  $ssl_cert_department   = $ldap::server::config::ssl_cert_department,
  $ssl_cert_domain       = $ldap::server::config::ssl_cert_domain,
  $ssl_cert_email        = $ldap::server::config::ssl_cert_email,
  $bind_policy           = $ldap::server::config::bind_policy,
  $pam_min_uid           = $ldap::server::config::pam_min_uid,
  $pam_max_uid           = $ldap::server::config::pam_max_uid,
  $exec_path             = $ldap::server::config::exec_path,
  $admin_directory       = $ldap::server::config::admin_directory
) {
  # Check to see if we have been called previously by utilizing as dummy
  # resource.
  if( defined( Ldap::Dummy[ 'ldap::server' ] ) ) {
    fail( 'The "ldap::server" define has already been called previously in your manifest!' )
  }
  ldap::dummy{ 'ldap::server': }

  $packages   = $ldap::server::config::packages
  $service   = $ldap::server::config::service
  $conf_files = $ldap::server::config::conf_files
  $schemas    = $ldap::server::config::schemas
  $db_mapping = $ldap::server::config::db_mapping

  $exec_remove_conf     = "rm -rf '${ldap_conf_dir}'"

  $server_init_file     = "${misc_dir}/server-init.ldif"
  $exec_server_init     = "slapadd -F '${ldap_conf_dir}' -d1 -n 0 -l '${server_init_file}' 2>&1"

  $server_populate_file = "${misc_dir}/server-populate.ldif"
  $exec_server_populate = "slapadd -F '${ldap_conf_dir}' -d1 -n 0 -l '${server_populate_file}' 2>&1"

  $exec_ssl_cert_create = "echo '${ssl_cert_country}\n${ssl_cert_state}\n${ssl_cert_city}\n${ssl_cert_organization}\n${ssl_cert_department}\n${ssl_cert_domain}\n${ssl_cert_email}' | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout '${ssl_key_file}' -out '${ssl_cert_file}'"
  $exec_ssl_cert_exists = "test -s '${ssl_cert_file}' || test -s '${ssl_key_file}'"

  $directory_init_file     = "${misc_dir}/directory-init.ldif"
  $exec_directory_init     = "ldapadd -Y EXTERNAL -H ldapi:/// -d1 -f '${directory_init_file}' 2>&1"
  $exec_directory_is_initialized  = "test -n \"`ldapsearch -Y EXTERNAL -H ldapi:/// -LLL -Q -b cn=config '(&(objectClass=olcDatabaseConfig)(olcSuffix=*))' dn`\""

  $directory_populate_file = "${misc_dir}/directory-populate.ldif"
  $exec_directory_populate = "ldapadd -Y EXTERNAL -H ldapi:/// -d1 -f '${directory_populate_file}' 2>&1"
  $exec_directory_is_populated  = "test -n \"`ldapsearch -Y EXTERNAL -H ldapi:/// -LLL -Q -b '${base_dn}' '(ou=${base_dn})' dn`\""

  Exec{
    user      => 'root',
    group     => 'root',
    path      => $exec_path,
    logoutput => 'on_failure',
  }

  File{
    ensure => 'file',
    owner  => $user,
    group  => $group,
    mode   => 0600,
  }

  # Do some sanity checking on the data.
  if( ! $ldap_conf_dir or $ldap_conf_dir == '' ) {
    fail( '"ldap_conf_dir" value is not set.  you must provide a value via the config or by passing it to this define.' )
  }
  if( ! $directory_base or $directory_base == '' ) {
    fail( '"directory_base" value is not set.  you must provide a value via the config or by passing it to this define.' )
  }

  case $ensure {
    'present': {
      # If our config directory does not exist at the start of the run, it is
      # safe to continue.  Otherwise, we don't want to do anything other than
      # install packages.
      exec{ 'ldap-notify-if-uninitialized':
<<<<<<< HEAD
        command  => 'true',
        notify   => Exec[ 'ldap-remove-conf' ],
        unless    => "test -d '${ldap_conf_dir}'",
=======
        command => true,
        notify  => Exec[ 'ldap-remove-conf' ],
        unless  => "test -d '${ldap_conf_dir}'",
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      # Install our packages after we checked for an existing config and before
      # we attempt to remove the config that might be put in place by the
      # packages.
      package{ $packages:
        ensure    => $ensure,
        subscribe => Exec[ 'ldap-notify-if-uninitialized' ],
        notify    => Service[ $service ],
      }

      # This only gets executed if our config did not exist at the beginning
      # so it is safe to blow away any config that exists immediately after
      # we install our packages.
      exec{ 'ldap-remove-conf':
        command     => $exec_remove_conf,
        require     => Package[ $packages ],
        notify      => Exec[ 'ldap-server-init' ],
<<<<<<< HEAD
        refreshonly => 'true',
=======
        refreshonly => true,
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      # Check to see if our directory base exists.  We don't want to touch
      # our ldap directory config if it does exist!
      exec{ 'ldap-notify-if-no-directory-base':
<<<<<<< HEAD
        command  => 'true',
        notify   => Exec[ 'ldap-directory-populate' ],
        before   => Directory[ $directory_base ],
        unless   => "test -d '${directory_base}'",
=======
        command => true,
        notify  => Exec[ 'ldap-directory-populate' ],
        before  => Directory[ $directory_base ],
        unless  => "test -d '${directory_base}'",
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      # Create the filesystem directories what will be used to store our
      # config and ldap directory data.
      directory{ [ $misc_dir, $directory_base, $ldap_conf_dir ]:
        ensure  => 'present',
        owner   => $user,
        group   => $group,
        mode    => 0700,
        recurse => true,
        require => Exec[ 'ldap-remove-conf' ],
        before  => Exec[ 'ldap-server-init' ],
      }

      # Make sure that we have an ssl certificate.  If not, generate a self-
      # signed certificate as long as the files are empty.
      if( ! defined( File[ $ssl_cert_file ] ) ) {
        file{ $ssl_cert_file:
          notify  => Exec[ 'ldap-ssl-cert-create' ],
        }
      }
      if( ! defined( File[ $ssl_key_file ] ) ) {
        file{ $ssl_key_file:
          notify  => Exec[ 'ldap-ssl-cert-create' ],
        }
      }
      exec{ 'ldap-ssl-cert-create':
        command     => $exec_ssl_cert_create,
        unless      => $exec_ssl_cert_exists,
        before      => Exec[ 'ldap-server-init' ],
<<<<<<< HEAD
        refreshonly => 'true',
=======
        refreshonly => true,
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      # Create our ldif files that will be used to configure our server
      file{ 'ldap-server-init':
        path    => $server_init_file,
        content => template( 'ldap/server/server-init.ldif' ),
        before  => Exec[ 'ldap-server-init' ],
      }
      file{ 'ldap-server-populate':
        path    => $server_populate_file,
        content => template( 'ldap/server/server-populate.ldif' ),
        before  => Exec[ 'ldap-server-populate' ],
      }

      # Install and configure our ldap::utils package as it provides tools that
      # are needed to do the configuration of our ldap directories.
      if( ! defined( Ldap::Utils[ 'ldap::utils' ] ) ) {
        include ldap::utils::config
        ldap::utils{ 'ldap::utils':
          ensure   => 'present',
          base_dn  => inline_template( '<%= directories.at(0) %>' ),
          password => $password,
        }
      }

      # Now that everything is in place, we can initialize our server config.
      # This is only done if we did not have a config in place to begin with.
      exec{ 'ldap-server-init':
<<<<<<< HEAD
        user      => $user,
        group     => $group,
        command   => $exec_server_init,
        require   => Ldap::Utils[ 'ldap::utils' ],
        refreshonly => 'true',
      }
      exec{ 'ldap-server-populate':
        user      => $user,
        group     => $group,
        command     => $exec_server_populate,
        subscribe   => Exec[ 'ldap-server-init' ],
        notify      => Service[ $service ],
        refreshonly => 'true',
=======
        user        => $user,
        group       => $group,
        command     => $exec_server_init,
        require     => Ldap::Utils[ 'ldap::utils' ],
        refreshonly => true,
      }
      exec{ 'ldap-server-populate':
        user        => $user,
        group       => $group,
        command     => $exec_server_populate,
        subscribe   => Exec[ 'ldap-server-init' ],
        notify      => Service[ $service ],
        refreshonly => true,
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      ldap::server::mk_directory_paths{ $directories:
        ensure         => $ensure,
        user           => $user,
        group          => $group,
        mode           => 0700,
        directory_base => $directory_base,
        before         => Exec[ 'ldap-directory-init' ],
      }
      
      # Restart our service once our config has been initialized.
      service{ $service:
<<<<<<< HEAD
        ensure    => 'running',
        enable    => 'true',
        before         => Exec[ 'ldap-directory-init' ],
=======
        ensure => 'running',
        enable => true,
        before => Exec[ 'ldap-directory-init' ],
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      # Now it is time to create our directories, but only if we created
      # our server config on this run.
      file{ 'ldap-directory-init':
        path    => $directory_init_file,
        content => template( 'ldap/server/directory-init.ldif' ),
        before  => Exec[ 'ldap-directory-init' ],
      }
      exec{ 'ldap-directory-init':
        command     => $exec_directory_init,
        subscribe   => Exec[ 'ldap-server-populate' ],
        unless      => $exec_directory_is_initialized,
<<<<<<< HEAD
        refreshonly => 'true'
=======
        refreshonly => true
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      # And now we can populate our directories as long as the directory base
      # did not exist when we started.
      file{ 'ldap-directory-populate':
        path    => $directory_populate_file,
        content => template( 'ldap/server/directory-populate.ldif' ),
        before  => Exec[ 'ldap-directory-populate' ],
      }
      exec{ 'ldap-directory-populate':
        command     => $exec_directory_populate,
        subscribe   => Exec[ 'ldap-directory-init' ],
        unless      => $exec_directory_is_populated,
<<<<<<< HEAD
        refreshonly => 'true',
=======
        refreshonly => true,
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }
    }

    'absent','purged': {
      package{ $packages:
<<<<<<< HEAD
        ensure => $ensure,
=======
        ensure  => $ensure,
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
        require => Service[ $service ],
      }

      service{ $service:
        ensure => 'stopped',
<<<<<<< HEAD
        enable => 'false',
=======
        enable => false,
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
      }

      directory{ $misc_dir:
        ensure  => 'absent',
        require => Service[ $service ],
      }

      if( $ensure == 'purged' ) {
        directory{ [ $directory_base, $ldap_conf_dir ]:
          ensure  => 'absent',
          require => Service[ $service ],
        }
      }
    }
    default: {
<<<<<<< HEAD
      fail( "'$ensure' is not a valid value for 'ensure'" )
=======
      fail( "'${ensure}' is not a valid value for 'ensure'" )
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
    }
  }

  ldap::toggle{ $conf_files:
    ensure => $ensure,
    notify => Service[ $service ],
  }
<<<<<<< HEAD
>>>>>>> 10220c1a980b9d78bb42c987e27b5b07236b6b89
=======
 }
>>>>>>> 33066c155e36d3920b86b49b3b83bf3d859f07c8
}
