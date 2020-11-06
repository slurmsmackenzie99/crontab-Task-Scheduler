#! /bin/bash

#Create output folder
touch temp_crontab
touch temp_crontab_userview
#Clear all information in the terminal
clear

#Function to start at new line in console
function new_line()
{
	#Send new line character to display
	echo -e "\n"
}

#Function to send all jobs to display 
function display_all_jobs()
{
	#Clear all information in the display
	clear
	#Sends message to display prior to sending all jobs
	echo "###### Display All Jobs ######

	Current Cronjobs: "
	
	#saves number of lines in line_count, awk prints the first field/jobTakes out the filename from the output and only prints the first
	#modified from: (2012, April 19). How to get “wc -l” to print just the number of lines without file name? Stackoverflow. https://stackoverflow.com/questions/10238363/how-to-get-wc-l-to-print-just-the-number-of-lines-without-file-name
	line_count="$(wc -l temp_crontab_userview | awk '{print$1;}')"
	
	#If there are no lines in file then  
	if [[ $line_count = 0 ]]
	then
		#Use new_line function to add white space in output
		new_line
		#Send message to output
		echo "no cronjobs for user"
		new_line
	#Otherwise send contents of file to display
	else
		new_line
		#Send each line to display
		cat -n temp_crontab_userview
		new_line
	#End if statement
	fi;

	#Start conditional loop
	while :
	do
		new_line
		#Get user input 
		read -p "Return to main menu? (y/yes): " confirmation;
		new_line
		#Change user input to lower case characters
		confirm=${confirmation,,}
		
		#If user input is "y" or "yes" then 
		if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
		then
			#send message to display
			echo "Returning to main menu.."
			#Pause program execution for 1 second
			sleep 1
			clear
			#Stop the conditional loop 
			break
		else 
			#Send error message to display
			echo "Invalid input - Please enter (y/yes)"
		#End if statement
		fi;
	#End conditional loop
	done 
}

