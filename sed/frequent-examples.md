# Training Conducted by me for system team on different types of usages of SED command

The SED command in UNIX stands for stream editor and it can perform lot’s of functions on files like, searching, find and replace, insertion or deletion. Though most common use of SED commands in UNIX is for substitution or for find and replace.

## 1. Search and Replacing a string
To search & replace a string from the file, we will use the following example,

`sed 's/danger/safety/' testfile.txt`

here option **'s'** will search for word ‘danger’ & replace it with ‘safety’ on every line for the first occurrence only.

## 2. Search and replace a string from whole file
To replace the word completely from the file, we will use option **'g'**  with **'s'**

`sed 's/danger/safety/g' testfile.txt`

## 3. Replace the nth occurrence of string pattern
We can also substitute a string on nth occurrence from a file. Like replace ‘danger’ with ‘safety’ only on second occurrence,

`sed ‘s/danger/safety/2’ testfile.txt`

To replace ‘danger’ on 2nd occurrence of every line from whole file, use

`sed 's/danger/safety/2g' testfile.txt`
 
## 4. Replace a string on a particular line
To replace a string only from a particular line, use

`sed '4 s/danger/safety/' testfile.txt`

This will only substitute the string from 4th line of the file. We can also mention a range of lines instead of a single line,

`sed '4,9 s/danger/safety/' testfile.txt `
 
## 5. Displaying partial text of a file
With sed, we can view only some part of a file rather than seeing whole file. To see some lines of the file, use the following command,

`sed -n 22,29p testfile.txt`

## 6. Display all except some lines
To display all content of a file except for some portion, use the following command,

`sed 22,29d testfile.txt`

## 7. Display every 4th line starting with Nth line
Do display content of every 4th line starting with line number 2 or any other line, use the following command

`sed -n '2~4p' file.txt`
 
## 8. Adding Blank lines/spaces
To add a blank line after every non-blank line, we will use option ‘G’,

`sed G testfile.txt`
 
## 9. Add a line after/before the matched search
To add a new line with some content after every pattern match, use option ‘a’ ,

`sed '/danger/a "This is new line with text after match"' testfile.txt`

To add a new line with some content a before every pattern match, use option ‘i’,

`sed '/danger/i "This is new line with text before match" ' testfile.txt`

## 10. Deleting a line using sed command
To delete a line with sed from a file, use the following command,

`sed Nd testfile.txt`

where ‘N’ is the line number & option ‘d’ will delete the mentioned line number. 

To delete the last line of the file, use

`sed $d testfile.txt`

## 11. Deleting a range of lines
To delete a range of lines from the file, run

`sed '29,34d' testfile.txt`

This will delete lines 29 to 34 from `testfile.txt` file.

## 12. Deleting lines other than the mentioned
To delete lines other than the mentioned lines from a file, we will use ‘!’

`sed '29,34!d' testfile.txt`

here ‘!’ option is used as not, so it will reverse the condition 

i.e. will not delete the lines mentioned. All the lines other 29-34 will be deleted from the files testfile.txt.

## 13. Delete a file line starting with & ending with a pattern
To delete a line starting with a particular string & ending with another string, use

`sed -e 's/^danger.*stops$//g' testfile.txt`

This will delete the line with ‘danger’ on start & ‘stops’ in the end & it can have any number of words in between , ‘.*’ defines that part.


## 14. Change a whole line with matched pattern
To change a whole line to a new line when a search pattern matches we need to use option ‘c’ with sed,

`sed '/danger/c "This will be the new line" ' testfile.txt`

## 15. Running multiple sed commands
If we need to perform multiple sed expressions, we can use option ‘e’ to chain the sed commands,

`sed -e 's/danger/safety/g' -e 's/hate/love/' testfile.txt`

## 16. Making a backup copy before editing a file
To create a backup copy of a file before we edit it, use option ‘-i.bak’,

`sed -i.bak -e 's/danger/safety/g'  testfile.txt`

This will create a backup copy of the file with extension .bak. You can also use other extensions if you like.

## 17. Appending lines
To add some content before every line with sed & regex, use

`sed -e 's/.*/testing sed &/' testfile.txt`

So now every line will have ‘testing sed’ before it.

## 18. Removing all commented lines & empty lines
To remove all commented lines i.e. lines with # & all the empty lines,  use

`sed -e 's/#.*//;/^$/d' testfile.txt`

To only remove commented lines, use

`sed -e 's/#.*//' testfile.txt`

## 19. Get list of all usernames from /etc/passwd
To get the list of all usernames from /etc/passwd file, use

`sed 's/\([^:]*\).*/\1/' /etc/passwd`

a complete list all usernames will be generated on screen as output.

## 20. Prevent overwriting of system links with sed command

‘sed -i’ command has been known to remove system links & create only regular files in place of the link file. So to avoid such a situation & prevent ‘sed -i‘ from destroying the links, use ‘–follow-symklinks‘ options with the command being executed.
Let’s assume i want to disable SELinux on CentOS or RHEL Severs

`sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux`
 
 

