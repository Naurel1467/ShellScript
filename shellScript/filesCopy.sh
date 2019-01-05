#directory name declaration
filesDirName="/C/Users/OM SAI RAM/HelloWorldSagar" 

#variable for iterating through files of above directory
i=0 

# for loop to iterate
for entry in "${filesDirName}"/* 
do
 # storing files in files array
  files[i]="$entry"
  
  # incrementing the variable
  let "i++" 
done

echo "Files list : "

 # printing the array
echo ${files[@]}

#storring current path into currentDir variable
currentDir="$(pwd)"
echo ${currentDir}

#chaning directory to parent folder
cd ..

#checking presence of directory output if exists it will delete
[ -d output ] && rm -r output

#creating output directory
mkdir output

#changing directory into newly created output directory
cd output

#creating directories for sourcecodefiles, binaryfiles and otherfiles
mkdir sourcecodefiles binaryfiles otherfiles

#changing directory into the directory where all files present
cd ../HelloWorldSagar

#listing files from a directory and storing into single variable
filesList=$(find . -type f -printf "%f\n")

#storing file names into one array
i=0
for file in ${filesList}
do
	echo ${file}
	echo ${i}
	allFiles[i]=${file}
	let "i++" 
done

#printing files name
echo "All files in a single line"
echo ${allFiles[@]}

#fetching source code and binary extension from source and binary files

#changing directory into path where files are located
cd ../shellScript

i=0;
while read name; do
	
    sourceExtension[i]=${name}
	let "i++"
	
done < sourcecode.txt

#printing source code extensions
echo "Source Code Extension"
echo ${sourceExtension[@]}

i=0;
while read name; do
	
    binaryExtension[i]=${name}
	let "i++"
	
done < binaryfiles.txt

#printing binary code extensions
echo "Binary Code Extension"
echo ${binaryExtension[@]}

echo $(pwd)

cd ../output

#fetching files according to extension
echo ${allFiles[@]}
echo "" > sourceCodeFile.txt
echo "" > binaryCodeFile.txt
echo "" > otherFile.txt


for file in ${allFiles[@]}
do
	booleanvariable=true
	
	for (( i=0; i < ${#sourceExtension[@]}; i++ ))
	do
		echo "file inside source loop ${file}"
		case ${file} in
		*.${sourceExtension[i]}) cp ../HelloWorldSagar/$file ./sourcecodefiles;echo "inside source case"; echo -e "$file\n " >> sourceCodeFile.txt; booleanvariable=false;break;		;;
		esac
	done
	
	
	if [ "$booleanvariable" == false ]; then
		echo "inside if break"
		continue;
	fi
	for (( i=0; i < ${#binaryExtension[@]}; i++ ))
	do
		echo "file inside binary loop ${file}"
		case ${file} in
		*.${binaryExtension[i]}) cp ../HelloWorldSagar/$file ./binaryfiles;echo "inside binaryCode case"; echo -e "$file\n " >> binaryCodeFile.txt; booleanvariable=false;break;		;;
		esac
	done
	if [ "$file" == "memory" ]; then
		echo "inside memory "
		echo ${booleanvariable}
	fi
	if [ "$booleanvariable" == false ]; then
		echo "inside if break"
		continue;
	else  
		cp ../HelloWorldSagar/$file ./otherfiles;
		echo "otherFile"
		echo -e "$file\n " >> otherFile.txt
	fi
done
		
	
  
		

#for filename in ${allFiles[@]}
#do	
#	echo "file name"
#	echo $filename
#	case $filename in 
#		*.${sourceExtension[0]}|*.${sourceExtension[1]}|*.${sourceExtension[2]}) cp ../HelloWorldSagar/$filename ./sourcecodefiles; echo -e "$filename\n " >> sourceCodeFile.txt;		;;
#		*.${binaryExtension[0]}|*.${binaryExtension[1]}|*.${binaryExtension[2]}) cp ../HelloWorldSagar/$filename ./binaryfiles;echo -e "$filename\n " >> binaryCodeFile.txt;		;;
#		*) cp ../HelloWorldSagar/$filename ./otherfiles;echo "$filename$'\n'" >> otherFile.txt;		;;
#	esac
#done
