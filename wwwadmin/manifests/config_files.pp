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

define wwwadmin::config_files($modinf, $paths) {

  $basedir = $paths[basedir]
  $destpath = $paths[destpath]
  $apache_conffile = $paths[apache_conffile]
  $index_htmlfile = $paths[index_htmlfile]
  $phpinfo_phpfile = $paths[phpinfo_phpfile]
  
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
  
  # Apache configuration
  file { $destpath:
    ensure => $dirEnsure,
    mode => 755,
  }
  
  file { $index_htmlfile:
    content => template("wwwadmin/index.html.erb"),
  }
  
  file { $apache_conffile:
    content => template("wwwadmin/apache.conf.erb"),
  }
  
  # PHP info page file
  file { $phpinfo_phpfile:
    content => '<?php phpinfo();',
  }

  if $ensure != absent {
    File[$destpath] -> File[ $index_htmlfile ]
    File[$destpath] -> File[ $phpinfo_phpfile ]
  } else {
    File[$destpath] <- File[ $index_htmlfile ]
    File[$destpath] <- File[ $phpinfo_phpfile ]
  }
}
