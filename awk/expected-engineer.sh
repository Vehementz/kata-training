#!/usr/bin/awk -f
BEGIN { FS=","; OFS=" " }
$2 == "Engineering" { print $1, $3 }
