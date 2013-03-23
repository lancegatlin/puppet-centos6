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

define phpmyadmin::uninstall($modinf, $destpath) {

  include ppext::params
  
  $module = $modinf[name]

  ppdb::runsql { "uninstall::drop_pma_db" :
    modinf => $ppext::params::uninstall_modinf,

    r_connect => $ppdb::params::r_mysql_root_connect,
    content => "DROP DATABASE phpmyadmin;DROP USER 'pma'@'localhost'",
  }
  ->
  file { $destpath:
    ensure => absent,
    recurse => true,
    force => true,
  }
                        
}
