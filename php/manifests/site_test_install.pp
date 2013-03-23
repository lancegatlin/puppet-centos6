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

node default {  
  include bash,ppext
  
  class { 'apache' :
    version => '2.2*',
    ensure => latest,
  }
  
  class { 'php' :
    versions => {
      php => '5.3.3*',
      dba => '5.3.3*',
      mysql => '5.3.3*',
      pgsql => '5.3.3*',
      pear => '1.9*',
      pecl-apc => '3.1*',
      pecl-memcache => '3.0*',
      mcrypt => '5.3.3*',
    },
    ensure => latest,
  }

  realize Package['php-dba']
  realize Package['php-mysql']
  realize Package['php-pgsql']
  realize Package['php-pear']
  realize Package['php-pecl-apc']
  realize Package['php-pecl-memcache']
  
}
      
