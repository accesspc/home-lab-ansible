#!/bin/bash

echo '---' > all.yml
echo >> all.yml

for f in $(find roles/ -iname main.yml | xargs dirname | sed -e 's,/tasks,,g' -e 's,roles/,,g' | sort | uniq) ; do cat <<EOF
- name: all - $f
  hosts: all
  roles:
    - $f
  tags:
    - never
    - $f

EOF
done | tee -a all.yml
