#
#!/bin/bash
#
deld=$( mysql -D pdns <<EOF
delete FROM records
EOF
)

dels=$( mysql -D pdns <<EOF
delete FROM domains
EOF
)


#
#!/bin/bash
#
#
deletd=$( mysql -D pdns <<EOF
delete FROM records Where name='$1'
EOF
)

delets=$( mysql -D pdns <<EOF
delete FROM records Where name='*.$1'
EOF
)

deld=$( mysql -D pdns <<EOF
delete FROM domains Where name='$1'
EOF
)

dels=$( mysql -D pdns <<EOF
delete FROM domains Where name='*.$1'
EOF
)


#
#!/bin/bash
#
#       check domains
#
output=$( mysql -N --raw --batch -e  'select name from pdns.domains')
echo $output


rowcnt=$(mysql --raw --batch -e 'select count(*) from pdns.domains' -s)
if [[ "${rowcnt}" = '0' ]];then
        echo "0 domains found"
        INFILE=$1
else
        echo "start sorting domains"
        echo "$output" > exep.csv
        grep -vf exep.csv $1 | sort -u > base.csv
        INFILE=base.csv
fi
#
#       read domains from domains.csv
#
#       create zone
#
if [ $# -ne 1 ] || [ ! -r $1 ]; then
                echo " Syntax: filename.sh <file> "
                        exit 1
fi
for DOMAIN_NAME in `cat $INFILE`
do
        echo "running command: pdnsutil create-zone ${DOMAIN_NAME}"
        echo
        /usr/bin/pdnsutil create-zone ${DOMAIN_NAME}
        #       /usr/bin/pdnsutil delete-zone ${DOMAIN_NAME}
        #       /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \@ A 1296000 66.94.118.137
        #       /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \* A 1296000 66.94.118.137
done


#       add @ A record
#
if [ $# -ne 1 ] || [ ! -r $1 ]; then
        echo " Syntax: filename.sh <file> "
        exit 1
fi
for DOMAIN_NAME in `cat $INFILE`
do
        echo "running command: pdnsutil create-zone ${DOMAIN_NAME}"
        echo
        #       /usr/bin/pdnsutil create-zone ${DOMAIN_NAME}
        #       /usr/bin/pdnsutil delete-zone ${DOMAIN_NAME}
        /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \@ A 1296000 66.94.118.137
        #       /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \* A 1296000 66.94.118.137
done
#       add * A record
#
if [ $# -ne 1 ] || [ ! -r $1 ]; then
        echo " Syntax: filename.sh <file> "
        exit 1
fi
for DOMAIN_NAME in `cat $INFILE`
do
                echo "running command: pdnsutil create-zone ${DOMAIN_NAME}"
                        echo
                        #       /usr/bin/pdnsutil create-zone ${DOMAIN_NAME}
                        #       /usr/bin/pdnsutil delete-zone ${DOMAIN_NAME}
                        #       /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \@ A 1296000 66.94.118.137
                        /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \* A 1296000 66.94.118.137
                done

                #       add @ AAAA record
                #
                if [ $# -ne 1 ] || [ ! -r $1 ]; then
                        echo " Syntax: filename.sh <file> "
                        exit 1
                fi

                for DOMAIN_NAME in `cat $INFILE`
                do
                        echo "running command: pdnsutil create-zone ${DOMAIN_NAME}"
                        echo
                        #       /usr/bin/pdnsutil create-zone ${DOMAIN_NAME}
                        #       /usr/bin/pdnsutil delete-zone ${DOMAIN_NAME}
                        /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \* AAAA 2605:a141:2088:7732::1
                        #       /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \* A 1296000 66.94.118.137
                done


                #       add * AAAA record
                #
                if [ $# -ne 1 ] || [ ! -r $1 ]; then
                        echo " Syntax: filename.sh <file> "
                        exit 1
                fi

                for DOMAIN_NAME in `cat $INFILE`
                do
                        echo "running command: pdnsutil create-zone ${DOMAIN_NAME}"
                        echo
                        /usr/bin/pdnsutil add-record ${DOMAIN_NAME} \@ AAAA 2605:a141:2088:7732::1
                done
echo "succes"
