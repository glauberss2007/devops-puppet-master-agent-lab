# DevOps Puppet Master-Agent Lab

This repository contains training materials provided by Learning IT Guide.

![Training Image](https://github.com/glauberss2007/devops-puppet-master-agent-lab/assets/22028539/a2186ac3-13a7-44ef-b092-f2ca2a373a32)

## Puppet Agent and Server Configuration

### Prerequisites:
1. Ensure both servers (master and agent) are accessible.
2. Internet connectivity is required to install Puppet packages.
3. Configure DNS or `/etc/hosts` for server name communication.
4. Open port 8140 on the Puppet server.

### Configuration Steps:
1. Install Puppet Labs repository on both nodes.
2. Install required packages on the master node (`puppet`).
3. Configure the Puppet master server (`puppet`).
4. Generate the certificate from the Puppet master node (`puppet`).
5. Install Puppet agent packages on the client node (`client1`).
6. Configure the Puppet agent on the client node (`client1`).
7. Generate the signing request certificate from the Puppet agent node (`client1`).
8. Sign the certificates from the Puppet master node (`puppet`).
9. Verify the certificate is signed properly with the Puppet master node.

### Installation

On both the Puppet master and clients, execute:
```sh
yum -y update
yum -y install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
```

Confirm the Puppet Labs repository is added in `/etc/yum.repos.d`.

### Install Required Packages on the Master Node (`puppet`)

Install the Puppet server on the master node:
```sh
yum -y install puppet-server
```

### Configure the Puppet Master Server (`puppet`)

Edit the configuration file `/etc/puppet/puppet.conf`:
```sh
nano /etc/puppet/puppet.conf
```

Add the following in the `[main]` section:
```conf
[main]
...
dns_alt_names = puppet, puppetmaster, others...
certname = puppet
...
```

### Generate the Certificate from the Puppet Master Node (`puppet`)

Execute:
```sh
sudo -u puppet puppet master --no-daemonize --verbose
```

As soon as you see the Puppet version, stop the process with `CTRL+C`. The certificate is now created.

Enable and start the Puppet master service:
```sh
systemctl start puppetmaster
systemctl enable puppetmaster
```

### Install Puppet Agent Packages on the Client Node (`client1`)

Install the Puppet agent:
```sh
yum -y install puppet
```

### Configure the Puppet Agent on the Client

Edit the configuration file and add the server name in the `[agent]` section:
```conf
server = puppetmastername
```
Save and test the connection to the master by pinging the master server.

### Generate the Signing Request Certificate from the Puppet Agent Node (`client1`)

Create the certificate:
```sh
puppet agent -t
```

### Sign the Certificates from the Puppet Master Node (`puppet`)

On the master server, list the certificates waiting to be signed:
```sh
puppet cert list
```

Sign the certificate:
```sh
puppet cert sign puppet-client-name
```

### Verify the Certificate is Signed Properly with the Puppet Master Node

Check the certificate fingerprint:
```sh
puppet agent --fingerprint
```

## Puppet Manifest Examples

Manifests are files with the `.pp` extension, typically located in the `/etc/puppet/manifests/` directory on the Puppet master. These files declare the resource types and their desired states to be managed.

### Scenario 1 - Change File and Service Status

For 1000 servers connected to the Puppet master, perform the following operations:
- Modify the `/etc/motd` file to add content using Puppet automation.
- Stop the postfix service on all servers.

On the Puppet server, go to the `/etc/puppet/manifests/` folder and edit or create the `site.pp` file with the desired content.

Use the `file` and `service` Puppet resources. Check available resources with `puppet resource --types`. For specific service status, use `puppet resource service postfix` or `puppet resource file /etc/motd`.

Clients periodically check the Puppet server for updates. To manually check for changes, use `puppet agent -t`.

To change the interval for server checks, add `runinterval = 15m` in the `[agent]` section of the Puppet agent configuration file (`/etc/puppet/puppet.conf`).

## Puppet Modules

A module is a collection of manifests and data (facts, files, templates, etc.) with a specific structure.

### Understanding Puppet Classes

A class in Puppet is a block of code that can be reused and included in different manifests. Classes help in organizing code and managing resources efficiently. They are defined in modules and can be applied to nodes or other classes. For example:

```puppet
class apache {
    package { 'httpd':
        ensure => installed,
    }
    service { 'httpd':
        ensure => running,
        enable => true,
    }
}
```

Classes can be included in manifests or other classes using the `include` statement:

```puppet
include apache
```

### Scenario 2 - Web Server Apache Module

Install and manage the Apache web server using a single manifest file. By using modules, operations are split into multiple manifest files and declared as classes using the `include` statement. Implementing Puppet modules makes the main file smaller and more readable.

More than 4000 Puppet modules are available from the community on Forge and GitHub.

### Installing Puppet Offline Modules

Visit [Puppet Forge](https://forge.puppet.com) and search for the desired module. Download and copy it to the Puppet server.

Install the module:
```sh
puppet module install PATHTODOWNLOAD
```

List installed packages and dependencies:
```sh
puppet module list
```

Create a manifest with class declarations to use the module.

### Installing Puppet Online Modules

If the Puppet server is online, install a module directly:
```sh
puppet module install MODULENAME
```

Find module names using:
```sh
puppet module search MODULENAME
```

## References
- [YouTube Tutorial](https://www.youtube.com/watch?v=jaA1Znru-Vw)
- [Learn IT Guide](http://www.learnitguide.net)
- [Puppet Documentation](https://puppet.com/docs/puppet/latest/puppet_index.html)
- [Puppet Forge](https://forge.puppet.com)
- [Puppet Modules on GitHub](https://github.com/puppetlabs)
