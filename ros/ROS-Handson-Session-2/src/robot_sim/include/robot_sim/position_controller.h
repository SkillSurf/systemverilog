#pragma once

#include <boost/shared_ptr.hpp>

#include <ros/ros.h>
//#include <baxter_core_msgs/JointCommand.h>
#include <sensor_msgs/JointState.h>

#include "robot_sim/robot.h"

namespace robot_sim {

class PositionController
{
 public:
 PositionController(boost::shared_ptr<Robot> robot) : 
  root_nh_(""), robot_(robot)
  {}

  bool init();

 private:
  ros::NodeHandle root_nh_;
  boost::shared_ptr<Robot> robot_;

  //  ros::Subscriber baxter_command_sub_; 
  //  void baxter_callback(const baxter_core_msgs::JointCommand::ConstPtr&);

  ros::Subscriber generic_command_sub_;
  void generic_callback(const sensor_msgs::JointState::ConstPtr&);
};

class PositionCommand
{
 public:
 PositionCommand(boost::shared_ptr<Robot> robot) : 
  root_nh_(""), robot_(robot)
  {}

  bool init();

 private:
  ros::NodeHandle root_nh_;
  boost::shared_ptr<Robot> robot_;

  ros::Subscriber generic_command_sub_;
  void generic_callback(const sensor_msgs::JointState::ConstPtr&);
};

} //namespace robot_sim
