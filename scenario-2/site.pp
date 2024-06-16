node 'puppet-agent' {
    include apache precheck
    include apache_enablerepo
    include apache_apacheinstall
    include apache_manageservice
    include exec
    Exec {
        path => ['/bin', '/usr/bom'],
    }
}