#Function to add jobs to output file
function insert_jobs()
{
	#Clear all information in display
	clear
	
	#Start conditional loop
	while :
	do
		#Send message with choice options to display
		echo "###### Insert A Job ######

		1 . Preset
		2 . Custom"
		new_line
		
		#Recieve user input called choice
		read -p "Choose a preset or enter a specific periodicity: " choice;
		new_line
		#Start case statement to handle user input 
		case $choice in
			#Case 1 for choice input Preset
			1)
				#Start conditional loop 
				while :
				do
					echo "	  
					1 . Hourly
					2 . Daily
					3 . Weekly
					4 . Monthly
					5 . Yearly
					6 . At reboot"
					new_line
					#Recieve user input and assign to variable preset_type
					read -p "Choose an option (1-6): " preset_type;
					
					#Start case statement to handle preset_type
					case $preset_type in
						#Case 1 to handle preset_type 1 for hourly
						1)
							new_line
							#retrieve user input and assign to variable command
							read -p "Enter command to run: " command;
							new_line
							#Send message to display with user input 
							echo "At the beginning of every hour, run the following command: $command" 
							new_line
							
							#Start conditional loop
							while :
							do
								#Retrieve user input and assign to variable confrimation
								read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
								new_line
								#Change variable confirmation contents to lowercase
								confirm=${confirmation,,}
						
								#If user input is "y" or "yes" then add new job to output file
								if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
								then
									echo "Creating new job.."
									#Pause execution for 1 second
									sleep 1
									#Output message to file temp_crontab_userview
									echo "At the beginning of every hour, run the following command: $command" >> temp_crontab_userview
									#Output message to file temp_crontab
									echo "@hourly $command" >> temp_crontab
									#Upload jobs from temp_crontab file to user crontab
									crontab temp_crontab
									new_line
									echo "Returning to main menu.."
									sleep 1
									clear
									#Exit from inner loop
									break
								#Else if user enters "n" or "no" then don't create new job and retrun to menu
								elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
								then
									new_line
									echo "Returning to main menu without creating new job.."
									sleep 1
									clear
									#Exit from inner loop
									break
								#Else the user has entered an invalid input
								else 
									#Send error message to display
									echo "Invalid input - Please enter (y/n) OR (yes/no)"
									new_line
								#End if statement
								fi;
							#End conditional loop
							done
							#exit outer loop
							break
						;;
					
						#Case for preset_type 2 for daily 
						2)
							new_line
							#Retrieve command from user input 
							read -p "Enter command to run: " command;
							new_line
							#Send message to display
							echo "At the beginning of every day, run the following command: $command" 
							new_line

							#Start conditional loop
							while :
							do
								#Retrive user input and assign to variable confrimation
								read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
								new_line
								#Change variable confirmation contents to lowercase
								confirm=${confirmation,,}
						
								#If user input is "y" or "yes" then add new job to output files
								if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
								then
									echo "Creating new job.."
									sleep 1
									#Output message to file
									echo "At the beginning of every day, run the following command: $command" >> temp_crontab_userview
									#Output message to file 
									echo "@daily $command" >> temp_crontab
									#Upload jobs from temp_crontab file to user crontab
									crontab temp_crontab
									new_line
									echo "Returning to main menu.."
									#Stop progrma execution for 1 second
									sleep 1
									clear
									#leave the conditional loop
									break
								#else if "n" or "no" then return to main menu without adding job to files
								elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
								then
									new_line
									echo "Returning to main menu without creating new job.."
									sleep 1
									clear
									#Exit conditional loop
									break
								#Else send error message for invalid input 
								else 
									echo "Invalid input - Please enter (y/n) OR (yes/no)"
									new_line
								#End if statement
								fi;
							#End conditional loop
							done
							#Exit the outer loop
							break
						;;

						#Case to handle preset_type 3 for weekly
						3)
							new_line
							#Retrieve command from user input 
							read -p "Enter command to run: " command;
							new_line
							#Send message to display with user input 
							echo "At the beginning of every week, run the following command: $command" 
							new_line
							
							#Start conditional loop
							while :
							do	
								#Retrive user input and assign to variable confrimation
								read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
								new_line
								#Change variable confirmation contents to lowercase
								confirm=${confirmation,,}
						
								#If user input is "y" or "yes" then add new job to output files
								if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
								then
									echo "Creating new job.."
									sleep 1
									#Output message to file
									echo "At the beginning of every week, run the following command: $command" >> temp_crontab_userview
									#Output message to file
									echo "@weekly $command" >> temp_crontab
									#Upload jobs from temp_crontab file to user crontab
									crontab temp_crontab
									new_line
									echo "Returning to main menu.."
									sleep 1
									clear
									#Exit conditional loop
									break
								#else if "n" or "no" then return to main menu without adding job to files
								elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
								then
									new_line
									echo "Returning to main menu without creating new job.."
									sleep 1
									clear
									#Exit conditional loop
									break
								#Else send error message for invalid input 
								else 
									echo "Invalid input - Please enter (y/n) OR (yes/no)"
									new_line
								#End if statement
								fi;
							#End conditional loop
							done
							#exit the outer loop
							break
						;;
					
						#Case to handle preset_type 4 for monthly 
						4)
							new_line
							#Retrieve command from user input 
							read -p "Enter command to run: " command;
							new_line
							#Send message to display with user input 
							echo "At the beginning of every month, run the following command: $command" 
							new_line
							
							#Start conditional loop
							while :
							do
								#Retrive user input and assign to variable confrimation
								read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
								new_line
								#Change variable confirmation contents to lowercase
								confirm=${confirmation,,}
						
								#If user input is "y" or "yes" then add new job to output files
								if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
								then
									echo "Creating new job.."
									sleep 1
									#Output messages to files
									echo "At the beginning of every month, run the following command: $command" >> temp_crontab_userview
									echo "@monthly $command" >> temp_crontab
									#Upload jobs from temp_crontab file to user crontab
									crontab temp_crontab
									new_line
									echo "Returning to main menu.."
									sleep 1
									clear
									#Exit conditional loop
									break
								#else if "n" or "no" then return to main menu without adding job to files
								elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
								then
									new_line
									echo "Returning to main menu without creating new job.."
									sleep 1
									clear
									break
								#Else send error message for invalid input 
								else 
									echo "Invalid input - Please enter (y/n) OR (yes/no)"
									new_line
								#End if statement
								fi;
							#End conditional loop
							done
							#Exit outer loop
							break
						;;
					
						#Case to handle preset_type 5 for yearly
						5)
							new_line
							#Retrieve command from user input 
							read -p "Enter command to run: " command;
							new_line
							#Send message to display with user input 
							echo "At the beginning of every year, run the following command: $command" 
							new_line
							
							#Start conditional loop
							while :
							do
								#Retrive user input and assign to variable confrimation
								read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
								new_line
								#Change variable confirmation contents to lowercase
								confirm=${confirmation,,}
								
								#If user input is "y" or "yes" then add new job to output files
								if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
								then
								
									echo "Creating new job.."
									sleep 1
									#Output messages to files
									echo "At the beginning of every year, run the following command: $command" >> temp_crontab_userview
									echo "@yearly $command" >> temp_crontab
									#Upload jobs from temp_crontab file to user crontab
									crontab temp_crontab
									new_line
									echo "Returning to main menu.."
									sleep 1
									clear
									break
								#else if "n" or "no" then return to main menu without adding job to files
								elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
								then
									new_line
									echo "Returning to main menu without creating new job.."
									sleep 1
									clear
									break
								#Else send error message for invalid input 
								else 
									echo "Invalid input - Please enter (y/n) OR (yes/no)"
									new_line
								#End if statement
								fi;
							#End conditional loop
							done
							#Exit outer loop
							break
						;;
					
						#Case for preset_type 6 at reboot 
						6)
							new_line
							#Retrieve command from user input 
							read -p "Enter command to run: " command;
							new_line
							#Send message to display with user input 
							echo "At Reboot, run the following command: $command" 
							new_line
							
							#Start conditional loop
							while :
							do
								#Retrive user input and assign to variable confrimation
								read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
								new_line
								#Change variable confirmation contents to lowercase
								confirm=${confirmation,,}
						
								#If user input is "y" or "yes" then add new job to output files
								if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
								then
									echo "Creating new job.."
									sleep 1
									#Output messages to files
									echo "At Reboot, run the following command: $command" >> temp_crontab_userview
									echo "@reboot $command" >> temp_crontab
									#Upload jobs from temp_crontab file to user crontab
									crontab temp_crontab
									new_line
									echo "Returning to main menu.."
									sleep 1
									clear
									break
								#else if "n" or "no" then return to main menu without adding job to files
								elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
								then
									new_line
									echo "Returning to main menu without creating new job.."
									sleep 1
									clear
									break
								#Else send error message for invalid input 
								else 
									echo "Invalid input - Please enter (y/n) OR (yes/no)"
									new_line
								#End if statement
								fi;
							#End conditional loop
							done
							#Exit outer loop
							break
						;;
						
						#Final case to handle preset_type exceptions
						*)
							new_line
							#Send error message to display
							echo "Invalid input - Please enter a number in (1-6)"
							new_line
						;;
					#End case statement
					esac
				#End conditional loop
				done
				#Exit from outer loop
				break
			;;
			
			#Case 2 for choice input Custom
			2)
				#Declare variable and assign asterisk character for use
				asterisk="*"
				#Declare variable and assign zero character for use
				zero="0"
				
				#Start conditional loop
				while : 
				do
					#Recieve user input and assign to variable minute
					read -p "Enter minute frequency (0-59): " minute;
					
					#Convert minute variable to string data type 
					minutestr="$minute"
					
					#if minute string is an asterisk then 
					if [[ "$minutestr" = "$asterisk" ]]
					then
						#Set minute variable to "every"
						minute="every"
						new_line
						#Exit from the loop
						break
					#else if minute variable is greater than or equals zero and less than or equals 59 then
					elif [[ "$minute" -ge "$zero" && "$minute" -le 59 ]]
					then
						new_line
						#Exit the conditional loop
						break
					#Else then the minute input is not valid 
					else
						new_line
						#Send error message to display
						echo "Invalid Input - Please enter (0-59 OR *)"
						new_line
					#End if statement
					fi;
				#End conditional loop
				done
				
				#Start conditional loop 
				while : 
				do
					#Recieve user input and assign to variable hour
					read -p "Enter hour frequency (0-23): " hour;
					
					#Convert integer value to string data type 
					hourstr="$hour"
					
					#if hour string entered is an asterisk then 
					if [[ "$hourstr" = "$asterisk" ]]
					then
						#Set hour variable to "every"
						hour="every"
						new_line
						#Exit from the loop
						break
					#else if hour variable is greater than or equals zero and less than or equals 23 then
					elif [[ "$hour" -ge "$zero" && "$hour" -le 23 ]]
					then
						new_line
						#Exit from the loop
						break
					#Else then the minute input is not valid 
					else
						new_line
						#Send error message to display
						echo "Invalid Input - Please enter (0-23 OR *)"
						new_line
					#End if statement
					fi;
				#End conditional loop
				done
				
				#Start conditional loop
				while : 
				do
					#Recieve user input and assign to variable day
					read -p "Enter day frequency (1-31): " day;
					
					#Convert integer day to string data type
					daystr="$day"
					
					#if day string is an asterisk then 
					if [[ "$daystr" = "$asterisk" ]]
					then
						#Set day variable to every
						day="every"
						new_line
						#Exit from the loop
						break
					#Else if day is greater than or equal to 1 and day is less than or equal to 31
					elif [[ "$day" -ge 1 && "$day" -le 31 ]]
					then
						new_line
						#Exit from the loop
						break
					#Else then input is not valid 
					else
						new_line
						#Send error message to display
						echo "Invalid Input - Please enter (1-31 OR *)"
						new_line
					#End if statement
					fi;
				#End conditional loop
				done
				
				#Start conditional loop 
				while : 
				do
					#Recieve user input and assign to variable month
					read -p "Enter month frequency (1-12): " month;
					
					#convert integer to string data type 
					monthstr="$month"
					
					#if month string is an asterisk then 
					if [[ "$monthstr" = "$asterisk" ]]
					then
						#Set month to "every"
						month="every"
						new_line
						#Exit from conditional loop 
						break
					#Else if month is greater than or equal to 1 and less than or equal to 12 
					elif [[ "$month" -ge 1 && "$month" -le 12 ]]
					then
						new_line
						#Exit from conditional loop
						break
					#Else then input is not valid 	
					else
						new_line
						#Send error message to display
						echo "Invalid Input - Please enter (1-12 OR *)"
						new_line
					#End if statement
					fi;
				#End conditional loop
				done
				
				#Start case to select what month the user wants 
				case $month in
					#Set new value to month variable
					1)month="JAN";;
					2)month="FEB";;
					3)month="MAR";;
					4)month="APR";;
					5)month="MAY";;
					6)month="JUNE";;
					7)month="JULY";;
					8)month="AUG";;
					9)month="SEPT";;
					10)month="OCT";;
					11)month="NOV";;
					12)month="DEC";;
					*);;
				#End case statement
				esac
				
				#Start conditional loop 
				while : 
				do
					#Recieve user input and assign to variable weekday
					read -p "Enter weekday frequency (0-6): " weekday;
					
					#Convert weekday integer into string
					weekdaystr="$weekday"
					
					#If weekday string is an asterisk then 
					if [[ "$weekdaystr" = "$asterisk" ]]
					then
						#Set weekday variable to "every"
						weekday="every"
						new_line
						#Exit from conditional loop
						break
					#Else if weekday is greater than or equal to zero and less than or equal to 6
					elif [[ "$weekday" -ge "$zero" && "$weekday" -le 6 ]]
					then
						new_line
						#Exit from conditional loop
						break
					#Else then input is not valid 	
					else
						new_line
						#Send error message to display
						echo "Invalid Input - Please enter (0-6 OR *)(Sunday-Saturday)"
						new_line
					#End if statement
					fi;
				#End conditional loop
				done
				
				#Start case statement to select what weekday the user wants
				case $weekday in
					#Set new value to weekday variable
					0)weekday="SAT";;
					1)weekday="SUN";;
					2)weekday="MON";;
					3)weekday="TUE";;
					4)weekday="WED";;
					5)weekday="THU";;
					6)weekday="FRI";;
					*);;
				#End case statement
				esac
				
				#Retrieve user input and assign to variable command 
				read -p "Enter command to execute: " command;
				new_line
				
				#Start conditional loop
				while :
				do
					#Send output message to display 
					echo "At $minute minute(s) past $hour on $day day in $month on $weekday, Run the following command: $command"
					new_line

					#Retrieve user input and assign to variable confirmation
					read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
					new_line
					#Change variable confirmation contents to lowercase
					confirm=${confirmation,,}
					
					#If user input is "y" or "yes" then 
					if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
					then
						echo "Creating new job.."
						sleep 1
						#Send messages to output files 
						echo "At $minute minute(s) past $hour hour(s) on $day day in $month month on $weekday weekday, Run the following command: $command" >> temp_crontab_userview
						echo "$minute $hour $day $month $weekday $command" >> temp_crontab
						#Upload jobs from temp_crontab file to user crontab
						crontab temp_crontab
						new_line
						echo "Returning to main menu.."
						sleep 1
						clear
						#Exit from loop
						break
					#Else if user input is "n" or "no" then return to main menu without creating a new job
					elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
					then
						new_line
						echo "Returning to main menu without creating new job.."
						sleep 1
						clear
						break
					#Else then input is not valid 
					else 
						#Send error message to display 
						echo "Invalid input - Please enter (y/n) OR (yes/no)"
						new_line
					#End if statement 
					fi;
				#End conditional loop
				done
				#Exit conditional loop
				break
			;;
			
			#Final case to handle invalid choice input
			*)
				#Send error message to output
				echo "Invalid input - Please enter (1 OR 2)"
				new_line
			;;
		#End case statement
		esac
	#End conditional loop
	done
}

