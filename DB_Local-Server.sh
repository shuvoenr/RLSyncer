#!/bin/sh
mysqldump -h localhost -u user_name db_name  | gzip > db_name.sql.gz
scp db_name.sql.gz user@10.xxx.xxx.xx:/home/user/public_html/Resource/DB
#Connect SSH Server
ssh -tt -o StrictHostKeyChecking=no user@10.xxx.xxx.xx -p 22 <<EOF
    cd /home/user/public_html/Resource/DB
    ls -la
    rm -r db_name.sql
    gzip -d db_name.sql.gz
    sed -i 's|DEFINER=[^*]*\*|\*|g' db_name.sql
    mysql -u equaltrue db_name < db_name.sql
    exit 0
EOF
#Successfully Done
echo "Successfully Done";
