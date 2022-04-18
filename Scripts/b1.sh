#! /bin/bash
#Check  root privilege
if [[ "$(id -u)" != "0" ]]; then
      echo "Error: This script need ROOT privilege, pls run 'sudo -sE' first!"
      exit 1
fi
#check Master  status and start service 
#PIDS=`ps -ef | grep "ros" | grep -v grep | cut -c 9-16`
#if [ "$PIDS" != "" ]; then
#    echo "B1 Master service is restarting....." 
#    ps -ef |grep "ros2" | grep -v grep | cut -c 9-16 |xargs kill -s 9
#    sleep 5
#else
#echo "Make sure B1 is powered on with ZERO position!"
#sleep 1
#fi

#sh master.sh
#nohup ros2 launch amber_b1_bringup amber_b1_hw_gui_ethercat.launch.py >/home/amber/ros2_ws/ros.out 2>&1 &
#echo "B1 Master Service is starting, wait a second please"
#sleep 10
PIDS=`ps -ef |grep "ros" | grep -v grep | cut -c 9-16`
    if [ "$PIDS" != "" ]; then                      
        echo "The Master is restarting..."        
        ps -ef |grep "ros" | grep -v grep | cut -c 9-16 |xargs kill -s 9
        sleep 2                                   
        nohup ros2 launch amber_b1_bringup amber_b1_hw_gui_ethercat.launch.py >/home/amber/ros2_ws/ros.out 2>&1 &
        echo "Master service is starting with status 1 , wait a second please..."
        sleep 15                                  
            #check ros2 status                    
            ROS2=`grep -E "Error|ERROR|WARNING" /home/amber/ros2_ws/ros.out | grep -v grep`
#awk '{print $2}'
            sleep 3
                if [ "$ROS2" != "" ]; then # ROS2 abnormal        
                  echo ""
                  echo -e "Error message: " "\033[34m" $ROS2 "\033[0m"
                  echo ""
                  echo -e "\033[33m Master service abnormal 1, please check all the cables connected and powerd on with zero position. \033[0m"
                  echo -e "\033[33m Or unplug X-hub Power cable, plug it again after around 10 seconds. \033[0m"
                  ps -ef |grep "ros" | grep -v grep | cut -c 9-16 |xargs kill -s 9
                  echo -e "\033[34m Master server terminated. \033[0m"
                  sleep 1
                  exit 1
                else                              
                  sleep 1                         
                  echo "The Master is restarted and serving...."                                                                    
                fi                                                                          
    else                                          
        nohup ros2 launch amber_b1_bringup amber_b1_hw_gui_ethercat.launch.py >/home/amber/ros2_ws/ros.out 2>&1 &
        echo "Master service is starting with status 2, wait a second please..."
        sleep 15                                  
            #check ros2 status                    
            ROS2=`grep -E "Error|ERROR|WARNING" /home/amber/ros2_ws/ros.out | grep -v grep`
            sleep 3
                if [ "$ROS2" != "" ]; then # ROS2 abnormal
                echo ""
                echo -e "Error message: \033[34m" $ROS2 "\033[0m"
                echo ""
                  echo -e "\033[33m Master service abnormal 2 , please check all the cables connected and powerd on with zero position. \033[0m"
                  echo -e "\033[33m Or unplug X-hub Power cable, plug it again after around 10 seconds. \033[0m"
                  ps -ef |grep "ros" | grep -v grep | cut -c 9-16 |xargs kill -s 9
                  echo -e "\033[34m Master service terminated \033[0m"
                  sleep 1
                  exit 1 
                else                              
                  sleep 1                         
                  echo "The Master is ready to serve...."
                fi                                
    fi              

# if X-hub is running,
PIDS=`ps -ef | grep "runserver" | grep -v grep | awk '{print $2}'`
if [ "$PIDS" != "" ]; then
      echo "B1 X-Hub Service has started already!!! "
#Check whether B1 Master Server is running,
else

#check whether X-hub is running

#PIDS=`ps -ef | grep "runserver" | grep -v grep | cut -c 9-16`
#if [ "$PIDS" != "" ]; then
#    echo "B1 X-Hub service is restarting....."
#    ps -ef |grep "runserver" | grep -v grep | cut -c 9-16 |xargs kill -s 9
#    sleep 1
#    nohup python3 amber_robot_studio_backend/manage.py runserver 0.0.0.0:8080 >/home/amber/p.out 2>&1 &       
#    echo "X-Hub is starting...."
#    sleep 1
#else
    nohup python3 amber_robot_studio_backend/manage.py runserver 0.0.0.0:8080 >/home/amber/p.out 2>&1 &
    echo "B1 X-Hub is serving now......"
fi
