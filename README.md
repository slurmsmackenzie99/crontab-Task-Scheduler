# mycrontab Task Scheduler
mycrontab Task Scheduler is a user-friendly script that acts as interface. It is used to view/check, schedule/add, edit and remove tasks running on a Linux-based machine. 


It is created to make use of the crontab command easier for the user.

## Installation
You can install mycrontab Task Scheduler from this github [link](https://choosealicense.com/licenses/mit/).

This project is saved with an .sh extension which means it is a shell executable file. After downloading the file you can run it from a Linux terminal.

Before downloading it from a bash terminal you need to download [GIT](https:////git-scm.com/)

```bash
git clone https://github.com/USERNAME/OUR_PROJECT
```
## Usage

```bash
./mycrontab.sh
"1. Display crontab jobs
2. Insert a job
3. Edit a job
4. Remove a job
5. Remove all jobs
9. Exit"
```

**Displaying current jobs**

If you wish to display current crontab jobs press "1" when prompted. After displaying the current jobs (if there are any) you are asked whether you want to come back to the main menu.

```bash
./mycrontab.sh
1
"###### Display All Jobs ######
Current Cronjobs:
[YOUR CURRENT CRONJOBS]"
```
**Inserting a job - Preset**

If you wish to insert a cronjob press "2" when prompted.
```bash
./mycrontab.sh
2
"###### Insert a job ######
1 . Preset
2 . Custom "
```
From this position you can choose either a preset (pressing "1" or custom option (pressing "2"). Preset option lets you choose frequency of task execution without the knowledge of crontab command syntax.
```bash
./mycrontab.sh
2->1
"1 . Hourly
2 . Daily
3 . Weekly
4 . Monthly
5 . Yearly
6 . At reboot

Choose an option (1-6): ""
```
After selecting option 1-6 you will be asked to enter command you wish to run with the frequency selected before.

```bash
./mycrontab.sh
2->1->1-6
"Enter command to run: ""
```
After entering the command you wish to execute you will be given the description of your choice and asked to confirm the decision.

```bash
./mycrontab.sh
2->1->1-6->enter>
""At the beginning of [YOUR_CHOICE], 
run the following command: [YOUR_COMMAND]

Create the following new job? (y/n) OR (yes/no):""
```
After the confirmation (or disproof) you will return to the main menu.

**Inserting a job - Custom**

If you wish to add a custom job to the task scheduler select option 2 "Custom".

You will be asked to enter minute, hour, day, month and weekday frequency.

```bash
./mycrontab.sh
2->2
"Enter minute frequency (0-59):
Enter hour frequency (0-23):
Enter day frequency (1-31): 
Enter month frequency (1-12):
Enter weekday frequency (0-6):
"
```
After inputting all the necessary information you will be asked to enter command to execute 

```bash
./mycrontab.sh
2->2->
"Enter command to execute: "
```
After that program will display message about your job and frequency of it's execution. 

For example if you wish to create an empty text file at 10.30am every Sunday in January the program will display:
```bash
./mycrontab.sh
2->2->
"At 30 minute(s) past 10 on every day in January on Sunday, 
Run the following command: 
home/[USERNAME]/empty_text_file.txt""
```
**Editing a job**

If you wish to edit a job press key "3" and select number of the job you wish to edit.
```bash
./mycrontab.sh
3
"###### Edit A Job ######
[YOUR JOB LIST HERE]"
```
If there are no jobs the program will display a message saying "There are no jobs to edit" and return to the main menu. 

Upon choosing the job the program will ask for confirmation. After confirming you will, again, be able to enter either a preset job or a custom one. When edit is completed the program will display the message "Successfully edited a job." and will return to the main menu.

**Removing a single a job**

If you wish to delete a single job press "4". You will then see a numbered list of your current jobs (if there are any, otherwise you will be informed of lack thereof and return to the main menu). You will then be asked to enter the number of the job, asked for confirmation and informed about success of deletion.
```bash
./mycrontab.sh
4
"###### Remove A Job ######
[YOUR JOB LIST HERE]
Job to remove (Job Number): [ENTER THE NUMBER]
Remove this job? (y/n) OR (yes/no): [YES/NO]
Job has been removed
"
```

Let's talk about the technical details of this function, as it might have been the one that caused us the most trouble. The code for this function starts with instruction to display file with numbered lines, containing jobs. 
```bash
while :
	do
		#display file with numbered lines
		cat -n temp_crontab_userview
```
Following that is a piece of code containing instruction that saves number of lines in a variable. We also made use of a 'awk' command that searches for text patterns and process that is undertaken when the pattern is found.
```bash
#saves number of lines in line_count, awk prints the first field/job
		line_count="$(wc -l temp_crontab | awk '{print $1;}')"
```
To find out more about this command we encourage to check out this [link](https://www.geeksforgeeks.org/awk-command-unixlinux-examples/).

**Removing all jobs**

If you wish to remove all jobs press "5". You will be asked for confirmation and redirected to the main menu.
```bash
./mycrontab.sh
5
"###### Remove All Jobs ######
Remove all jobs? (y/n) OR (yes/no):[YES/NO]
All jobs have been removed
Returning to the main menu."
```
**Exiting the program**

When finished working on cronjobs you can easily exit the program selecting option 9 in the menu.
```bash
./mycrontab.sh
9
"Exiting.."
```

## Contributing
We encourage you to contribute to our small project. Pull requests are welcome.

## Distribution of tasks

Our 3 person team consisting of Edinburgh Napier University students was committed to make sure every member is involved in the process of creating the program. We aimed for equal distribution and good communication within the team. Thanks to all members being involved and active we managed to finish the project a week before the deadline. The distribution of tasks table is presented below:
| Yasmeen Ghanim                                  | Daniel Beardmore                         | Pawel Zmarlak          |
|-------------------------------------------------|------------------------------------------|------------------------|
| Task delegation & management, 1st, 2nd, 3rd job | Embedded comments & indentation, 5th job | Documentation, 4th job |

## Creators
This project was created by Edinburgh Napier University students for our Operating Systems coursework. Members:
- Yasmeen Ghanim
- Daniel Beardmore
- Pawel Zmarlak

Learn more: [Edinburgh Napier University](https://www.napier.ac.uk/)