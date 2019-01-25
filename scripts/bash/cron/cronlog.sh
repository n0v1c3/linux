#!/bin/sh

echo "<h1>Results of <b>cronlog</b></h1>"
echo "<p>"
echo "<br />"
cat /var/log/cron.log
echo "<br />"
echo "</p>"
echo "<p><b>THE END</b></p>"
