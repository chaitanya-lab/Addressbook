#!/bin/bash
createnewfile()
{
	echo "Enter the  address book name"
	read filename
	if [[ -f "$filename" ]]
	then
		echo "Error :file is already exits"
	else
		touch $filename
	fi
}
Display()
{
        echo "Enter the  address book name"
        read filename
        if [[ -f "$filename" ]]
        then
                cat $filename | sort
        else
                echo "Error :file is not existing"
        fi
}
search(){
	echo "enter the file exist or not"
	read filename
	if [ -f $filename ]
	then

		echo "enter full mobile you want to search if its true then it excute otherwise directly escap" 
		read mobile
		if [[ "${#mobile}" == 10 && "$mobile" == *[7-9]* && "$mobile" == *[0-9]* ]]
		then
			grep $mobile $filename
		else
			echo "pattern is wrong"
		fi

	else
		{print "file not exist"}
	fi
}
Insert()
{
        echo "Enter the  address book name"
        read filename
        if [[ -f "$filename" ]]
        then

			echo "enter the information"
			read -p "enter the first name:" fname
			read -p "enter the last name:" lname
			read -p "enter the street address:" streetaddress
			read -p "enter city name:" city
			read -p "enter the state name:" state
			read -p "enter the zip code:" zip
			read -p "enter mobile number:" mobile
			read -p "enter email addres:" email
			echo "$fname $lname $streetaddress $city $state $zip $mobile $email">>$filename
			sort $filename
			echo "Record inserted"


        else

                echo "Error :file is not existing"
        fi
}
del(){
	echo "Enter the choice 1.to delete file 2.for change data in file" n
	read n
	case $n in
		1)
			echo "enter the file which you want to delete"
			read filename
			if [ -f $filename ]
			then
				rm -r $filename
				echo "file is deleted"
			else
			echo "file not exists"
			fi
			;;
		2)
			 echo "enter the filename which you want to changed the deta of that file"
                        read filename

               		echo "Enter the line number (the first number of the entry) of the record you want to remove."
			read lineNumber
			if [ -f $filename ]
			then

					lineRemove="${lineNumber}d"
					sed -i -e "$lineRemove" $filename
					echo "The record was removed from the address book."
			else
				echo "file does not exists"
			fi
			;;
		*)
			echo "wrong choice"
			;;
	esac

}
modify()
{

		read -p "enter the filename in which you want to make chnages:" filename
		if [ -f $filename ]
		then

                read -p "To edit a record, enter any search string, e.g. last name :" Input
		echo "List records for is \"$Input\":"
		grep -n "$Input" "$filename"
		RETURNSTATUS=`echo $?`
		if [ $RETURNSTATUS -eq 1 ]
		then
                          echo "No records found for \"$Input\""
		else

			echo "Enter the line number that you'd like to edit."
			read lineNumber
			for line in `grep -n "$Input" "$filename"`
			do
				number=`echo "$line" | cut -c1`
				if [ $number == $lineNumber ]
					then
					echo "Enter the old data which you want to change"
					read old_data
					echo "Enter the new data which replace old one "
					read new_data
					sed -i "s|$old_data|$new_data|g" $filename
					echo "The change has been made."
				fi
			done

		fi
		else
			echo "file not exist"
		fi
}


while [ true ]
do
	echo "=======MENU========"
	echo "1.Crete 2.Display 3.search 4.Insert 5.delet 6.modify 7.exit"
	echo "Enter the Choice"
	read choice
	case $choice in
		1) createnewfile ;;
		2) Display ;;
		3) search ;;
		4) Insert ;;
		5) del ;;
		6) modify;;
		7) exit ;;
		*) echo "Wrong choice" ;;
	esac
done
