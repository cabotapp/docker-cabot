#!/bin/bash
set -eu


# Resolve script directory. See http://stackoverflow.com/a/246128/107049
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"



if [[ $# -ne 1 ]]; then
	cat >&2 <<-EOT
		ERROR: missing destination file path

		$(basename $0) <backup.sql>
EOT
	exit 1
else
	SQL_FILE=$1
fi



cd "${DIR}/.."
exec docker-compose run --rm postgres pg_dumpall --host postgres --user postgres --clean > "${SQL_FILE}"

