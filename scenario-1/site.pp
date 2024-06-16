node default {

    file {'/etc/motd':
        content => 'My Testing content',  # The content to be written into the '/etc/motd' file
    }

    service {'postfix':
        ensure => 'stopped',  # Ensure the 'postfix' service is stopped
        enable => 'false',    # Ensure the 'postfix' service is disabled from starting on boot
    }

}
