#!/bin/bash
LOGFILE="/home/vedant/logs/practice.log"
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)

ERROR_COUNT=$(grep "$YESTERDAY" $LOGFILE | grep -c "ERROR")
WARN_COUNT=$(grep "$YESTERDAY" $LOGFILE | grep -c "WARN")
if [ $ERROR_COUNT -gt 20 ]; then
    echo "⚠️ ALERT: $ERROR_COUNT errors detected on $YESTERDAY"

    grep "$YESTERDAY" $LOGFILE | grep "ERROR" | \
    awk '{print $7}' | sort | uniq -c | sort -rn | head -5
fi

if [ $WARN_COUNT -gt 20]; then
        echo " ALERT: $WARN_COUNT warnings detected in $YESTERDAY"

        grep "$YESTERDAY" $LOGFILE | grep "WARN" | \
        awk '{print $7}' | sort | uniq -c | sort -rn | head -5
fi