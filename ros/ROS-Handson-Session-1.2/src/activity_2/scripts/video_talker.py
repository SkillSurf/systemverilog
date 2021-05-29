#!/usr/bin/env python

# OpenCV Tutorial : https://docs.opencv.org/master/d6/d00/tutorial_py_root.html 

import random
import sys,os
import rospy
import numpy as np
from sensor_msgs.msg import CompressedImage
import cv2 as cv
from time import sleep


def talker():

    # START CODE HERE

    pub = None # Publisher to topic /camera/feed

    rospy.init_node('talker_node',anonymous=True)
    
    cap = None # Read the video in videos folder

    fps = None # Get the FPS Value - Hint : use cv.cap.get()
    
    rate = rospy.Rate(None) # Fill the None
    
    while not rospy.is_shutdown() and cap.isOpened():
        
        msg = None # Create a msg
        
        ret, frame = None # Read the cap
        
        if ret==False:
            break  
        msg.header.stamp = rospy.Time.now()
        msg.format = "jpeg"
        msg.data = np.array(cv.imencode('.jpg', frame)[1]).tostring()
        pub.publish(msg)
        rate.sleep()
    
    cap.release()
    
    # END CODE HERE

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass