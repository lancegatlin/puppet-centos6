/*
    Copyright 2013 Lance Gatlin

    Author: Lance Gatlin [lance.gatlin@gmail.com]
	
    This file is part of puppet-centos6.

    puppet-centos6 is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    puppet-centos6 is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with puppet-centos6. If not, see <http://www.gnu.org/licenses/>.

*/

/*class apache::default_vhost(
  $ensure,
  $serverName,
  $adminEmail,
  $aliases = undef,
  $dirOptions = '-Indexes FollowSymLinks',
  $dirAllowFrom = 'all'
) {
*/
/*  apache::vhost { 'default' :
    ensure => $ensure,
    port => 80,
    adminEmail => $adminEmail,
    path => '/var/www',
    serverName => $serverName,
    aliases => $aliases,
    useDefaultLogs => true,
  }
*/
/*  apache::vhost { 'default' :
    ensure => $ensure,
    port => 80,
    adminEmail => $adminEmail,
    path => '/var/www',
    serverName => 'localhost',
    aliases => undef,
    useDefaultLogs => true,
  }
       
  apache::directory { 'default':
    ensure => $ensure,
    vhost => 'default',
    htmlpath => '/var/www/html',
    dirOptions => $dirOptions,
    dirAllowFrom => $dirAllowFrom,
  }
            
}
*/
