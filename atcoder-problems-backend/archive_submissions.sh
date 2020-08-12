#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

remote_dir="$1"
contest="$2"

psql -d atcoder << EOF
\a
\t
\o tmp/${contest}.json
select to_json(row) from (select * from submissions where contest_id='${contest}') row;
EOF

gzip -f "tmp/${contest}.json"
rsync "tmp/${contest}.json.gz" "${remote_dir}/${contest}.json.gz"
