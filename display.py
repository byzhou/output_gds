#!/ad/eng/research/eng_research_icsg/mixed/bobzhou/software/tools/bin/python
import os
#regular expression
import re
#python gds related
import numpy
import gdspy

#import info of a cell
cellName    = 'TBUF_X16'
gdsii       = gdspy.GdsImport ( './gds/' + cellName + '.gds' )
cellinfo    = gdsii.extract ( cellName )

#display the cell 
gdspy.LayoutViewer() 
