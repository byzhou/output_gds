#!/usr/bin/python
import os.path
from gdsCAD import *

# Create some things to draw:
amarks = templates.AlignmentMarks(('A', 'C'), (1,2))
text = shapes.Label('Hello\nworld!', 200, (0, 0))
box = shapes.Box((-500, -400), (1500, 400), 10, layer=2)

# Create a Cell to hold the objects
cell = core.Cell('EXAMPLE')
cell.add([text, box])
cell.add(amarks, origin=(-200, 0))
cell.add(amarks, origin=(1200, 0))

# Create two copies of the Cell
top = core.Cell('TOP')
cell_array = core.CellArray(cell, 1, 2, (0, 850))
top.add(cell_array)

# Add the copied cell to a Layout and save
layout = core.Layout('LIBRARY')
layout.add(top)
layout.save('output.gds')

#new = core.GdsImport ('output.gds', layers={2:4})
new = core.GdsImport ('output.gds')
new.show()
