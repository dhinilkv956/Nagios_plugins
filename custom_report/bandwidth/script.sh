#!/bin/bash
curl -XGET "http://10.10.10.10/nagiosxi/api/v1/objects/servicestatus?apikey=dasdsadadasdadasdsaEr&pretty=1&outputtype=xml" > /tmp/bandwidthreport.xml

paste <(xml_grep 'host_name' /tmp/bandwidthreport.xml --text_only ) <(xml_grep 'display_name' /tmp/bandwidthreport.xml --text_only) <(xml_grep 'status_text' /tmp/bandwidthreport.xml --text_only)  | grep -i bandwidth | tr "\\t" "," | sort -t "," -k3  -r > /var/www/html/bandwidth_report/file/output.csv

echo 'Host, Servicename, Service status' | cat - /var/www/html/bandwidth_report/file/output.csv > temp && mv -f temp /var/www/html/bandwidth_report/file/output.csv

column -s, -t /var/www/html/bandwidth_report/file/output.csv > /var/www/html/bandwidth_report/file/output.txt

