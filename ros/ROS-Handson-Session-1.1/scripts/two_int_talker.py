#!/usr/bin/env python  
import random

import rospy
from std_msgs.msg import Int16
# START CODE HERE #
# Import the created msg file

# END CODE HERE #

def talker():
    # START CODE HERE #
    # Create a publisher for the topic '/two_ints'
    pub = None
    # END CODE HERE #
    rospy.init_node('two_int_talker_node', anonymous=True)

    # START CODE HERE #
    # Define r to publish a message once in every 2 seconds  
    r = None
    # END CODE HERE #

    rate = rospy.Rate(r)  
    random.seed()

    while not rospy.is_shutdown():

        # START CODE HERE #
        # Create a msg with the correct dtype
        msg = None
        # END CODE HERE #
  
        msg.a = None # Generate a random number between 1 and 20
        msg.b = None # Generate a random number between 1 and 20
        rospy.loginfo("{} and {} are published".format( msg.a,msg.b))
        pub.publish(msg)
        rate.sleep()
    

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass



        