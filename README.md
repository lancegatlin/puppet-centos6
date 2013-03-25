Copyright 2013 Lance Gatlin

Author: Lance Gatlin [lance.gatlin@gmail.com]

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
<h5>Install Puppet for Centos 6.X</h5>
* For puppet packages, install the EPEL repo:
* i386:

<code lang="text">
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm
</code>
* x86_64:

<code lang="text">
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
</code>
* Install required packages for puppet:

<code lang="text">
yum install puppet facter ruby ruby-libs ruby-shadow rubygems rubygem-activesupport cronie
</code>

<h5>Package Install Using Puppet</h5>
* Install GIT:

<code lang="text">
yum install git
</code>
* Check-out puppet modules:

<code lang="text">
git clone https://github.com/lancegatlin/puppet-centos6.git /usr/share/puppet/modules/
</code>
* Edit ~/site.pp to the following:

```puppet
node default {
  class { webserver1 :
    ensure => latest,
    password => 'YOUR_PASSWORD_HERE',
  }
  # Other modules (such as mediawiki) go here!
}
```
* Get a fresh repo db for yum (important!):

<code lang="text">
yum clean all
</code>
* Apply the manifest:

<code lang="text">
puppet apply ~/site.pp
</code>

<h5>Using the wwwadmin module</h5>
* The wwwadmin utility provides access to web-accessible admin utilities such as phpmyadmin or phppgadmin
* The module provides an apache URL (/admin) that accepts connection ONLY from the localhost
* This URL is inaccessible to normal http/https requests
* To access /admin, an SSH session connecting to the server from a remote machine should be started
* The ports 80,443 and 8080 should be tunneled so that the remote machine's localhost maps to the server's localhost (127.0.0.1)
* Example using putty:
[[Image:wwwadmin-putty-tunnel-config.png|300px]]
* After enabling tunneling, to access /admin on the remote machine, navigate a browser to http://localhost/admin (this connects to the server as if it were from the server itself)
[[Image:wwwadmin-test.png|300px]]
