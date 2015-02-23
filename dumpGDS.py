#!/usr/bin/python

import os

#regular expression
import re
#python gds related
import numpy
import gdspy

#choose the standard cell
cellName    = 'AND2_X2'
gdsii       = gdspy.GdsImport ( './gds/' + cellName + '.gds' )
cellinfo    = gdsii.extract ( cellName )

#display the view. Btw, 9 10 11 layers are for the metals, vias and gates
#gdspy.LayoutViewer()

#get polygon info from the cell
polyinfo    = cellinfo.get_polygons() 

#write to the file of the polygon info
writeFile   = open ( cellName + '.txt' , 'w' )
print >> writeFile , polyinfo 
writeFile.close()

#print cell attributes values
cellInst    = vars ( cellinfo )
#search for word begin with 0x
regux       = re.compile ( "0x\w+" )
#tranform data type
strInst     = str ( cellInst )
#search for regux
firstInst   = regux.match ( strInst ) . span ()
#print cellInst
print firstInst

#print polygon info
#print  polyinfo
