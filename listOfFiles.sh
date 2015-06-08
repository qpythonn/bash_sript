# This is a small macro to list all the files contained in a directory.
#Syntax:
# source listOfFiles.sh arg1 arg2
# arg1 is the path to the directory in which we want to ls
# arg2 is an optionnal argument allowing to search for file containing "arg2" in their names 
#


echo "Printing the list of file in Directory ..."
Dir1=$1
echo $1
echo "with search pattern ... "


if [[ $2 ]]
then
    echo "pattern is " $2
    for file in `ls $1 | grep $2`
    do
	echo $file
    done    
fi

if [[ ! $2 ]]
then
    echo "no pattern"
    for file in `ls $1`
    do
	echo $file
    done    
fi