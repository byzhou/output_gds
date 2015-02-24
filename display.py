#!/usr/bin/python

import os
#regular expression
import re
#python gds related
import numpy
import gdspy

#import info of a cell
cellName    = 'AND2_X1'
gdsii       = gdspy.GdsImport ( './gds/' + cellName + '.gds' )
cellinfo    = gdsii.extract ( cellName )

#display the cell 
gdspy.LayoutViewer() 
