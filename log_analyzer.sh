#!/bin/bash

LOG_FILE="practice.log" #swap with your path
REPORT_FILE="log_report_$(date +%Y%m%d).txt"

echo "🔍 Log Analysis Report - $(date)" > $REPORT_FILE
echo "======================================" >> $REPORT_FILE

# Total lines
TOTAL_LINES=$(wc -l < $LOG_FILE)
echo "📊 Total log entries: $TOTAL_LINES" >> $REPORT_FILE

# Error count
ERROR_COUNT=$(grep -c "ERROR" $LOG_FILE)
echo "❌ Total errors: $ERROR_COUNT" >> $REPORT_FILE

# Warning count
WARN_COUNT=$(grep -c "WARN" $LOG_FILE)
echo "⚠️  Total warnings: $WARN_COUNT" >> $REPORT_FILE

# Recent errors (last 10)
echo -e "\n🔴 Last 10 errors:" >> $REPORT_FILE
grep "ERROR" $LOG_FILE | tail -10 >> $REPORT_FILE

# Alert if errors exceed threshold
if [ $ERROR_COUNT -gt 50 ]; then
    echo -e "\n🚨 ALERT: Error threshold exceeded!" >> $REPORT_FILE
fi

# Display report
cat $REPORT_FILE