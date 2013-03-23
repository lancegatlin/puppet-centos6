/*
    Copyright 2013 Lance Gatlin

    Author: Lance Gatlin [lance.gatlin@gmail.com]
	
    This file is part of puppet-centos-webserver.

    puppet-centos-webserver is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    puppet-centos-webserver is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with puppet-centos-webserver. If not, see <http://www.gnu.org/licenses/>.

*/

class backup::install_files($ensure = undef) {

  $path = $params::path

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
  
  file { $path :
    ensure => $dirEnsure,
    mode => 755,
  }
  ->
  file { "$path/current" :
    ensure => $dirEnsure,
    mode => 755,
  }
  ->
  # TODO: shift_backup uses a copy of named args, should be auto-generated 
  file { "$path/shift_backup.sh" :
    source => 'puppet:///modules/backup/shift_backup.sh',
    mode => 755,
  }
                 
}
