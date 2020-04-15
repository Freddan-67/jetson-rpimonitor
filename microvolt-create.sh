#!/bin/bash
find /sys/devices  -name microvolts -print  > /tmp/microvolt.data
#for nvidia, has bug
#find /sys/bus/platform      -name microvolts -print  > microvolt2.data
#cd /sys/bus/platform/devices/regulators && find . -name microvolts -print > /tmp/microvolt2.data
#sed /tmp/microvolt2.data -e 's/\.\/regulators/\/sys\/bus\/platform\/devices\/regulators/' >> /tmp/microvolt.data
echo "#!/bin/bash"
echo "#autocreated by microvolt-create.sh"
input="microvolt.data"
while read line
do
    echo "if [ -f $line ] ; then"
    comment=`echo $line | sed -e 's/\/sys\/devices\/platform\///' -e 's/\/regulator\/regulator//' -e 's/\/microvolts//' -e 's/ff[a-f0-9]*\.//' -e 's/\/i2c-0\///'`
    echo "  echo $comment";
    echo "  cat $line"
val=$(cat $line)
    echo "  #value $val"
    echo "fi"
    echo ""
done < "/tmp/microvolt.data"

