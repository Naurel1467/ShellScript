sourceCode=(java txt properties)
binaryCode=(jar war zip)
allFiles=(sagar.java hello.war world.zip memory sql.properties)

echo ${#binaryCode[@]}
for file in ${allFiles[@]}
do
	booleanvariable=true
	
	for (( i=0; i < ${#sourceCode[@]}; i++ ))
	do
		echo "file inside source loop ${file}"
		case ${file} in
		*.${sourceCode[i]}) echo "inside source case"; echo -e "$file\n " >> sourceCodeFile.txt; booleanvariable=false;break;		;;
		esac
	done
	
	
	if [ "$booleanvariable" == false ]; then
		echo "inside if break"
		continue;
	fi
	for (( i=0; i < ${#binaryCode[@]}; i++ ))
	do
		echo "file inside binary loop ${file}"
		case ${file} in
		*.${binaryCode[i]}) echo "inside binaryCode case"; echo -e "$file\n " >> binaryCodeFile.txt; booleanvariable=false;break;		;;
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
		echo "otherFile"
		echo -e "$file\n " >> otherFile.txt
	fi
done
		
	
  
		