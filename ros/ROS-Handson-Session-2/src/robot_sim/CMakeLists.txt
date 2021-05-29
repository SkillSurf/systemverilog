cmake_minimum_required(VERSION 2.8.3)
project(robot_sim)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  urdf
)

find_package(Boost REQUIRED)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES robot_sim
  CATKIN_DEPENDS 
    roscpp 
    sensor_msgs
    urdf
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_library(robot_sim
  src/joint_state_publisher.cpp
  src/robot.cpp
  src/velocity_controller.cpp
  src/position_controller.cpp
)

add_executable(robot_sim_bringup src/robot_sim_bringup.cpp)
target_link_libraries(robot_sim_bringup ${catkin_LIBRARIES} robot_sim)
