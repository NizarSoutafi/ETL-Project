#! /bin/bash
today=$(date +%Y%m%d)
weather_report=raw_data_$today


city=Casablanca
curl wttr.in/$city --output $weather_report


hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)


grep °C $weather_report > temperatures.txt


inst_temp=$(head -1 temperatures.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev)


fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | xargs | cut -d "C" -f2 | rev | cut -d " " -f2 |rev)


record=$(echo -e "$year\t$month\t$day\t$inst_temp\t$fc_temp")

echo $record>>rw_report.log
