#!/bin/bash

###sudo apt-get install wcalc
# set the eraser to be a right button click

 xsetwacom set "Wacom ISDv4 E6 Pen eraser" Button 1 3

# the script


function touch_ratio {
	#get pen geometry
	LINE=`xsetwacom get "Wacom ISDv4 E6 Pen stylus" area`
	echo ${LINE}
	TabTx=`echo ${LINE} | awk '{ print $1 }'`
	TabTy=`echo ${LINE} | awk '{ print $2 }'`
	TabBx=`echo ${LINE} | awk '{ print $3 }'`
	TabBy=`echo ${LINE} | awk '{ print $4 }'`

	TouchHeight=$((${TabBy} -${TabTy}))
	TouchWidth=$((${TabBx} -${TabTx}))

	TouchRatio=`wcalc -q ${TouchWidth}/${TouchHeight}`

}



# get screen geometry
LINE=`xrandr -q | grep Screen`
WIDTH=`echo ${LINE} | awk '{ print $8 }'`
HEIGHT=`echo ${LINE} | awk '{ print $10 }' | awk -F"," '{ print $1 }'`
RATIO=`wcalc -q ${WIDTH}/${HEIGHT}`



touch_ratio

# is the touch ratio different from the screen ratio?
change=`wcalc -q abs\(${TouchRatio}-${RATIO}\)\>0.01`
wcalc -q abs\(${TouchRatio}-${RATIO}\)
if [[ ${change} != 0 ]] 
  then

	#they differ

	# first try resetting
	xsetwacom set "Wacom ISDv4 E6 Pen stylus" ResetArea
	xsetwacom set "Wacom ISDv4 E6 Pen eraser" ResetArea 
	xsetwacom set "Wacom ISDv4 E6 Finger touch" ResetArea

	# how about now?
	touch_ratio
	
	if [[ `wcalc -q abs\(${TouchRatio}-${RATIO}\)\>0.01` != 0 ]] #they differ
	  then

		if [[ ${TouchRatio} > ${RATIO} ]] # width has shrunk
		  then
			# use existing height values
			TYOFFSET=${TabTy};
			BYOFFSET=${TabBy};

			# calculate new width values
			# width = ratio * height
			
			NewTabWidth=`wcalc -q -P0 ${RATIO}*${TouchHeight}`
			TabDiff=$(( (${TouchWidth} - ${NewTabWidth}) / 2));

			TXOFFSET=$((${TabTx} + ${TabDiff}));
			BXOFFSET=$((${TabBx}- ${TabDiff}));

		  else # height has shrunk

			# use existing width values
			TXOFFSET=${TabTx};
			BXOFFSET=${TabBx};

			# calculate new height values
			# height = width / ratio

			NewTabHeight=`wcalc -q -P0 ${TouchWidth}/${RATIO}`
			TabDiff=`wcalc -q \(${TouchHeight}-${NewTabHeight}\)/2`
			
			TYOFFSET=`wcalc -q ${TabTy}+${TabDiff}`
			BYOFFSET=`wcalc -q ${TabBy}-${TabDiff}`

		  fi


		echo ${TXOFFSET} ${TYOFFSET} ${BXOFFSET} ${BYOFFSET}
		xsetwacom set "Wacom ISDv4 E6 Pen stylus" Area ${TXOFFSET} ${TYOFFSET} ${BXOFFSET} ${BYOFFSET}
		xsetwacom set "Wacom ISDv4 E6 Pen eraser" Area ${TXOFFSET} ${TYOFFSET} ${BXOFFSET} ${BYOFFSET}
		xsetwacom set "Wacom ISDv4 E6 Finger touch" Area ${TXOFFSET} ${TYOFFSET} ${BXOFFSET} ${BYOFFSET}

	  fi
	#gnome-control-center wacom
  else
	echo normal resolution
fi


