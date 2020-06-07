#!/bin/bash

curl -XGET "http://10.10.10.10/nagiosxi/api/v1/objects/hoststatus?current_state=1&apikey=dsadadasdsdaHegel&outputtype=xml" > output.xml

echo "" > hosts.txt
paste <(xml_grep 'name' output.xml --text_only) >> hosts.txt


wget --user=nagiosadmin --password='Nagios@!2018' -O /tmp/report -q "http://10.10.10.10/nagios/cgi-bin/avail.cgi?show_log_entries=&host=all&timeperiod=yesterday"


echo "" >availabilty.txt

IFS=$'\n'
for i in `cat hosts.txt`;
do
    grep "$i" /tmp/report | grep "hostUP"| grep -o '[^ ]*%' | head -n 1| sed 's/^.\{15\}//g' >> availabilty.txt;
done

echo "" >ping.txt

IFS=$'\n'
for i in `cat hosts.txt`;
do
        grep "$i;Ping" /usr/local/nagios/var/nagios.log  | tail -n 1 | awk '/lost/{print $NF}' >> ping.txt ;
done

#Convert xml to csv and save it to ouput.csv
paste hosts.txt availabilty.txt ping.txt | tr "\\t" "," | sort -t "," -k3  -r > output.csv

#Add header to ouput.csv
echo 'Host, %AVAILABILITY, %PACKET LOSS, Duration' | cat - output.csv > temp && mv -f temp output.csv
