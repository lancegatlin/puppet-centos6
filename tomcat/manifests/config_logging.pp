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

class tomcat::config_logging($modinf, $paths) {

  $ensure = $modinf[ensure]
  
  # START PATTERN file_defaults
  $dirEnsure = $ensure ? { default => directory, absent => absent }
  $fileEnsure = $ensure ? { default => present, absent => absent }

  File {
    force => true,
    ensure => $fileEnsure,
    owner => root,
    group => root,
    mode => 644,
  }
  #END PATTERN
  $linkEnsure = $ensure ? { default => link, absent => absent }
  
  $javashare_path = $params::javashare_path
  $sharepath = $paths[sharepath]
  
  file { "$sharepath/lib/commons-logging.jar":
    ensure => $linkEnsure,
    target => "$javashare_path/commons-logging.jar",
  }
  file { "$sharepath/lib/log4j.jar":
    ensure => $linkEnsure,
    target => "$javashare_path/log4j.jar",
  }
  file { "$sharepath/lib/log4j.properties":
    source => "puppet:///modules/tomcat/log4j.rolling.properties",
  }
}
