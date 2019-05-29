''' AggregatedComponentFrame.py
# Copyright (c) 2019 by Andrew Sneed
#
# Endless Sky Mission Builder is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
#
# Endless Sky Mission Builder is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU General Public License for more details.

This frame encapsulates a group of components of a single type. This is done so that an
    arbitrary number of the same components can be added without affecting the row numbers
    of the rest of the widgets on the centerFrame

'''

from tkinter import *
from tkinter import ttk

class AggregatedComponentFrame(ttk.Frame):

    def __init__(self, parent, sectionName, componentType):
        print("\n\t\t\tAdding %s" % sectionName)
        ttk.Frame.__init__(self, parent)

        self.sectionName   = sectionName
        self.componentType = componentType
        self.componentList = []

        self.outer = ttk.Frame(self)
        self.outer.pack()

        sectionNameLabel = ttk.Label(self.outer, text=self.sectionName, anchor="center")
        sectionNameLabel.pack()

        self.inner = ttk.Frame(self.outer)
        self.inner.pack()

        buttonText = "Add " + self.componentType
        addButton = ttk.Button(self.outer, text=buttonText, width=31, command=self.__addComponent)
        addButton.pack(expand=True, fill="x")\

        print("\t\t\tDone.")
    #end init


    def __addComponent(self):
        print("\t\t\t\tAdding %s to %s" % (self.componentType, self.sectionName))

        newComponent = ttk.Frame(self.inner)
        newComponent.pack()

        labelText = "%s %d" % (self.componentType, len(self.componentList))
        label = ttk.Label(newComponent, text=labelText, anchor="w")
        label.grid(row=0, column=0, sticky="ew")

        editButton = ttk.Button(newComponent, text="edit")
        editButton.grid(row=0, column=1)

        deleteButton = ttk.Button(newComponent, text="X")
        deleteButton.grid(row=0, column=2)

        self.componentList.append(newComponent)

        print("\t\t\t\tDone.")
    #end __addComponent

#end class AggregatedComponentFrame