#Function to edit jobs from output file
function edit_jobs()
{
	clear
	echo "###### Edit A Job ######"
	new_line
	
	#Start conditional loop
	while :
	do
		#Declare variable and assign the value 0
		zero="0"
		
		#display file with numbered lines
		cat -n temp_crontab_userview
		
		#saves number of lines in line_count, awk prints the first field/job?
		line_count="$(wc -l temp_crontab | awk '{print $1;}')"
		
		#If the number of lines in the file are equal to zero then
		if [[ $line_count -eq "$zero" ]]  
		then 
			#Send message to display 
			echo "There are no jobs to edit."
			new_line
			echo "Returning to main menu.."
			#Stop program execution for 2 seconds
			sleep 2
			#Clear all information from terminal 
			clear
			break
		#End if statement
		fi;
		
		new_line
		#Recieve input from user and assign to variable line_number
		read -p "Job to Edit (Job Number): " line_number;
		
		#if line_number is less than or equal to the line count and greater than zero 
		if [[ $line_number -le $line_count && $line_number -gt "$zero" ]]
		then
			new_line
			
			#Start conditional loop
			while :
			do
				#Recieve user input and assign to variable confirmation
				read -p "Edit this job? (y/n) OR (yes/no): " confirmation;
				new_line
				#Change variable confirmation contents to lowercase
				confirm=${confirmation,,}

				#If confirm is "y" or "yes" then 
				if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
				then
					clear
					
					#Start conditional loop
					while :
					do
						
						echo "###### Edit A Job ######

						1 . Preset
						2 . Custom"
						new_line
						
						#Recieve user input and assign to variable choice 
						read -p "Choose a preset or enter a specific periodicity: " choice;
						new_line
						
						#Start case statement to handle choice input 
						case $choice in
							#Case 1 for choice preset
							1)
								#Start conditional loop
								while :
								do
									echo "	  
									1 . Hourly
									2 . Daily
									3 . Weekly
									4 . Monthly
									5 . Yearly
									6 . At reboot"
									new_line
									
									#Recieve user input and assign to variable preset_type
									read -p "Choose an option (1-6): " preset_type;
									
									#Start case statement to handle preset_type input 
									case $preset_type in
										#Case 1 for preset_type hourly
										1)
											new_line
											#Recieve user input and assign to variable command 
											read -p "Enter command to run: " command;
											new_line
											#Send message to display
											echo "At the beginning of every hour, run the following command: $command" 
											new_line
											
											#Start conditional loop 
											while :
											do
												#Recieve user input and assign to variable confirmation
												read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
												new_line
												#Change variable confirmation contents to lowercase
												confirm=${confirmation,,}
							
												#If confirm variable is "y" or "yes" then
												if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
												then
													echo "Creating new job.."
													sleep 1
													#Output messages to files
													echo "At the beginning of every hour, run the following command: $command" >> temp_crontab_userview
													echo "@hourly $command" >> temp_crontab
													#Upload jobs from temp_crontab file to user crontab
													crontab temp_crontab
													new_line
													
													#Delete the line number in temp_crontab file 
													sed -i "$line_number d" temp_crontab
													#Delete the line number in temp_crontab_userview file
													sed -i "$line_number d" temp_crontab_userview
													echo "Successfully edited a job"
													new_line
													
													echo "Returning to main menu"
													#Pause execution for 2 seconds
													sleep 2
													clear
													break
													clear
													break
												#Else if confirm is "n" or "no" then
												elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
												then
													#Return to main menu 
													new_line
													echo "Returning to main menu without saving changes.."
													#Pause execution for 1 second
													sleep 1
													clear
													break
												#Else then send error message to display
												else 
													echo "Invalid input - Please enter (y/n) OR (yes/no)"
													new_line
												#End if statement
												fi;
											#End conditional loop 
											done
											#Exit from conditional loop
											break
										;;
							
										#Case 2 to handle preset_type daily
										2)
											new_line
											#Recieve user input and assign to variable command 
											read -p "Enter command to run: " command;
											new_line
											#Send message to display
											echo "At the beginning of every day, run the following command: $command" 
											new_line
											
											#Start conditional loop
											while :
											do
												#Recieve user input and assign to variable confirmation
												read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
												new_line
												#Change variable confirmation contents to lowercase
												confirm=${confirmation,,}
							
												#If confirm variable is "y" or "yes" then
												if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
												then
													echo "Creating new job.."
													sleep 1
													#Output messages to files
													echo "At the beginning of every day, run the following command: $command" >> temp_crontab_userview
													echo "@daily $command" >> temp_crontab
													#Upload jobs from temp_crontab file to user crontab
													crontab temp_crontab
													new_line
													
													#Delete the line number in temp_crontab file 
													sed -i "$line_number d" temp_crontab
													#Delete the line number in temp_crontab_userview file
													sed -i "$line_number d" temp_crontab_userview
													echo "Successfully edited a job"
													new_line
													
													echo "Returning to main menu"
													#Stop program execution fo 2 seconds
													sleep 2
													clear
													break
													clear
													break
												#Else if confirm "n" or "no" then
												elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
												then
													#Return to main menu 
													new_line
													echo "Returning to main menu without saving changes.."
													#Pause execution for 1 second
													sleep 1
													clear
													break
												#Else then send error message to display
												else 
													echo "Invalid input - Please enter (y/n) OR (yes/no)"
													new_line
												#End if statement
												fi;
											#End conditional loop
											done
											#Exit from conditional loop
											break
										;;
									
										#Case 3 for preset_type weekly
										3)
											new_line
											#Recieve user input and assign to variable command 
											read -p "Enter command to run: " command;
											new_line
											#Send message to display
											echo "At the beginning of every week, run the following command: $command" 
											new_line
											
											#Start conditional loop
											while :
											do
												#Recieve user input and assign to variable confirmation
												read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
												new_line
												#Change variable confirmation contents to lowercase
												confirm=${confirmation,,}
							
												#If confirm variable is "y" or "yes" then
												if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
												then
													echo "Creating new job.."
													sleep 1
													#Output messages to files 
													echo "At the beginning of every week, run the following command: $command" >> temp_crontab_userview
													echo "@weekly $command" >> temp_crontab
													#Upload jobs from temp_crontab file to user crontab
													crontab temp_crontab
													new_line
													
													#Delete the line number in temp_crontab file 
													sed -i "$line_number d" temp_crontab
													#Delete the line number in temp_crontab_userview file
													sed -i "$line_number d" temp_crontab_userview
													echo "Successfully edited a job"
													new_line
													
													echo "Returning to main menu"
													#Stop program execution for 2 seconds
													sleep 2
													clear
													break
													clear
													break
												#Else if confirm "n" or "no" then
												elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
												then
													#Return to main menu 
													new_line
													echo "Returning to main menu without saving changes.."
													#Pause execution for 1 second
													sleep 1
													clear
													break
												#Else then send error message to display
												else 
													echo "Invalid input - Please enter (y/n) OR (yes/no)"
													new_line
												#End if statement
												fi;
											#End conditional loop
											done
											#Exit from conditional loop
											break
										;;
									
										#Case 4 for preset_type monthly 
										4)
											new_line
											#Recieve user input and assign to variable command 
											read -p "Enter command to run: " command;
											new_line
											#Send message to display
											echo "At the beginning of every month, run the following command: $command" 
											new_line
											
											#Start conditional loop
											while :
											do
												#Recieve user input and assign to variable confirmation
												read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
												new_line
												#Change variable confirmation contents to lowercase
												confirm=${confirmation,,}
							
												#If confirm variable is "y" or "yes" then
												if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
												then
													echo "Creating new job.."
													sleep 1
													#Output messages to files 
													echo "At the beginning of every month, run the following command: $command" >> temp_crontab_userview
													echo "@monthly $command" >> temp_crontab
													#Upload jobs from temp_crontab file to user crontab
													crontab temp_crontab
													new_line
													
													#Delete the line number in temp_crontab file 
													sed -i "$line_number d" temp_crontab
													#Delete the line number in temp_crontab_userview file
													sed -i "$line_number d" temp_crontab_userview
													echo "Successfully edited a job"
													new_line
													
													echo "Returning to main menu"
													#Stop program execution for 2 seconds
													sleep 2
													clear
													break
													clear
													break
												#Else if confirm "n" or "no" then
												elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
												then
													#Return to main menu 
													new_line
													echo "Returning to main menu without saving changes.."
													#Pause execution for 1 second
													sleep 1
													clear
													break
												#Else then send error message to display
												else 
													echo "Invalid input - Please enter (y/n) OR (yes/no)"
													new_line
												#End if statement
												fi;
											#End conditional loop
											done
											#Exit from conditional loop
											break
										;;
									
										#Case 5 for preset_type yearly
										5)
											new_line
											#Recieve user input and assign to variable command 
											read -p "Enter command to run: " command;
											new_line
											#Send message to display
											echo "At the beginning of every year, run the following command: $command" 
											new_line
											
											#Start conditional loop
											while :
											do
												#Recieve user input and assign to variable confirmation
												read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
												new_line
												#Change variable confirmation contents to lowercase
												confirm=${confirmation,,}
							
												#If confirm variable is "y" or "yes" then
												if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
												then
													echo "Creating new job.."
													sleep 1
													#Output messages to files 
													echo "At the beginning of every year, run the following command: $command" >> temp_crontab_userview
													echo "@yearly $command" >> temp_crontab
													#Upload jobs from temp_crontab file to user crontab
													crontab temp_crontab
													new_line
													
													#Delete the line number in temp_crontab file 
													sed -i "$line_number d" temp_crontab
													#Delete the line number in temp_crontab_userview file
													sed -i "$line_number d" temp_crontab_userview
													echo "Successfully edited a job"
													new_line
													
													echo "Returning to main menu"
													#Stop program execution for 2 seconds
													sleep 2
													clear
													break
													clear
													break
												#Else if confirm "n" or "no" then
												elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
												then
													#Return to main menu 
													new_line
													echo "Returning to main menu without saving changes.."
													#Pause execution for 1 second
													sleep 1
													clear
													break
												#Else then send error message to display
												else 
													echo "Invalid input - Please enter (y/n) OR (yes/no)"
													new_line
												#End if statement
												fi;
											#End conditional loop
											done
											#Exit from conditional loop
											break
										;;
									
										#Case 6 for preset_type at reboot
										6)
											new_line
											#Recieve user input and assign to variable command 
											read -p "Enter command to run: " command;
											new_line
											#Send message to display
											echo "At Reboot, run the following command: $command" 
											new_line
											
											#Start conditional loop
											while :
											do
											#Recieve user input and assign to variable confirmation
												read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
												new_line
												#Change variable confirmation contents to lowercase
												confirm=${confirmation,,}
							
												#If confirm variable is "y" or "yes" then
												if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
												then
													echo "Creating new job.."
													sleep 1
													#Output messages to files 
													echo "At Reboot, run the following command: $command" >> temp_crontab_userview
													echo "@reboot $command" >> temp_crontab
													#Upload jobs from temp_crontab file to user crontab
													crontab temp_crontab
													new_line
													
													#Delete the line number in temp_crontab file 
													sed -i "$line_number d" temp_crontab
													#Delete the line number in temp_crontab_userview file
													sed -i "$line_number d" temp_crontab_userview
													echo "Successfully edited a job"
													new_line
													
													echo "Returning to main menu"
													#Stop program execution for 2 seconds
													sleep 2
													clear
													break
													clear
													break
												#Else if confirm "n" or "no" then
												elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
												then
													#Return to main menu 
													new_line
													echo "Returning to main menu without saving changes.."
													#Pause execution for 1 second
													sleep 1
													clear
													break
												#Else then send error message to display
												else 
													echo "Invalid input - Please enter (y/n) OR (yes/no)"
													new_line
												#End if statement
												fi;
											#End conditional loop
											done
											#Exit from conditional loop
											break
										;;
										
										#Case to handle input exceptions
										*)
											new_line
											#Send error message for invalid input 
											echo "Invalid input - Please enter a number in (1-6)"
											new_line
											
										;;
									#End case statement
									esac
								#End conditional loop 
								done
								#Exit from conditional loop
								break	
							;;
						
							#Case 2 for choice custom
							2)
								#Declare variable and assign asterisk character for use
								asterisk="*"
								#Declare variable and assign zero character for use
								zero="0"
				
								#Start conditional loop
								while : 
								do
									#Recieve user input and assign to variable minute
									read -p "Enter minute frequency (0-59): " minute;
									
									#Convert minute variable to string data type 
									minutestr="$minute"
									
									#if minute string is an asterisk then 
									if [[ "$minutestr" = "$asterisk" ]]
									then
										#Set minute variable to "every"
										minute="every"
										new_line
										#Exit from the loop
										break
									#else if minute variable is greater than or equals zero and less than or equals 59 then
									elif [[ "$minute" -ge "$zero" && "$minute" -le 59 ]]
									then
										new_line
										#Exit the conditional loop
										break
									#Else then the minute input is not valid 
									else
										new_line
										#Send error message to display
										echo "Invalid Input - Please enter (0-59 OR *)"
										new_line
									#End if statement
									fi;
								#End conditional loop
								done

								#Start conditional loop 
								while : 
								do
									#Recieve user input and assign to variable hour
									read -p "Enter hour frequency (0-23): " hour;
									
									#Convert integer value to string data type 
									hourstr="$hour"
									
									#if hour string entered is an asterisk then 
									if [[ "$hourstr" = "$asterisk" ]]
									then
										#Set hour variable to "every"
										hour="every"
										new_line
										#Exit from the loop
										break
									#else if hour variable is greater than or equals zero and less than or equals 23 then
									elif [[ "$hour" -ge "$zero" && "$hour" -le 23 ]]
									then
										new_line
										#Exit from the loop
										break
									#Else then the minute input is not valid 
									else
										new_line
										#Send error message to display
										echo "Invalid Input - Please enter (0-23 OR *)"
										new_line
									#End if statement
									fi;
								#End conditional loop
								done
				
								#Start conditional loop
								while : 
								do
									#Recieve user input and assign to variable day
									read -p "Enter day frequency (1-31): " day;
									
									#Convert integer day to string data type
									daystr="$day"
									
									#if day string is an asterisk then 
									if [[ "$daystr" = "$asterisk" ]]
									then
										#Set day variable to every
										day="every"
										new_line
										#Exit from the loop
										break
									#Else if day is greater than or equal to 1 and day is less than or equal to 31
									elif [[ "$day" -ge 1 && "$day" -le 31 ]]
									then
										new_line
										#Exit from the loop
										break
									#Else then input is not valid 
									else
										new_line
										#Send error message to display
										echo "Invalid Input - Please enter (1-31 OR *)"
										new_line
									#End if statement
									fi;
								#End conditional loop
								done
				
								#Start conditional loop 
								while : 
								do
									#Recieve user input and assign to variable month
									read -p "Enter month frequency (1-12): " month;
									
									#convert integer to string data type 
									monthstr="$month"
									
									#if month string is an asterisk then 
									if [[ "$monthstr" = "$asterisk" ]]
									then
										#Set month to "every"
										month="every"
										new_line
										#Exit from conditional loop 
										break
									#Else if month is greater than or equal to 1 and less than or equal to 12 
									elif [[ "$month" -ge 1 && "$month" -le 12 ]]
									then
										new_line
										#Exit from conditional loop
										break
									#Else then input is not valid 	
									else
										new_line
										#Send error message to display
										echo "Invalid Input - Please enter (1-12 OR *)"
										new_line
									#End if statement
									fi;
								#End conditional loop
								done
							
								#Start case to select what month the user wants
								case $month in
									#Set new value to month variable
									1)month="JAN";;
									2)month="FEB";;
									3)month="MAR";;
									4)month="APR";;
									5)month="MAY";;
									6)month="JUNE";;
									7)month="JULY";;
									8)month="AUG";;
									9)month="SEPT";;
									10)month="OCT";;
									11)month="NOV";;
									12)month="DEC";;
									*);;
								#End case statement 
								esac
				
								#Start conditional loop 
								while : 
								do
									#Recieve user input and assign to variable weekday
									read -p "Enter weekday frequency (0-6): " weekday;
									
									#Convert weekday integer into string
									weekdaystr="$weekday"
									
									#If weekday string is an asterisk then 
									if [[ "$weekdaystr" = "$asterisk" ]]
									then
										#Set weekday variable to "every"
										weekday="every"
										new_line
										#Exit from conditional loop
										break
									#Else if weekday is greater than or equal to zero and less than or equal to 6
									elif [[ "$weekday" -ge "$zero" && "$weekday" -le 6 ]]
									then
										new_line
										#Exit from conditional loop
										break
									#Else then input is not valid 	
									else
										new_line
										#Send error message to display
										echo "Invalid Input - Please enter (0-6 OR *)(Sunday-Saturday)"
										new_line
									#End if statement
									fi;
								#End conditional loop
								done
					
							
								#Start case statement to select what weekday the user wants
								case $weekday in
									#Set new value to weekday variable
									0)weekday="SAT";;
									1)weekday="SUN";;
									2)weekday="MON";;
									3)weekday="TUE";;
									4)weekday="WED";;
									5)weekday="THU";;
									6)weekday="FRI";;
									*);;
								#End case statement
								esac
								
								#Retrieve user input and assign to variable command 
								read -p "Enter command to execute: " command;
								new_line
				
								#Start conditional loop
								while :
								do
									#Send output message to display 
									echo "At $minute minute(s) past $hour on $day day in $month on $weekday, Run the following command: $command"
									new_line

									#Retrieve user input and assign to variable confirmation
									read -p "Create the following new job? (y/n) OR (yes/no): " confirmation;
									new_line
									#Change variable confirmation contents to lowercase
									confirm=${confirmation,,}
									
									#If user input is "y" or "yes" then 
									if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
									then
										echo "Creating new job.."
										sleep 1
										#Send messages to output files 
										echo "At $minute minute(s) past $hour hour(s) on $day day in $month month on $weekday weekday, Run the following command: $command" >> temp_crontab_userview
										echo "$minute $hour $day $month $weekday $command" >> temp_crontab
										#Upload jobs from temp_crontab file to user crontab
										crontab temp_crontab
										new_line
										
										#Delete the line number in temp_crontab file 
										sed -i "$line_number d" temp_crontab
										#Delete the line number in temp_crontab_userview file
										sed -i "$line_number d" temp_crontab_userview
										echo "Successfully edited a job"
										new_line
										
										echo "Returning to main menu"
										#Pause execution for 2 seconds
										sleep 2
										clear
										break
										clear
										break
									#Else if confirm is "n" or "no" then
									elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]	
									then
										#Return to main menu 
										new_line
										echo "Returning to main menu without saving changes.."
										#Pause execution for 1 second
										sleep 1
										clear
										break
									#Else then send error message to display
									else 
										echo "Invalid input - Please enter (y/n) OR (yes/no)"
										new_line
									#End if statement
									fi;
								#End conditional loop 
								done
								#Exit from conditional loop
								break
							;;
							
							#Case to handle input exceptions
							*)
								#Send error message to display
								echo "Invalid input - Please enter (1 OR 2)"
								new_line
							;;
						#End case statement
						esac
					#End conditional loop
					done
					#Exit from conditional loop
					break
				
				#Else if confirm is "n" or "no" then 
				elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]
				then
					#Send message to display
					echo "No job has been edited"
					new_line
					echo "Returning to main menu.."
					new_line
					#Stop program execution for 1 second 
					sleep 1
					clear
					break
				#Else then handle input exceptions 
				else 
					#Send error message to display
					echo "Invalid input - Please enter (y/n) OR (yes/no)"
					new_line
				#End if statement
				fi;
			#End conditional loop
			done
			break
		
		#Else if the line_number selected is outwith the number of lines then
		elif [[ line_number > line_count ]] 
		then
			new_line
			#Send error message to display
			echo  "Given job number is not within task number range "
			new_line
		#End if statement 
		fi;  
	#End conditional loop
	done  
}

