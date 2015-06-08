#this is a macro that is used by the copyFromPnfs.sh macro. It creates a file that contains all the commands to be exectuted.
#syntax: source createListOfCmd.sh arg1 arg2 arg3
# arg1 is the path to the directory from which we want to copy
# arg2 is the path to the directory in which we want to copy
# arg3 is the string that each file to be copied should contained in their names (typically "root")


# first create a file that contains one line per file to be copied
# for each file a command like the following should be executed:
# dccp dcap://maite.iihe.ac.be/<arg1>/<file_i> <arg2> .


sourceDir=$1
targetDir=$2

echo "Printing the list of file in Directory ..."
echo $1
echo "with search pattern ... "

# declare few strings
Base="dccp dcap://maite.iihe.ac.be/"
Slash='/'
Space=' '

if [[ $3 ]]
then
    echo "pattern is " $3
    for file in `ls $1 | grep $3`
    do
        echo $Base$1$Slash$file$Space$2
    done
fi

if [[ ! $3 ]]
then
    echo "no pattern"
    for file in `ls $1`
    do
        echo $Base$1$Slash$file$Space$2
    done
fi




echo "Output in " $2