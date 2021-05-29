#include "robot_sim/position_controller.h"

namespace robot_sim {

bool PositionController::init()
{
  generic_command_sub_ = root_nh_.subscribe("joint_positions", 
					    10, &PositionController::generic_callback, this);
  return true;
}

void PositionController::generic_callback(const sensor_msgs::JointState::ConstPtr& msg)
{
  if (msg->position.size() != robot_->getNumJoints())
  {
    ROS_ERROR_STREAM("Received joint positions (" << msg->position.size() <<
		     ") do not match robot(" << robot_->getNumJoints() << 
		     ")");
    return;
  }
  robot_->setTargetValues(msg->position);
}

bool PositionCommand::init()
{
  generic_command_sub_ = root_nh_.subscribe("joint_command", 
					    10, &PositionCommand::generic_callback, this);
  return true;
}

void PositionCommand::generic_callback(const sensor_msgs::JointState::ConstPtr& msg)
{
  if (msg->position.size() != robot_->getNumJoints())
  {
    ROS_ERROR_STREAM("Received joint positions (" << msg->position.size() <<
		     ") do not match robot(" << robot_->getNumJoints() << 
		     ")");
    return;
  }
  robot_->setJointValues(msg->position);
}

}
