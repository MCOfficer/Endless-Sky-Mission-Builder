""" AggregatedNPCFrame.py
# Copyright (c) 2020 by Andrew Sneed
#
# Endless Sky Mission Builder is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
#
# Endless Sky Mission Builder is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU General Public License for more details.
"""

import logging
from functools import partial
from tkinter import *
from tkinter import ttk

import src.widgets as widgets
from src import config


class AggregatedNPCFrame(ttk.Frame):
    """
    This class extends ttk.Frame, allowing the user to add an arbitrary number of NPCFrame widgets to the GUI.
    """

    def __init__(self, parent):
        ttk.Frame.__init__(self, parent)

        self.parent = parent
        self.npc_frame_list = []

        self.outer = ttk.Frame(self)
        self.outer.pack(expand=True, fill="x")

        section_name_label = ttk.Label(self.outer, text="NPCs", anchor="center")
        section_name_label.pack()

        self.inner = ttk.Frame(self.outer)
        self.inner.pack(expand=True, fill="x")

        add_button = ttk.Button(self.outer, text="Add NPC", command=self._add_npc)
        add_button.pack(expand=True, fill="x")
    #end init


    def _add_npc(self):
        """Add an NPC to the activeMission"""
        logging.debug("Adding NPC...")

        tf = widgets.npc.NPCFrame(self, "npc")
        self.edit_npc(self.npc_frame_list[-1])

        state = BooleanVar()
        cb = ttk.Checkbutton(tf.frame, onvalue=1, offvalue=0, variable=state)
        cb.configure(command=partial(self._change_state, state, self.npc_frame_list[-1].npc))
        cb.grid(row=0, column=3, sticky="e")
    #end _add_trigger


    def delete_npc(self, npc_frame):
        """
        This method uses the data stored in the npc_frame to remove the associated NPC object from the
            activeMission. Once that is completed, it removes the npc_frame from the GUI.

        :param npc_frame: The NPCFrame to be removed
        """
        logging.debug(str.format("Removing %s from Triggers" % npc_frame.trigger))

        config.active_item.remove_trigger(npc_frame.trigger)

        self.npc_frame_list.remove(npc_frame)
        npc_frame.frame.pack_forget()
        npc_frame.frame.destroy()
    #end delete_npc


    def edit_npc(self, npc_frame):
        """
        This method uses the data stored in the npc_frame to edit_npc the data stored in the associated
        NPC object.

        :param npc_frame: The NPCFrame containing the npc to be edited
        """
        logging.debug("Editing %s..." % str(npc_frame.trigger))
        widgets.npc.NPCWindow(self, npc_frame.trigger)
    #end edit_npc


    def populate_npc(self, npc):
        """
        This method populates the GUI with a NPCFrame widget, then stores the data from NPC inside it

        :param npc: the NPC containing the data to be populated
        """
        tf = widgets.TriggerFrame(self, "npc", populating=True)
        tf.trigger = npc

        state = BooleanVar()
        cb = ttk.Checkbutton(tf.frame, onvalue=1, offvalue=0, variable=state)
        cb.configure(command=partial(self._change_state, state, npc))
        cb.grid(row=0, column=3, sticky="e")

        if npc.is_active:
            state.set(1)
            self._change_state(state, npc)
    #end populate_npc


    @staticmethod
    def _change_state(state, npc):
        """
        Set npc to state
        :param state: the state of the npc
        :param npc: the npc
        """
        npc.is_active = state.get()
        logging.debug("%s is now %s" % (str(npc), str(npc.is_active)))
    #def _change_state
#end class AggregatedNPCFrame
