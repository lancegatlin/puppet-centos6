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

define ppdb::connect(
  $resinf
  
  /*
    name,
    resname,
    modinf = { ... },

    type, # Required. Currently either "mysql" or "postgresql"
    serverinf, # Optional. If not specified, localhost with default port is used
      host,
      port,
    userinf, # Required. User to connect as
      username,
      password, # Optional. If not specified the user's pwdfile will be used. Note that this will generate an error if it is missing. 
    database # Optional. Database to select. If nothing is specified, a db-specific database may be auto-selected
    },
  */ 
  ) {

  include ppdb::params, ppext::params

  $resname = $resinf[resname]
  $module = $resinf[modinf][name]

  $type = $resinf[type]
  $user = $resinf[userinf][username]

  if has_key($resinf, database) {
    $database = $resinf[database]
  } else {
    $database = 'default'
  }

  if has_key($resinf[serverinf], host) {
    $host = $resinf[serverinf][host]
  } else {
    $host = 'default'
  }

  if has_key($resinf[serverinf], port) {
    $port = $resinf[serverinf][port]
  } else {
    $port = 'default'
  }
  
  /* _VARNAME is used since VARNAME wont be detected in ruby template files */
  $_MYSQL = $params::MYSQL
  $_PSQL = $params::PSQL
  
  $pwdfile = "${resinf[modinf][pwdpath]}/$type.$user.pwd"
  
  if !defined(File[$pwdfile]) {
    if $resinf[userinf][password] {
      $password = $resinf[userinf][password]

      file { $pwdfile :
        content => template("ppdb/$type/pwdfile.erb"),
        mode => 600,
        owner => root,
        group => root,
      }
    } else {
      fail("Password is not set and pwdfile for user $user is not defined.")
    }
  }

  ppext::bashfile { $resinf[name] :
    resinf => $resinf,
    
    command => template("ppdb/$type/connect.sh.erb"),
    owner => root,
    group => root,
    mode => 700,

    namedArgs => true,
    optionalArgs => [ 'echo' ],
    help => "Usage:\n${resname} [--echo={1|0,1}]\nReads from stdin, writes to stdout. Echo '1' emits copy of SQL input (default).",
  }

}