#Function to remove a single job from output file
function remove_one_job()
{
	clear
	echo "###### Remove A Job ######"
	new_line
	
	while :
	do
		#display file with numbered lines
		cat -n temp_crontab_userview
		#saves number of lines in line_count, awk prints the first field/job
		line_count="$(wc -l temp_crontab | awk '{print $1;}')"
		
		#If line_count is equal to 0 then
	    if [[ $line_count -eq 0 ]]  
		then 
			#Send message to display
			echo "There are no jobs to remove"
			new_line
			echo "Returning to main menu.."
			#Stop program execution fo 2 seconds 
			sleep 2
			clear
			break
		#End if statement
		fi;
		
		new_line
		#Receieve user input and assign to variable line_number
		read -p "Job to Remove (Job Number): " line_number;
		
		#if line number is less than or equal to line_count and greater than 0 then
		if [[ $line_number -le $line_count && $line_number -gt 0 ]]
		then
			new_line
			#Recieve user input and assign to variable confirmation
			read -p "Remove this job? (y/n) OR (yes/no): " confirmation;
			new_line
			#Change variable confirmation contents to lowercase
			confirm=${confirmation,,}

			#If confirm variable is "y" or "yes" then 
			if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
			then
				#Delete the line number in temp_crontab file 
				sed -i "$line_number d" temp_crontab
				#Delete the line number in temp_crontab_userview file
				sed -i "$line_number d" temp_crontab_userview
				
				#Send message to display
				echo "Job has been removed"
				new_line
				echo "Returning to main menu.."
				new_line
				#Stop program execution for 1 second 
				sleep 1
				clear
				#Exit from loop
				break
			#Else if confirm is "n" or "no" then 
			elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]
			then
				#Send message to display
				echo "No job has been removed"
				new_line
				echo "Returning to main menu.."
				new_line
				#Pause execution for 1 second
				sleep 1
				clear
				#Exit from loop
				break
			#Else then handle invalid input 
			else 
				#Send error message to display
				echo "Invalid input - Please enter (y/n) OR (yes/no)"
				new_line
			#End if statement
			fi;
		
		#Else if line_number is greater than line_count
		elif [[ line_number > line_count ]] 
		then
			new_line
			#Send error message to display
			echo  "Given job number is not within task number range "
			new_line
		#End if statement 
		fi;  
	#End conditional loop
	done        
}

