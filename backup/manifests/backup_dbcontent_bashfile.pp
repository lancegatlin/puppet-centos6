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

define backup::backup_dbcontent_bashfile(
  $resinf,
  $r_dump
) {
  include backup::params, ppext::params

  $modinf = $resinf[modinf]
  $module = $modinf[name]
  $binpath = $modinf[binpath]
  if !has_key($modinf, backuppath) { fail("modinf[${modinf[name]}] is missing backuppath") }
  $backuppath = $modinf[backuppath]

  $dbName = $r_dump[database]
  $dumpfile = "${r_dump[modinf][binpath]}/${r_dump[resname]}"

  $MKDIR = $params::MKDIR

  ppext::bashfile { $resinf[name]:
    resinf => $resinf,
    command => [
      "$MKDIR -p $backuppath/dbcontent",
      "$dumpfile | gzip > $backuppath/dbcontent/$dbName.sql.gz",
    ],
  }
}
