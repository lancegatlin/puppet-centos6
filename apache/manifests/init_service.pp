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

class apache::init_service($modinf) {

  $ensure = $modinf[ensure]

  #START PATTERN init_service
  $service_enable = $ensure ? { default => true, absent => false }
  $service_ensure = $ensure ? { default => running, absent => stopped }
  #END PATTERN
  
  service { 'apache' :
    name => $params::svc_apache,
    enable => $service_enable,
    ensure => $service_ensure,
    hasstatus => true,
    hasrestart => true,
  }
}
