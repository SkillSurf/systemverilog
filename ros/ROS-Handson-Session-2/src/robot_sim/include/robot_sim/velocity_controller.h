#pragma once

#include <boost/shared_ptr.hpp>

#include <ros/ros.h>
#include <sensor_msgs/JointState.h>

#include "robot_sim/robot.h"

namespace robot_sim {

class VelocityController
{
 public:
 VelocityController(boost::shared_ptr<Robot> robot) : 
  root_nh_(""), robot_(robot)
  {}

  bool init();

 private:
  ros::NodeHandle root_nh_;
  boost::shared_ptr<Robot> robot_;
  ros::Subscriber velocity_sub_;
  
  void callback(const sensor_msgs::JointState::ConstPtr&);
};

} //namespace robot_sim
