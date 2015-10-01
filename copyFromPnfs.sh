#this is a macro to copy all files from a pnfs directory to a given directory
#syntax: source copyFromPnfs.sh arg1 arg2 arg3
# arg1 is the path to the directory from which we want to copy
# arg2 is the path to the directory in which we want to copy
# arg3 is the string that each file to be copied should contained in their names (typically "root")
# arg4 When arg4 is = "merge", all root files in the $2 directory will be "hadd" and then erased.
# example source copyFromPnfs.sh /pnfs/iihe/cms/store/user/qpython/BTagging/FastSimStudy/TTJets_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/crab_TagVarInfo_FastSim_CMSSW748_Premix/150923_153827/0000/ /user/qpython/fromPnfs/CMSSW_748/crab_TagVarInfo_FastSim_CMSSW748_Premix root merge

# first creat the list of command
source createListOfCmd.sh $1 $2 $3 > preAwk.txt

# remove unnecessary line
awk '/^dccp/' preAwk.txt > postawk.txt

#create dir
mkdir $2

# copy the files
source postawk.txt

# move the txt files to the same location than the root files
mv preAwk.txt $2
mv postawk.txt $2

if [[ -n $4 ]] #check if variable is not empty
then
    if [[ $4 == "merge" ]]
    then
	cd $2
	echo "merging all root files using hadd"
	hadd all.root *.root
	echo "removing all 'sub'root files !!"
	rm -f Jet*.root
	cd -
    fi
fi

