n=$(wc -l aprog.cpp)
n=$(echo $n | cut -d " " -f 1)
i=1
flag=0
j=1
echo "" > temp.cpp

while [ "$i" -le "$n" ]
do
	cur=$(cat aprog.cpp | head -$i | tail -1)
	s=$(echo $cur | grep "main")
	x=$(echo $cur | grep "return")

	if [ "$x" == "return 0;" ]
	then
		#echo $x
		if [ "$flag" -eq "$j" ]
		then
			echo "kipawa_end = clock();" >> temp.cpp
			echo "kipawa_tim = (1.0*(kipawa_end-kipawa_beg))/CLOCKS_PER_SEC;" >> temp.cpp
			echo "ofstream ofile;" >> temp.cpp
			echo "ofile.open(\"tim.txt\");" >> temp.cpp
			echo "ofile << kipawa_tim;" >> temp.cpp
			echo -E $cur >> temp.cpp
		fi
	fi
	

	if [ "$s" = "" ]
	then
		echo -E $cur >> temp.cpp
	else
		i=`expr $i + 1`
		echo -E $cur >> temp.cpp
		cur=$(cat aprog.cpp | head -$i | tail -1)
		echo -E $cur >> temp.cpp
		echo -E "clock_t kipawa_beg,kipawa_end;" >> temp.cpp
		echo -E "double kipawa_tim;" >> temp.cpp
		echo -E "kipawa_beg = clock();" >> temp.cpp
		flag=1
	fi

	i=`expr $i + 1`
done

#echo "Done"
g++ temp.cpp -o aprog
