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

class postgresql::install_packages($modinf) {

  $ensure = $modinf[ensure]
  $version = $modinf[version]
  
  $SERVICE = $params::SERVICE
  
  ppext::package { 'postgresql':
    version => $version,
    packageName => $params::pkg_pg,
    ensure => $ensure,
  }
  
  ppext::package { 'postgresql-server':
    version => $version,
    packageName => $params::pkg_pg_server,
    ensure => $ensure,
  }   

  if $ensure != absent {
    Ppext::Package['postgresql'] -> Ppext::Package['postgresql-server']
    
  } else {  
    Ppext::Package['postgresql'] <- Ppext::Package['postgresql-server']
  }
}
