# Linux Practice

A collection of shell scripts and examples for practicing Linux command-line tools and log analysis techniques.

## Repository Contents

### Scripts

- **`everyday_log.sh`** - Script for daily log management tasks
- **`generate_logs.sh`** - Generates sample log files for practice
- **`log_analyzer.sh`** - Analyzes log files and extracts useful information

## Essential Linux Commands Reference

### grep - Search Text Patterns

The `grep` command searches for patterns in files or input streams.

**Basic Syntax:**
```bash
grep [options] pattern [file...]
```

**Common Options:**
- `-i` - Case insensitive search
- `-v` - Invert match (show lines that don't match)
- `-n` - Show line numbers
- `-r` or `-R` - Recursive search in directories
- `-c` - Count matching lines
- `-l` - Show only filenames with matches
- `-w` - Match whole words only
- `-A n` - Show n lines after match
- `-B n` - Show n lines before match
- `-C n` - Show n lines before and after match

**Examples:**
```bash
# Find all ERROR entries in a log file
grep "ERROR" practice.log

# Case-insensitive search
grep -i "error" practice.log

# Count occurrences
grep -c "ERROR" practice.log

# Show line numbers
grep -n "ERROR" practice.log

# Search multiple files
grep "ERROR" *.log

# Exclude lines with a pattern
grep -v "INFO" practice.log

# Use regular expressions
grep "ERROR.*timeout" practice.log
```

### awk - Pattern Scanning and Processing

`awk` is a powerful text processing tool that works with columns and patterns.

**Basic Syntax:**
```bash
awk 'pattern { action }' file
```

**Built-in Variables:**
- `$0` - Entire line
- `$1, $2, $3...` - First, second, third field
- `NR` - Current line number
- `NF` - Number of fields in current line
- `FS` - Field separator (default: whitespace)
- `OFS` - Output field separator

**Examples:**
```bash
# Print specific columns (1st and 3rd)
awk '{print $1, $3}' file.txt

# Print lines where 3rd column > 100
awk '$3 > 100' file.txt

# Calculate sum of a column
awk '{sum += $3} END {print sum}' file.txt

# Count lines
awk 'END {print NR}' file.txt

# Use custom field separator
awk -F':' '{print $1}' /etc/passwd

# Pattern matching
awk '/ERROR/ {print $0}' practice.log

# Print line numbers with content
awk '{print NR, $0}' file.txt

# Calculate average
awk '{sum+=$1; count++} END {print sum/count}' numbers.txt
```

### sed - Stream Editor

`sed` is used for text transformations and substitutions.

**Basic Syntax:**
```bash
sed [options] 'command' file
```

**Common Commands:**
- `s/pattern/replacement/` - Substitute
- `d` - Delete
- `p` - Print
- `a` - Append
- `i` - Insert

**Common Options:**
- `-i` - Edit file in-place
- `-n` - Suppress automatic printing
- `-e` - Multiple commands

**Examples:**
```bash
# Replace first occurrence in each line
sed 's/old/new/' file.txt

# Replace all occurrences (global)
sed 's/old/new/g' file.txt

# Delete lines containing pattern
sed '/pattern/d' file.txt

# Delete lines 5-10
sed '5,10d' file.txt

# Print only lines 20-30
sed -n '20,30p' file.txt

# Replace in-place (modify file)
sed -i 's/old/new/g' file.txt

# Multiple substitutions
sed -e 's/cat/dog/g' -e 's/dog/wolf/g' file.txt

# Insert text before line 5
sed '5i\New line text' file.txt

# Append text after matching line
sed '/pattern/a\New line after match' file.txt
```

### cut - Extract Columns

Extract specific columns or character positions from text.

**Examples:**
```bash
# Extract 1st and 3rd fields (delimiter: space)
cut -d' ' -f1,3 file.txt

# Extract characters 1-10
cut -c1-10 file.txt

# Use colon as delimiter
cut -d':' -f1 /etc/passwd

# Extract multiple fields
cut -d',' -f1,3,5 data.csv
```

### sort - Sort Lines

Sort text lines alphabetically or numerically.

**Examples:**
```bash
# Sort alphabetically
sort file.txt

# Sort numerically
sort -n numbers.txt

# Reverse sort
sort -r file.txt

# Sort by specific column
sort -k2 file.txt

# Sort and remove duplicates
sort -u file.txt

# Sort by numeric value in 3rd column
sort -k3 -n file.txt
```

### uniq - Remove Duplicates

Remove or count duplicate adjacent lines (usually used after sort).

**Examples:**
```bash
# Remove duplicate lines
sort file.txt | uniq

# Count occurrences
sort file.txt | uniq -c

# Show only duplicates
sort file.txt | uniq -d

# Show only unique lines (no duplicates)
sort file.txt | uniq -u
```

### wc - Word Count

Count lines, words, and characters.

**Examples:**
```bash
# Count lines
wc -l file.txt

# Count words
wc -w file.txt

# Count characters
wc -c file.txt

# All statistics
wc file.txt
```

### head and tail - View File Parts

View the beginning or end of files.

**Examples:**
```bash
# First 10 lines (default)
head file.txt

# First 20 lines
head -n 20 file.txt

# Last 10 lines (default)
tail file.txt

# Last 50 lines
tail -n 50 file.txt

# Follow file updates (useful for logs)
tail -f practice.log

# Last 100 lines and follow
tail -n 100 -f practice.log
```

### find - Search for Files

Search for files and directories.

**Examples:**
```bash
# Find all .log files
find . -name "*.log"

# Find files modified in last 24 hours
find . -mtime -1

# Find files larger than 100MB
find . -size +100M

# Find and delete
find . -name "*.tmp" -delete

# Find and execute command
find . -name "*.log" -exec grep "ERROR" {} \;
```

### xargs - Build Command Lines

Build and execute commands from standard input.

**Examples:**
```bash
# Find and remove files
find . -name "*.tmp" | xargs rm

# Grep in multiple files
find . -name "*.log" | xargs grep "ERROR"

# Process with custom command
cat urls.txt | xargs -I {} curl {}

# Parallel execution
cat list.txt | xargs -P 4 -I {} ./process.sh {}
```

## Common Log Analysis Examples

### Count log levels
```bash
grep -oE "(ERROR|WARN|INFO)" practice.log | sort | uniq -c
```

### Find errors with line numbers
```bash
grep -n "ERROR" practice.log
```

### Extract response times > 500ms
```bash
awk -F'[: ]' '$NF > 500 {print $0}' practice.log
```

### Get unique error messages
```bash
grep "ERROR" practice.log | sort | uniq
```

### Analyze logs by date
```bash
awk '{print $1}' practice.log | sort | uniq -c
```

### Top 10 slowest responses
```bash
grep -oE "[0-9]+ms" practice.log | sed 's/ms//' | sort -rn | head -10
```

### Count entries per hour
```bash
awk '{print $2}' practice.log | cut -d':' -f1 | sort | uniq -c
```

## Combining Commands (Pipelines)

The real power comes from combining these commands:

```bash
# Find all ERROR logs, extract timestamps, count by hour
grep "ERROR" practice.log | awk '{print $2}' | cut -d':' -f1 | sort | uniq -c

# Get average response time for WARN level
grep "WARN" practice.log | grep -oE "[0-9]+ms" | sed 's/ms//' | awk '{sum+=$1; n++} END {print sum/n}'

# Find top 5 most common log patterns
awk '{$1=$2=$3=""; print $0}' practice.log | sort | uniq -c | sort -rn | head -5
```

## Tips

1. Always test commands on sample data before running on production logs
2. Use `less` or `more` for viewing large files: `less practice.log`
3. Redirect output to save results: `command > output.txt`
4. Append to file: `command >> output.txt`
5. Use `tee` to view and save simultaneously: `command | tee output.txt`
6. Chain commands with `&&` for sequential execution: `cmd1 && cmd2 && cmd3`
7. Use `man` for detailed command documentation: `man grep`

## Practice Exercises

1. Generate logs using `generate_logs.sh`
2. Count how many ERROR, WARN, and INFO entries exist
3. Find the maximum and minimum response times
4. Extract all logs from a specific hour
5. Calculate average response time for each log level
6. Find all response times above the 95th percentile
7. Create a summary report with counts and statistics

## License

MIT License - Feel free to use for learning and practice.

## Contributing

Contributions welcome! Feel free to add more scripts and examples.
