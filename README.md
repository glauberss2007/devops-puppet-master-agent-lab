# devops-puppet-master-agent-lab
Training provioded by learning IT guide.

![image](https://github.com/glauberss2007/devops-puppet-master-agent-lab/assets/22028539/a2186ac3-13a7-44ef-b092-f2ca2a373a32)

## Puppet agent and server configuration

### Prerequisits:
1. Make sure both servers are accessible.
2. Internet will be necessary to install puppet packages.
3. DNS already configureed or etc/hosts for server name comunication.
4. Port 8140 opened on puppet server.

### Steps:
1. Install puppet labs repo on both nodes.
2. Install required packages on the master node "puppet".
3. Configure the puppet master server "puppet".
4. Generate the certificate from the puppet master node "puppet".
5. Install puppet agent packages on the client node "client1".
6. Configure the puppet agent on the client node "client1".
7. Generate the signing request certificate from the puppet agent node "client1".
8. Sign the certificates to be signed from the puppet master node "puppet".
9. Verify the certificate signed properly with the puppet master node?

### Installation

In the puppet master and clients execute:
```
yum -y update
yum -y isntall http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
```

Confirm the puppetlabs at /etc/yum.repos.d.

### Install required packages on the master node "puppet"

Now isntall the server on master:
```
yum -y install puppet-server
```

### Configure the puppet master server "puppet"

Acces the /etc/puppet/puppet.conf
```
nano /etc/puppet/puppet.conf
```

In thos file, main is for server and agent for clients:

For server conf file add:
```
[main]
...
dns_alt_names = puppet, puppetmaster, others...
certname = puppet
...
```

### Generate the certificate from the puppet master node "puppet".
Them execute:
```
sudo -u puppet puppet master --no-daemonize --verbose
```

As soos as you see the puppet version, execute a CRTL+c. (certificate created.

Now enable it:
```
systemctl start puppetmaster
systemctl enable puppetmaster
```

### Install puppet agent packages on the client node "client1".
```
yum -y install puppet
```

## Configure the puppet agent on the client.

Go to the congif file and add at agent:
```
server = puppetmastername
```
Save and ping the master to confir the comunication.

## Generate the signing request certificate from the puppet agent node "client"

To create the certificate:
```
puppet agent -t
```

## Sign the certificates to be signed from the puppet master node "puppet"

Access the server and show the certificats waiting for liberation:
```
puppet cert list
```

Them sign it using 
```
puppet cert sign puppet-client-name
```

### Verify the certificate signed properly with the puppet master node?
```
puppet agent --fingerprint
```

## Puppet manifest examples

Manifests are files with extension .pp, normally at /etc/puppet/manifests/ directory at puppet master. There we declare all the resource types status to be managed.

### Scenario 1

1000 servers conected to puppet master require the following operation managment:

- Modifying the file /etc/motd in all infra servers to add a content using puppet automation.
- Stopping postfix service in all servers.

Into the puppet server, go to the folder /etc/puppet/manifest/ and edit or creat the file site.pp with the content in []().


## Puppet modules

## Online & Offline modules

## References
- https://www.youtube.com/watch?v=jaA1Znru-Vw
- www.learnitguide.net
