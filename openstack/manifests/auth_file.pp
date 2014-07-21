#
# Creates an auth file that can be used to export
# environment variables that can be used to authenticate
# against a keystone server.
#
class openstack::auth_file(
  $admin_password,
<<<<<<< HEAD
  $controller_node      = '127.0.0.1',
=======
  $controller_node      = '192.168.153.155',
>>>>>>> de97c461b67f2d44779eaf61d0a3a1b8ff2a9e0f
  $keystone_admin_token = 'keystone_admin_token',
  $admin_user           = 'admin',
  $admin_tenant         = 'admin'
) {
  file { '/root/openrc':
    content =>
  "
  export OS_TENANT_NAME=${admin_tenant}
  export OS_USERNAME=${admin_user}
  export OS_PASSWORD=${admin_password}
  export OS_AUTH_URL=\"http://${controller_node}:5000/v2.0/\"
  export OS_AUTH_STRATEGY=keystone
  export SERVICE_TOKEN=${keystone_admin_token}
  export SERVICE_ENDPOINT=http://${controller_node}:35357/v2.0/
  "
  }
}
