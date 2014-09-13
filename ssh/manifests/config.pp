class ssh::config {    
    file { "/etc/ssh/ssh_config":  
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/ssh/ssh_config',
    require => Class['ssh::install'],
    notify  => Class['ssh::service'],
   }
    file { "/etc/ssh/sshd_config":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/ssh/sshd_config',
    require => Class['ssh::install'],
    notify  => Class['ssh::service'],
     }
   }

   if $operatingsystems == '/[Ubuntu|Debian]/' {
   file { "/etc/ssh/ssh_config":
   ensure  => present,
   owner   => 'root',
   group   => 'root',
   mode    => '0600',
   source  => 'puppet:///modules/ssh/ubuntu_ssh_config',
   require => Class['ssh::install'],
   notify  => Class['ssh::service'],
    }
  }  
   
   if $operatingsystems == '/[Ubuntu|Debian]/' {
   file { "/etc/ssh/sshd_config":
   ensure  => present,
   owner   => 'root',
   group   => 'root',
   mode    => '0600',
   source  => 'puppet:///modules/ssh/ubuntu_sshd_config',
   require => Class['ssh::install'],
   notify  => Class['ssh::service'],
    }
  }
