#!/usr/bin/env python  
import rospy

from std_msgs.msg import Int16

# START CODE HERE #
# Import the created msg file

# END CODE HERE #

def callback(data):
	# START CODE HERE #
    total = None
    rospy.loginfo(None + " + " + None + " = " + str(total.data)+"\n")
	pub.publish(total)
    # END CODE HERE #


def talker_listener():
	
    # START CODE HERE #
    # Create a ros node named 'two_ints_listner_node'

    # END CODE HERE #
	

	global pub

    # START CODE HERE #
    # 1. Define the publisher 'pub' to publish '/sum' topic
    # 2. Call the rospy.Subscriber() with topic, dtype and callback
    pub = None
    
    # END CODE HERE #
	
	rospy.spin()


if __name__ == '__main__':
	try:
		talker_listener()
	except rospy.ROSInterruptException:
		raise e
