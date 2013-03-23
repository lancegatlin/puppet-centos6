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

define mediawiki::init_database($modinf, $paths, $r_privconnect, $r_connect, $dbinf) { 

  $module = $modinf[name]
  
  file { $paths[init_dbcontent_sqlfile]:
    source => "puppet:///modules/mediawiki/$version/init_tables.sql",
    owner => root,
    group => root,
    mode => 600,
  }
  ->
  ppdb::connect { $r_privconnect[name]:
    resinf => $r_privconnect,
  }
  ->
  ppdb::connect { $r_connect[name]:
    resinf => $r_connect,
  }
  ->
  ppext::notifyonce { "${module}::initialize" : modinf => $modinf, }
  ~>
  ppdb::initialize_database { "${module}::initialize_database" :
    modinf => $modinf,
    
    r_connect => $r_privconnect,

    
    newDbName => $dbinf[database],

    userinf => $dbinf[user],
    
    refreshonly => true,
  }
  ~>
  backup::restore_or_initialize_dbcontent { "${module}::restore_or_initialize_dbcontent":
    modinf => $modinf,

    r_connect => $r_connect,
    
    init_dbcontent_sqlfile => $paths[init_dbcontent_sqlfile],
    
    refreshonly => true,
  }
    
}
                                            
