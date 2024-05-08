Creating SED (Stream Editor) katas involves designing exercises that help you master text manipulation using sed's powerful pattern matching and substitution capabilities. Here are four sed kata training exercises inspired by realistic scenarios:

### 1. Formatting Phone Numbers

**Objective**: Write a sed script that reformats a list of phone numbers from various formats into a standard format `(XXX) XXX-XXXX`.

**Sample Input**:
```
1234567890
123 456 7890
123-456-7890
(123) 456 7890
```

**Expected Output**:
```
(123) 456-7890
(123) 456-7890
(123) 456-7890
(123) 456-7890
```

**SED Command**:
```bash
sed -E 's/[^0-9]+//g; s/(...)(...)(....)/(\1) \2-\3/' phone_numbers.txt
```

### 2. Removing HTML Tags from Documents

**Objective**: Write a sed script to strip HTML tags from a document, leaving only the visible text.

**Sample Input**:
```html
<p>This is <b>bold</b> text.</p>
```

**Expected Output**:
```
This is bold text.
```

**SED Command**:
```bash
sed 's/<[^>]*>//g' file.html
```

### 3. Converting CSV to TSV

**Objective**: Convert a comma-separated values (CSV) file into a tab-separated values (TSV) file using sed.

**Sample Input** (data.csv):
```
name,age,location
John Doe,28,New York
Jane Smith,32,California
```

**Expected Output**:
```
name    age location
John Doe    28  New York
Jane Smith  32  California
```

**SED Command**:
```bash
sed 's/,/\t/g' data.csv
```

### 4. Extracting Log File Entries

**Objective**: Write a sed script to extract log entries that contain errors and prepend the date from the log entry to each error message.

**Sample Input** (system.log):
```
2024-05-08 12:00 INFO System boot
2024-05-08 12:01 ERROR Disk not found
2024-05-08 12:02 WARNING Low memory
2024-05-08 12:03 ERROR Unable to read file
2024-05-08 12:04 INFO System shutdown
```

**Expected Output**:
```
2024-05-08 ERROR Disk not found
2024-05-08 ERROR Unable to read file
```

**SED Command**:
```bash
sed -n '/ERROR/p' system.log | sed 's/^[^ ]* [^ ]* \(.*\)$/\1/'
```

These katas provide a practical and targeted way to learn and refine sed scripting skills, especially for tasks involving text processing and pattern matching commonly encountered in data manipulation and log analysis.