#Function to remove all jobs from output file
function remove_all_jobs()
{
	#Clear all information in the display
	clear
	echo "###### Remove All Jobs ######"
	
	#Start conditional loop
	while :
	do
		new_line
		#Recieve user input and assign to variable confirmation
		read -p "Remove this job? (y/n) OR (yes/no): " confirmation;
		new_line
		#Change variable confirmation contents to lowercase
		confirm=${confirmation,,}

		#If confirm variable is "y" or "yes" then 
		if [[ "$confirm" = "y" ]] || [[ "$confirm" = "yes" ]]
		then
			echo "All jobs have been removed"
			#Change the amount of size of the file temp_crontab to zero
			truncate -s 0 temp_crontab
			#Change the amount of size of the file temp_crontab_userview to zero
			truncate -s 0 temp_crontab_userview
			
			#Upload jobs from temp_crontab file to user crontab
			crontab temp_crontab
			
			new_line
			echo "Returning to main menu.."
			new_line
			#Stop program execution for 1 second 
			sleep 1
			clear
			#Exit fron conditional loop
			break
		#Else if confirm is "n" or "no" then 
		elif [[ "$confirm" = "n" ]] || [[ "$confirm" = "no" ]]
		then
			#Send message to display
			echo "No jobs have been removed"
			new_line
			echo "Returning to main menu.."
			new_line
			#Stop program execution for 1 second 
			sleep 1
			clear
			#Exit from conditional loop
			break
		#Else then the input is not valid 
		else 
			#Send error message to display
			echo "Invalid input - Please enter (y/n) OR (yes/no)"
		#End if statement
		fi;
	#End conditional loop
	done
}

