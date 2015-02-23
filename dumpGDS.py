#!/usr/bin/python
import os
import numpy
import gdspy

cellName    = 'AND2_X2'
gdsii       = gdspy.GdsImport ( './gds/' + cellName + '.gds' )
cellinfo    = gdsii.extract ( cellName )

#display the view. Btw, 9 10 11 layers are for the metals, vias and gates
#gdspy.LayoutViewer()

polyinfo    = cellinfo.get_polygons() 

writeFile   = open ( cellName + '.txt' , 'w' )
print >> writeFile , polyinfo 
writeFile.close()

