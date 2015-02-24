# gds file dumper code
## Importing gds file

The entire code is driven by the python code from gdspy.  Detailed info is in
`http://gdspy.sourceforge.net`. The code is based on reading Nangate45nm Free
pdk in python.

## Reformatting
The gdspy package is not designed for all gds file libs. Thus, in order to
understand the cell info inside of the gds files of 45 pdk, formatting is
needed.  The output files are the metal layers described in standard cells. All
the infos are described in polygon desciption.

## Protected by MIT license
