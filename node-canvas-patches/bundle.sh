copies=$(/data/pax-utils/lddtree.sh -l build/Release/canvas.node | sed -r -e '/canvas.node$/d');

for so in $copies; do
  cp $so build/Release
done;
