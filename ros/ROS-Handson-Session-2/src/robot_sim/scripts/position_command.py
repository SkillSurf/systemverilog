#!/usr/bin/env python

import numpy

from Tkinter import Tk, Button, Entry, Label, END
from functools import partial

import rospy
from sensor_msgs.msg import JointState
from urdf_parser_py.urdf import URDF

class GUI:
    def __init__(self,master):
        self.master = master
        master.title("Joint positions")

class PositionCommander(object):

    def __init__(self, master, num_joints):
        self.pub_pos = rospy.Publisher("/joint_positions", JointState, queue_size=1)
        self.num_joints = num_joints
        rospy.Subscriber("joint_states", JointState, self.callback)

        self.init_dialog(master)

    def init_dialog(self, master):
        self.master = master
        master.title("Joint positions")
        self.entries = []
        for i in range(0,self.num_joints):
            new_label = Label(master, text="Joint " + str(i))
            new_label.grid(row=i, column=0)

            callback_with_arg = partial(self.inc, -1, i)
            minus_button = Button(master, text="-", command=callback_with_arg)
            minus_button.grid(row=i, column=1)

            new_entry = Entry(master)
            new_entry.insert(0,"0.0")
            new_entry.config(width=5)
            new_entry.grid(row=i, column=2)
            self.entries.append(new_entry)

            callback_with_arg = partial(self.inc, 1, i)
            minus_button = Button(master, text="+", command=callback_with_arg)
            minus_button.grid(row=i, column=3)

        self.publish_button = Button(master, text="Send", command=self.send)
        self.publish_button.grid(row=self.num_joints, column=0)

    def inc(self, dir, joint):
        val = float(self.entries[joint].get())
        val += dir * 0.1
        self.entries[joint].delete(0, END)
        self.entries[joint].insert(0, str(val))
        self.send()

    def send(self):
        msg = JointState()
        for i in range(0, self.num_joints):
            msg.position.append(float(self.entries[i].get()))
        self.pub_pos.publish(msg)

    def callback(self, joint_values):
        pass

if __name__ == '__main__':
    rospy.init_node('position_command', anonymous=True)
    root = Tk()
    pc = PositionCommander(root,7)
    root.mainloop()
