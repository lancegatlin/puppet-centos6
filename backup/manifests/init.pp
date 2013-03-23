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

class backup($dailyBackupCount, $weeklyBackupCount, $monthlyBackupCount, $ensure = undef) {

  include backup::params
  
  class { 'backup::install_files' : ensure => $ensure}
  ->
  class { 'backup::config_cron' :
    dailyBackupCount => $dailyBackupCount,
    weeklyBackupCount => $weeklyBackupCount,
    monthlyBackupCount => $monthlyBackupCount,
    ensure => $ensure,
  }
}
