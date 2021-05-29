#include <boost/shared_ptr.hpp>

#include <map>

#include <ros/ros.h>
#include <urdf/model.h>

#include "robot_sim/joint_state_publisher.h"
#include "robot_sim/position_controller.h"
#include "robot_sim/robot.h"
#include "robot_sim/velocity_controller.h"

void setTargetValues(boost::shared_ptr<robot_sim::Robot> robot,
                     int num_joints) {
  static bool zeros = false;
  std::vector<double> vals;
  if (zeros)
    vals.resize(num_joints, 0.0);
  else
    vals.resize(num_joints, 1.0);
  robot->setTargetValues(vals);
  zeros = !zeros;
}

void setVelocities(boost::shared_ptr<robot_sim::Robot> robot, int num_joints) {
  static int count = 0;
  std::vector<double> vals;
  if (count == 0)
    vals.resize(num_joints, 1.0);
  else if (count == 1)
    vals.resize(num_joints, 0.0);
  else if (count == 2)
    vals.resize(num_joints, -1.0);
  else if (count == 3)
    vals.resize(num_joints, 0.0);
  robot->setVelocities(vals);
  if (++count > 3)
    count = 0;
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "robot_sim");

  ros::NodeHandle priv_nh("~");

  urdf::Model model;
  std::map<std::string, size_t> name_map;
  size_t i = 0;
  if (!model.initParam("robot_description")) {
    ROS_ERROR("Robot sim bringup: failed to read urdf from parameter server");
    return 0;
  }
  for (std::map<std::string, boost::shared_ptr<urdf::Joint> >::iterator it =
           model.joints_.begin();
       it != model.joints_.end(); it++) {
    if (it->second->type != urdf::Joint::FIXED) {
      name_map[it->first] = i;
      i++;
    }
  }
  ROS_INFO_STREAM("Robot model read with " << name_map.size()
                                           << " non-fixed joints.");
  size_t num_joints = name_map.size();

  boost::shared_ptr<robot_sim::Robot> robot(new robot_sim::Robot(name_map));
  robot->init();
  boost::shared_ptr<robot_sim::JointStatePublisher> publisher(
      new robot_sim::JointStatePublisher(robot));
  double rate;
  priv_nh.param<double>("joint_pub_rate", rate, 0.1);
  if (!publisher->init(rate)) {
    ROS_ERROR("Failed to initialize publisher");
    return 0;
  }
  boost::shared_ptr<robot_sim::VelocityController> vel_controller(
      new robot_sim::VelocityController(robot));
  if (!vel_controller->init()) {
    ROS_ERROR("Failed to initialize velocity controller");
    return 0;
  }
  boost::shared_ptr<robot_sim::PositionController> pos_controller(
      new robot_sim::PositionController(robot));
  if (!pos_controller->init()) {
    ROS_ERROR("Failed to initialize position controller");
    return 0;
  }
  boost::shared_ptr<robot_sim::PositionCommand> pos_command(
      new robot_sim::PositionCommand(robot));
  if (!pos_command->init()) {
    ROS_ERROR("Failed to initialize position command");
    return 0;
  }

  ros::NodeHandle root_nh("");
  // ros::Timer timer = root_nh.createTimer(ros::Duration(1.0),
  // boost::bind(setVelocities, robot, num_joints));

  ROS_INFO("Simulated robot spinning");
  ros::spin();
}
