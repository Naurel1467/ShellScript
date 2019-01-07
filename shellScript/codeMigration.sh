#directory name declaration
filesDirName="/D/Practice/HelloWorldSagar" 

#chaning directory to parent folder
cd ..

#checking presence of directory output if exists it will delete
[ -d output ] && rm -r output

#creating output directory to store files
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
	allFiles[i]=${file}
	let "i++" 
done

#printing files name in a single line
echo "All files:- ${allFiles[@]}"

#changing directory into path where files are located
cd ../shellScript

#fetching source code extensions from sourcecode.txt
i=0;
while read name; do
  sourceExtension[i]=${name}
	let "i++"
done < sourcecode.txt

#printing source code extensions
echo "Source Code Extension : - ${sourceExtension[@]}"

#fetching binary code extensions from binaryfiles.txt 
i=0;
while read name; do
  binaryExtension[i]=${name}
  let "i++"
done < binaryfiles.txt

#printing binary code extensions
echo "Binary Code Extension: - ${binaryExtension[@]}"

#fetching files according to extension
cd ../output
echo ${allFiles[@]}
echo "" > sourceCodeFile.txt
echo "" > binaryCodeFile.txt
echo "" > otherFile.txt

for file in ${allFiles[@]}
do
  filePath=$(find "${filesDirName}" -name ${file})
	dir=${filePath} | awk -F "/$file" '{ print $1 }'| awk -F "${filesDirName}/" '{ print $2 }')
  booleanvariable=true
	for (( i=0; i < ${#sourceExtension[@]}; i++ ))
	do	
		case ${file} in
		  *.${sourceExtension[i]}) mkdir -p "sourcecodefiles/${dir}"
      cp ${filePath} "sourcecodefiles/${dir}"
      echo -e "$file\n " >> sourceCodeFile.txt
      booleanvariable=false;break
      ;;
		esac
	done

	if [ "$booleanvariable" == false ]; then
		continue;
	fi

	for (( i=0; i < ${#binaryExtension[@]}; i++ ))
	do
		case ${file} in
		*.${binaryExtension[i]}) mkdir -p "binaryfiles/${dir}"
    cp ${filePath} "binaryfiles/$(echo ${dir}" 
    echo -e "$file\n " >> binaryCodeFile.txt
    booleanvariable=false;break
    ;;
		esac
	done

	if [ "$booleanvariable" == false ]; then
		continue;
	else  
		mkdir -p "otherfiles/${dir}"
		cp ${filePath} "otherfiles/${dir}"
		echo -e "$file\n " >> otherFile.txt
	fi
done

echo "All files migration completed"	
