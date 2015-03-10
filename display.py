#!/ad/eng/research/eng_research_icsg/mixed/bobzhou/software/tools/bin/python
import os
#regular expression
import re
#python gds related
import numpy
import gdspy

path		= './gds/'

#import the library
gdsii = gdspy.GdsImport('gds/NangateOpenCellLibrary.gds')
for cell_name in gdsii.cell_dict:
#extract the info in each standard library
    gdsii.extract(cell_name)
#    print ( cell_name )

#import the design
design		= gdspy.GdsImport ( 'TjIn.gds' )
#extract the design
gdsii		= design.extract ( 'top' )

#just draw some stuff
gdsii . add ( gdspy . Rectangle ( (18, 1), (22, 2), 11) )
#display the design with showing the one layer of reference
gdspy.LayoutViewer( cells={ 'top' } , depth=1)
#export stuff
gdspy.gds_print( 'test.gds', cells={'top'},unit=1e-06,precision=1e-09) 
