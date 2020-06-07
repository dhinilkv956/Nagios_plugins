#!/bin/bash

#This scripts gets the list of hosts that are down currently, converts it into csv and sends it out as mail

#Get data from Nagios using API and save it to output.xml
curl -XGET "http://10.22.20.161/nagiosxi/api/v1/objects/hoststatus?current_state=1&apikey=UPl6K42d7kI0bZeB0brLQe9DfAJK62Lg76FRpW4QB2QL0lCiP43FhsePidvHegel&outputtype=xml" > output.xml


> duration.txt
> durationresult.txt
paste <(xml_grep 'last_time_up' output.xml --text_only) >> duration.txt
cat duration.txt | sed "s/$/ `date '+%F %H:%M:%S'`/" > duration.txt

sed -i 's/^/"/;s/./&"/20;s/./&"/22;s/./&"/42' duration.txt


IFS=$'\n' ; for url in $(cat duration.txt); do eval dateutils "$url" >> durationresult.txt ; done

#Convert xml to csv and save it to ouput.csv
paste <(xml_grep 'display_name' output.xml --text_only) <(xml_grep 'address' output.xml --text_only) <(xml_grep 'last_hard_state_change' output.xml --text_only) durationresult.txt| tr "\\t" "," | sort -t "," -k3  -r > output.csv



#Add header to ouput.csv
echo 'Host, IP, Down since, Duration' | cat - output.csv > temp && mv -f temp output.csv

#Email output.csv to respected users

mv output.csv /var/www/html/report/file
