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

class php(
  $versions,
  /* Hash values:
    php,
    dba,
    mysql,
    pgsql,
    pear,
    pecl_apc,
    pecl_memcache,
    mcrypt
  */
  $ensure
) {

  include php::params

  # PATTERN BEGIN init_modinf_from_params
  $module = $params::module
  $modinf = {
    name => $module,
    ensure => $ensure,
    version => $version,
    versions => $versions,
    logpath => $params::modinf[logpath],
    logfile => $params::modinf[logfile],
    pwdpath => $params::modinf[pwdpath],
    binpath => $params::modinf[binpath],
    outpath => $params::modinf[outpath],
    flagpath => $params::modinf[flagpath],
    filespath => $params::modinf[filespath],
  }
  #END PATTERN
      
  if $ensure != absent {
    
    ppext::module { $module : modinf => $modinf }
    ->
    class { 'php::prereqs' : modinf => $modinf }
    ->
    class { 'php::install_packages' : modinf => $modinf }
    ->
    class { 'php::config_files' : modinf => $modinf }
    ->
    class { 'php::test' : modinf => $modinf }

  } else {
  
    ppext::module { $module : modinf => $modinf }
    <-
    class { 'php::prereqs' : modinf => $modinf }
    <-
    class { 'php::install_packages' : modinf => $modinf }
    <-
    class { 'php::config_files' : modinf => $modinf }
               
  }
}
