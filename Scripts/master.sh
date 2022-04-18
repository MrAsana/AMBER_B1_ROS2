#!/bin/bash
#sudo -sE
# Attention: Run sudo -sE before run this scripts.
if [[ "$(id -u)" != "0" ]]; then
      echo "Error: Please RUN 'sudo -sE' first!"
      exit 1
fi
PIDS=`ps -ef |grep "ros" | grep -v grep | cut -c 9-16`
    if [ "$PIDS" != "" ]; then                     
        echo "The Master is restarting..." 
        ps -ef |grep "ros" | grep -v grep | cut -c 9-16 |xargs kill -s 9
        sleep 2
        nohup ros2 launch amber_b1_bringup amber_b1_hw_gui_ethercat.launch.py >/home/amber/ros2_ws/ros.out 2>&1 &
        echo "Master service is starting, wait a second please..."
        sleep 10
            #check ros2 status     
            ROS2=`grep -E "Error|ERROR|WARNING" /home/amber/ros2_ws/ros.out | grep -v grep | awk '{print $2}'`
            sleep 3
                if [ "ROS2" != "" ]; then # ROS2 abnormal
                  echo "Master service abnormal, please check all the cables connected and powerd on with zero position."
                  echo "Or unplug X-hub Power cable, plug it again after around 10 seconds."
                else
                  sleep 1 
                  echo "The Master is serving...."
                fi  

    else
        nohup ros2 launch amber_b1_bringup amber_b1_hw_gui_ethercat.launch.py >/home/amber/ros2_ws/ros.out 2>&1 &
        echo "Master service is starting, wait a second please..."
        sleep 10
            #check ros2 status     
            ROS2=`grep -E "Error|ERROR|WARNING" /home/amber/ros2_ws/ros.out | grep -v grep | awk '{print $2}'`
            sleep 3
                if [ "ROS2" != "" ]; then # ROS2 abnormal
                  echo "Master service abnormal, please check all the cables connected and powerd on with zero position."
                  echo "Or unplug X-hub Power cable, plug it again after around 10 seconds."
                else
                  sleep 1     
                  echo "The Master is ready to serve...."
                fi 
    fi
