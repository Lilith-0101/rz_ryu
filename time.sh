DATE=`date "+%Y-%m-%d"`
DATE_minute_ago_ten=`date -d '10 minute ago' | awk '{print $5}' | awk '{print substr($0, 0,4)}'`
DATE_minute_ago_yymmdd="$DATE $DATE_minute_ago_ten"
echo "$DATE_minute_ago_yymmdd";
