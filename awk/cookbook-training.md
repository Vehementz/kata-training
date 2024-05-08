Sure, here are four AWK kata training exercises that are inspired by realistic data processing tasks you might encounter in various scenarios:

### 1. Parsing CSV Files for Employee Data

**Objective**: Write an AWK script that reads a CSV file containing employee details and filters out employees from a specific department, displaying their names and salaries.


**Sample Input (employees.csv)**:
employees.csv
```
Name,Department,Salary
John Doe,Marketing,45000
Jane Smith,Engineering,70000
Emily Davis,Marketing,48000
Carlos Ray,Engineering,52000
```

**Expected Output for Engineering Department**:
```
Jane Smith 70000
Carlos Ray 52000
```

**AWK Script**:
./expexted-engineer.sh employees.csv
```awk
#!/usr/bin/awk -f
BEGIN { FS=","; OFS=" " }
$2 == "Engineering" { print $1, $3 }
```

### 2. Log File Error Counting

**Objective**: Write an AWK script to count how many times each type of error appears in a log file.

**Sample Input (system.log)**:
```
INFO System boot
ERROR Disk not found
WARNING Low memory
ERROR Unable to read file
INFO System shutdown
```

**Expected Output**:
```
ERROR: 2
WARNING: 1
```

**AWK Script**:
```awk
#!/usr/bin/awk -f
/INFO/ { next } # Skip info lines
{
    count[$1]++
}
END {
    for (type in count) {
        print type ":", count[type]
    }
}
```

### 3. Analyzing Web Server Access Logs

**Objective**: Write an AWK script to find the number of requests that resulted in HTTP status codes 200, 404, and 500 from a web server log.

**Sample Input (access.log)**:
```
192.168.1.1 - - [08/May/2024:12:00] "GET /index.html HTTP/1.1" 200 1024
192.168.1.2 - - [08/May/2024:12:05] "GET /about.html HTTP/1.1" 404 345
192.168.1.1 - - [08/May/2024:12:10] "POST /api/data HTTP/1.1" 500 12
```

**Expected Output**:
```
200: 1
404: 1
500: 1
```

**AWK Script**:
```awk
#!/usr/bin/awk -f
{
    status[$(NF-1)]++
}
END {
    for (code in status) {
        print code ":", status[code]
    }
}
```

### 4. Extracting and Summarizing Financial Transaction Amounts

**Objective**: Write an AWK script to summarize total transaction amounts from a financial log, categorized by transaction type (debit or credit).

**Sample Input (transactions.log)**:
```
2024-05-08 Debit 300.00
2024-05-08 Credit 500.00
2024-05-08 Debit 200.00
```

**Expected Output**:
```
Total Debit: 500.00
Total Credit: 500.00
```

**AWK Script**:
```awk
#!/usr/bin/awk -f
{
    total[$2] += $3
}
END {
    for (type in total) {
        printf "Total %s: %.2f\n", type, total[type]
    }
}
```

These exercises offer a mix of text processing challenges that are typical in various IT and data processing roles, enhancing familiarity with AWK's capabilities in handling files and data manipulation.