#Function to terminate program
function exit_confirmation()
{
	new_line
	echo "Exiting.."
	#Upload jobs from temp_crontab file to user crontab
	crontab temp_crontab
	#Stop program execution for 1 second 
	sleep 1
	#Remove data from output
	clear
	#Terminate the program
	exit
}

#Main Code	
#start conditional loop 
while :
do	
	echo -e "###### Main Menu ######

	1 . Display crontab jobs

	2 . Insert a job

	3 . Edit a job

	4 . Remove a job

	5 . Remove all jobs

	9 . Exit \n"
	
	#Recieve user input 
	read -p "Choose an option (1-5 , 9): " userInput;
	#Case to handle user input 
	case $userInput in 
		#If user enter 1 then call display_all_jobs function
		1)display_all_jobs;;
		#If user enters 2 then call insert_jobs function
		2)insert_jobs;;
		#If user enters 3 then call edit_jobs function
		3)edit_jobs;;
		#If user enter 4 then call remove_one_job function
		4)remove_one_job;;
		#If user enters 5 then call remove_all_jobs function
		5)remove_all_jobs;;
		#If user enters 9 then call exit_confirmation function
		9)exit_confirmation;;
		#Final case to handle user input exceptions
		*)	
			new_line 
			#Send error message to user
			echo "Invalid Input - Please enter a number in (1-5 , 9)"
			new_line
		;;
	#Close case statement
	esac
#end conditional loop
done
