class users::users {
      user { 'greynolds':
      ensure      => present,
      managehome  => true,
       }
      }

      user { 'greynolds123':
      ensure     => present,
      managehome => true,
      password   => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }
   
      user { 'fds':
      ensure      => present,
      managehome  => true,
      password    => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }       
      
      user { 'sam':
      ensure      => present,
      managehome  => true,
      password    => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }

      user { 'mike':
      ensure      => present,
      managehome  => true,
      password    => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }
      
      user { 'jill':
      ensure      => present,
      managehome  => true,
      password    => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }
 
      user { 'Anne':
      ensure      => present,
      managehome  => true,
      password    => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }
         
      user { 'Bob':
      ensure     => present,
      managehome => true,
      password   => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }

      user { 'Bill':
      ensure      => present,
      managehome  => true,
      password    => '$1$nnCRygYZ$/qQeASIdxplrU3h11493J0',
      }

      user { 'Jane':
      ensure      => present,
      managehome  => true,
      password    => '$1$WRo1jSTE$V63lyDgSj8N7WaVQ4YJfO/',
      }

      if $user == user { 
          exec { 'change_password':
           command   => '/usr/bin/chage -d 0 $HOME/$user',
             onlyif  => "/bin/grep -c $HOME  $HOME/$user && exit 1 || exit 0",
      }
     }
