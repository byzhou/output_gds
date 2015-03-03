#!/ad/eng/research/eng_research_icsg/mixed/bobzhou/software/tools/bin/python

import os
#regular expression
import re
#python gds related
import numpy
import gdspy

#choos the folder
#choose the standard cell
fileName	= "AND2_X1.txt"
cellName	= fileName[:-4]
gdsii	   = gdspy.GdsImport ( './gds/' + cellName + '.gds' )
cellinfo	= gdsii.extract ( cellName )

#write to the file of the polygon info
writeFile   = open ( cellName + '.txt' , 'w' )
print ( "open the file %s.txt\n" % cellName )

#display the view. Btw, 10 11 layers are for the metals and vias
#gdspy.LayoutViewer()

#get polygon info from the cell
polyinfo	= cellinfo.get_polygons() 

#print cell attributes values
cellInst	= vars ( cellinfo )
#search for word begin with 0x
regux	   = re.compile ( "0x\w+" )
#transform data type
strInst	 = str ( cellInst )
#search for regux, the first matched value is stored in firstInst
firstInst   = ( regux . search ( strInst ) ) . group ()
#All the info of the polygon including the layer info
instWithLayer = cellinfo.get_polygons ( firstInst )
#transform into string
strWithLayer = str ( instWithLayer )
#print all the cell info
print ( "Here are all the cell info %s \n" % instWithLayer ) 

#print cellName
if cellName != "FILLCELL_X1" and  cellName != "FILLCELL_X2" and  cellName != "FILLCELL_X4"  and  cellName != "FILLCELL_X8"  and  cellName != "FILLCELL_X16"  and  cellName != "FILLCELL_X32" :
	writeFile . write ( "10th layer" )
	#Search for the 10th layer's polygon info
	startToken  = re.compile ( "\(10\, 0\)\: \[array\(\[\[" )
	#find out the start position of the layer 10
	startpos	= ( startToken . search ( strWithLayer ) ) . start ()
	#end token of layer 10
	endToken	= re.compile ( "\(\w+\, 0\)\: \[array\(\[\[" )
	#find out the end position of the layer 10
	endpos	  = ( endToken . search ( strWithLayer , startpos + 1 ) ) . start ()
	#find out the number tokens on the layer 10
	numToken	= re.compile ( "\w\.\s" "|[-|\s]\w+\.\w+" "|array" )
	#write all the coordinates
	coords	  = ( numToken . findall ( strWithLayer , startpos , endpos ) ) 
	#print type ( coords )
	for x in coords :
		if  x == "array" :
			writeFile . write ( "\n" ) 
		else :
			writeFile . write ( str ( x ) + " " ) 

writeFile . write ( "\n\n11th layer" )
#Search for the 11th layer's polygon info
startToken  = re.compile ( "\(11\, 0\)\: \[array\(\[\[" )
#find out the start position of the layer 11
startpos	= ( startToken . search ( strWithLayer ) ) . start ()
#end token of layer 11
endToken	= re.compile ( "\(\w+\, 0\)\: \[array\(\[\[" )
#find out the end position of the layer 11
endpos	  = ( endToken . search ( strWithLayer , startpos + 1 ) ) . start ()
#find out the number tokens on the layer 11
numToken	= re.compile ( "\w\.\s" "|[-|\s]\w+\.\w+" "|array" )
#write all the coordinates
coords	  = ( numToken . findall ( strWithLayer , startpos , endpos ) ) 
#print type ( coords )
for x in coords :
	if  x == "array" :
		writeFile . write ( "\n" ) 
	else :
		writeFile . write ( str ( x ) + " " ) 

writeFile.close()
print ( "close the file %s.txt\n" % cellName )
