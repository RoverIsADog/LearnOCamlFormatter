#!/bin/bash
#Author github.com/RoverIsADog

origin=$1
preludeMarker="(* Prelude Boundary *)" #Marks prelude start/end
binFileName="pastebin.ml" #Output file
echo -n "" > $binFileName
ignoring=0

if [ ! -f "$origin" ]; then
	echo "File \"$origin\" does not exist..."
	exit 1
fi

while IFS="" read -r line || [ -n "$line" ]
do
	# Ignore until end of prelude marker
	if [[ $line =~ "$preludeMarker" ]]; then
		ignoring+=1
		continue
	fi
	if [ $ignoring -eq 1 ]; then
		continue
	fi

	# Ignore instances of printf
	if [[ $line =~ "printf" ]]; then
		continue
	fi
	
	# Add other illegal libraries below
	#if [[ $line =~ "List" ]]; then
	#	continue
	#fi

	printf "\n%s" "$line" >> $binFileName

done < $origin
