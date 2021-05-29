#!/usr/bin/env python

# OpenCV Tutorial : https://docs.opencv.org/master/d6/d00/tutorial_py_root.html 

import random
import rospy
import numpy as np
import cv2 as cv
from sensor_msgs.msg import CompressedImage

def callback(dataf):
    # START CODE HERE

    data = None

    np_arr = None # Convert string to uint8 using np.fromstring()
    
    image = cv.imdecode(None, cv.IMREAD_COLOR) # Fill the None
    
    cv.imshow('listener',None) # Display the image
    
    cv.waitKey(1)

    # END CODE HERE

def listner():
    rospy.loginfo("I'm listening ...")
    rospy.init_node('listener',anonymous=True)

    # START CODE HERE

    # Create a subscriber to topic '/camera/feed'
    rospy.Subscriber(None,None,None)

    # END CODE HERE

    rospy.spin()

if __name__ == '__main__':
    try:
        listner()
    except rospy.ROSInterruptException:
        pass


