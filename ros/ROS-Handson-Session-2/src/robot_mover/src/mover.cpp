#include <ros/ros.h>
#include <std_msgs/Int8.h>
#include <sensor_msgs/JointState.h>

std::vector<double> getVelocities(int num_joints)
{
  static int count = 0;
  std::vector<double> vals;
  if (count == 0) vals.resize(num_joints, 1.0);
  else if (count == 1) vals.resize(num_joints, 0.0);
  else if (count == 2) vals.resize(num_joints, -1.0);
  else if (count == 3) vals.resize(num_joints, 0.0);
  if (++count > 3) count = 0; 
  return vals;
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "mover");
  ros::NodeHandle nh("");

  int num_joints = 7;
  ros::Publisher pub = nh.advertise<sensor_msgs::JointState>("joint_velocities", 10);
  ros::Publisher pinger = nh.advertise<std_msgs::Int8>("ping", 0);

  while (ros::ok()) {
    sensor_msgs::JointState msg;
    std_msgs::Int8 ping;
    msg.velocity = getVelocities(num_joints);
    ping.data = 1;
    pub.publish(msg);
    pinger.publish(ping);
    ros::Duration(1.0).sleep();
  }

}
