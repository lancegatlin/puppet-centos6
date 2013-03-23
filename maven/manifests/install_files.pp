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

class maven::install_files(
  $modinf,
  $mvnpath,
  $downloadURL,
  $unpackDir
) {

  $ensure = $modinf[ensure]
  $version = $modinf[version]

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
  
  file { $mvnpath :
    ensure => $dirEnsure,
    mode => 755,
  }
  ->
  ppext::download_files { "maven::download_files" :
    modinf => $modinf,
    downloadURL => $downloadURL,
    unpackDir => $unpackDir,
    destpath => $mvnpath,
    creates => "$mvnpath/bin/mvn",
  }
  ->
  # Make mvn and mvnDebug executable
  file { "$mvnpath/bin/mvn" :
    mode => 755,
  }
  ->
  file { "$mvnpath/bin/mvnDebug" :
    mode => 755,
  }
  ->   
  # Link the maven executable into /usr/bin
  file { $params::mvn_linkfile:
    ensure => $linkEnsure,
    target => "$mvnpath/bin/mvn",
  }
}
