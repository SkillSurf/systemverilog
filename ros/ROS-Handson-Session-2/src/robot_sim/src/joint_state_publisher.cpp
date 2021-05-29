#include "robot_sim/joint_state_publisher.h"

#include <sensor_msgs/JointState.h>

namespace robot_sim {

bool JointStatePublisher::init(double rate)
{
  if (!robot_) return false;

  state_publisher_ = root_nh_.advertise<sensor_msgs::JointState>("joint_states", 10);
  state_timer_ = root_nh_.createTimer(ros::Duration(rate), &JointStatePublisher::callback, this);

  return true;
}

void JointStatePublisher::callback(const ros::TimerEvent&)
{
  assert(robot_);
  sensor_msgs::JointState msg;
  msg.position = robot_->getJointValues();
  msg.name = robot_->getJointNames();
  msg.velocity.resize( msg.position.size(), 0.0);
  msg.effort.resize( msg.position.size(), 0.0);
  if (msg.position.size() != msg.name.size())
  {
    ROS_ERROR("Mismatch between sim robot and joint state publisher");
    return;
  }
  msg.header.stamp = ros::Time::now();
  state_publisher_.publish(msg);
}

}
