#!/bin/bash
echo "Content-type: text/html; charset=UTF-8"
echo  
echo "<html><body>"
echo "$(date)"
echo "<br><br>"
echo "<pre>$(/home/awkologist/BioLinux/blastalert.sh
)</pre>"
cp blastalert.txt /home/awkologist/BioLinux/blastalert-www.txt
echo "</html></body>"
