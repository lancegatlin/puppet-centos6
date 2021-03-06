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

define mediawiki::prereqs($modinf, $dbType, $siteName, $paths) {

  $apache_shortURL_conffile = $paths[apache_shortURL_conffile]

  if $modinf[ensure] != absent {
    
    Class['backup'] -> Mediawiki::Prereqs[$name]
    Class['ppdb'] -> Mediawiki::Prereqs[$name]
    Class['apache'] -> Mediawiki::Prereqs[$name]
    Class['php'] -> Mediawiki::Prereqs[$name]
    Class['imagemagick'] -> Mediawiki::Prereqs[$name]
  
  
    case $dbType {
      'mysql' : {
        Package['mysql'] -> Mediawiki::Prereqs[$name]
        realize Package['php-mysql']
        Package['php-mysql'] -> Mediawiki::Prereqs[$name]
      }
      'postgresql' : {
        Package['postgresql'] -> Mediawiki::Prereqs[$name]
        realize Package['php-pgsql']
        Package['php-pgsql'] -> Mediawiki::Prereqs[$name]
      }
    }
  
    realize Package['php-pear'] 
    Package['php-pear'] -> Mediawiki::Prereqs[$name]
    realize Package['php-pecl-apc']
    Package['php-pecl-apc'] -> Mediawiki::Prereqs[$name]

#    File[$apache_shortURL_conffile] ~> Service['apache']

    Service['apache'] -> Mediawiki::Test[$name]
    
  } else {

    Class['backup'] <- Mediawiki::Prereqs[$name]
    Class['ppdb'] <- Mediawiki::Prereqs[$name]
    Class['apache'] <- Mediawiki::Prereqs[$name]
    Class['php'] <- Mediawiki::Prereqs[$name]
    Class['imagemagick'] <- Mediawiki::Prereqs[$name]


    case $dbType {
      'mysql' : {
        Package['mysql'] <- Mediawiki::Prereqs[$name]
        realize Package['php-mysql']
        Package['php-mysql'] <- Mediawiki::Prereqs[$name]
      }
      'postgresql' : {
         Package['postgresql'] <- Mediawiki::Prereqs[$name]
         realize Package['php-pgsql']
         Package['php-pgsql'] <- Mediawiki::Prereqs[$name]
      }
    }

    realize Package['php-pear']
    Package['php-pear'] <- Mediawiki::Prereqs[$name]
    realize Package['php-pecl-apc']
    Package['php-pecl-apc'] <- Mediawiki::Prereqs[$name]

    Mediawiki::Prereqs[$name] ~> Service['apache']
  }
}
