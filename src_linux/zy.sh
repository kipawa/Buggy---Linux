#Code for time elapsed---
x=$(date | cut -d " " -f 4)
y=$(head -1 kipawa_time.txt)
sf=$(echo $x | cut -d ":" -f 3)
si=$(echo $y | cut -d ":" -f 3)
mf=$(echo $x | cut -d ":" -f 2)
mi=$(echo $y | cut -d ":" -f 2)
hf=$(echo $x | cut -d ":" -f 1)
hi=$(echo $y | cut -d ":" -f 1)

if [ "$si" -gt "$sf" ]
then
	if [ "$mf" -gt 0 ]
	then
		mf=`expr $mf - 1`
	else
		hf=`expr $hf - 1`
		mf=59
	fi
sf=`expr $sf + 60`
fi
s=`expr $sf - $si`

if [ "$mi" -gt "$mf" ]
then
	hf=`expr $hf - 1`
	mf=`expr $mf + 60`
fi
m=`expr $mf - $mi`
h=`expr $hf - $hi`

gnome-terminal -x bash -c "./$1; echo -e '\nExecution Time :'; cat tim.txt; echo ' seconds'; echo -e '\nTime elapsed :'; echo $h:$m:$s; bash"