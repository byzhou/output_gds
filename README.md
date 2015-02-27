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
`http://opensource.org/licenses/MIT`

##install python on a different dir
`./configure --prefix=$HOME/tools --with-threads --enable-shared`

##install packages on a different dir
`python setup.py install --home=$DIFFDIR`

##export path for python

	LD_LIBRARY_PATH=/ad/eng/research/eng_research_icsg/mixed/bobzhou/software/tools/lib64/
	export LD_LIBRARY_PATH
	PATH=/ad/eng/research/eng_research_icsg/mixed/bobzhou/software/tools/bin/python3.4:$PATH
	export PATH
