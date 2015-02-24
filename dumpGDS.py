#!/usr/bin/python

import os
#regular expression
import re
#python gds related
import numpy
import gdspy

#choos the folder
path        = './gds/'
for filename in os.listdir ( path ) :
    print filename,
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
#transform data type
strInst     = str ( cellInst )
#search for regux, the first matched value is stored in firstInst
firstInst   = ( regux . search ( strInst ) ) . group ()
#All the info of the polygon including the layer info
instWithLayer = cellinfo.get_polygons ( firstInst )
#transform into string
strWithLayer = str ( instWithLayer )

print "10th layer"
#Search for the 10th layer's polygon info
startToken  = re.compile ( "\(10\, 0\)\: \[array\(\[\[" )
#find out the start position of the layer 10
startpos    = ( startToken . search ( strWithLayer ) ) . start ()
#end token of layer 10
endToken    = re.compile ( "\(\w+\, 0\)\: \[array\(\[\[" )
#find out the end position of the layer 10
endpos      = ( endToken . search ( strWithLayer , startpos + 1 ) ) . start ()
#find out the number tokens on the layer 10
numToken    = re.compile ( "\w+\.\w+" "|array" )
#write all the coordinates
coords      = ( numToken . findall ( strWithLayer , startpos , endpos ) ) 
#print type ( coords )
for x in coords :
    if  x == "array" :
        print "\n",
    else :
        print x,

print "\n\n11th layer"
#Search for the 11th layer's polygon info
startToken  = re.compile ( "\(11\, 0\)\: \[array\(\[\[" )
#find out the start position of the layer 11
startpos    = ( startToken . search ( strWithLayer ) ) . start ()
#end token of layer 11
endToken    = re.compile ( "\(\w+\, 0\)\: \[array\(\[\[" )
#find out the end position of the layer 11
endpos      = ( endToken . search ( strWithLayer , startpos + 1 ) ) . start ()
#find out the number tokens on the layer 11
numToken    = re.compile ( "\w+\.\w+" "|array" )
#write all the coordinates
coords      = ( numToken . findall ( strWithLayer , startpos , endpos ) ) 
#print type ( coords )
for x in coords :
    if  x == "array" :
        print "\n",
    else :
        print x,


