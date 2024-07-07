#!/bin/bash
trap "echo -e '\033[0;31m Script execution aborted. \033[0m'; exit 1" INT

echo -e "\033[0;33m
What do you want to do?
1. Flash Recovery
2. Flash VBMETA
3. Use adb Sideload
4. Use adb Sideload and Reboot to recovery
5. Check adb devices
6. Check fastboot devices
7. Reboot to System
8. Reboot to Recovery
9. Reboot to Bootloader
10. Reboot to Fastboot
11. Flash MIUI Stock ROM (Fastboot)
(Press Any key to Exit or input your choice.)
\033[0m";

read -p "Choice: " flasher

case $flasher in
  "1")

    echo -e "\033[0;33m Please ensure that 'recovery.img' file exist in root directory. Press enter to continue \033[0m";

    read

    files=("recovery.img" "./platform-tools/fastboot" "./platform-tools/adb")

    for file in "${files[@]}"; do
      if [ ! -f "$file" ]; then
        echo -e "\033[0;31m > $file file is not found \033[0m";
      fi
    done

    for file in "${files[@]}"; do
      if [ ! -f "$file" ]; then
        echo -e "\033[0;31m \033[3m Please ensure that all of these files exist and try again. Have a good day! \033[0m"
        exit 1;
      fi
    done
    
    echo -e "\033[0;32m Flashing Recovery \033[0m";
    ./platform-tools/fastboot flash recovery recovery.img
    
    read -p "Do you want to flash 'vbmeta.img' file? Type 'y' to flash, any key to skip: " vbimg;

    if [ "$vbimg" = "y" ] || [ "$vbimg" = "yes" ] || [ "$vbimg" = "Y" ] || [ "$vbimg" = "YES" ]; then
      echo -e "\033[0;33m make sure 'vbmeta.img' file exist in the root directory. \033[0m";
      echo -e "\033[0;32m Flashing vbmeta.img \033[0m";
      ./platform-tools/fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
    else
      echo -e "\033[0;32m Skipping Flashing vbmeta.img \033[0m";
    fi

    echo -e "\033[0;32m Rebooting to Recovery \033[0m";
    ./platform-tools/fastboot reboot recovery

    if [ $? -eq 0 ]; then
      echo -e "\033[0;32m Operation Succeed \033[0m";
    fi

    source ./flash.sh
  ;;
  "2")
    if [ ! -f "vbmeta.img" ]; then
        echo -e "\033[0;31m \033[3m Please ensure that 'vbmeta.img' file exist in the root directory and try again. Have a good day! \033[0m"
        exit 1;
    fi

    if [ ! -f "./platform-tools/fastboot" ]; then
        echo -e "\033[0;31m \033[3m Please ensure that fastboot file exist in platform-tools and try again. Have a good day! \033[0m"
        exit 1;
      fi

    echo -e "\033[0;32m Flashing vbmeta.img \033[0m";
    ./platform-tools/fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img

    echo -e "\033[0;32m Rebooting your device to system! Have a good day! \033[0m";
    ./platform-tools/fastboot reboot

    if [ $? -eq 0 ]; then
      echo -e "\033[0;32m Operation Succeed \033[0m";
    fi

    source ./flash.sh

  ;;
  "3")

    echo -e "\033[0;32m Please enter the file name of your custom rom. \033[0m";
    read -p "Enter the zip file name: " romname

    if [ ! -f "$romname" ]; then
        echo -e "\033[0;31m > $romname file is not found \033[0m";
        echo -e "\033[0;31m \033[3m Please ensure that '$romname' file exist and try again. Have a good day! \033[0m";
        exit 1;
    fi
    if [ ! -f "./platform-tools/adb" ]; then
        echo -e "\033[0;31m > adb file is not found \033[0m";
        echo -e "\033[0;31m \033[3m Please ensure that 'adb' file exist and try again. Have a good day! \033[0m";
        exit 1;
    fi
    ./platform-tools/adb sideload $romname

    if [ $? -eq 0 ]; then
      echo -e "\033[0;32m sideload operation completed \033[0m";
    fi

    source ./flash.sh
    
  ;;
  "4")

    echo -e "\033[0;32m Please enter the file name of your custom rom. \033[0m";
    read -p "Enter the zip file name: " romname

    if [ ! -f "$romname" ]; then
        echo -e "\033[0;31m > $romname file is not found \033[0m";
        echo -e "\033[0;31m \033[3m Please ensure that '$romname' file exist and try again. Have a good day! \033[0m";
        exit 1;
    fi
    if [ ! -f "./platform-tools/adb" ]; then
        echo -e "\033[0;31m > adb file is not found \033[0m";
        echo -e "\033[0;31m \033[3m Please ensure that 'adb' file exist and try again. Have a good day! \033[0m";
        exit 1;
    fi
    ./platform-tools/adb sideload $romname

    if [ $? -eq 0 ]; then
      echo -e "\033[0;32m Sideload operation completed. Rebooting to Recovery \033[0m";
      ./platform-tools/adb reboot recovery
    fi

    source ./flash.sh
    
  ;;
  "5")
    echo -e "\033[0;32m adb device list: \033[0m"
    ./platform-tools/adb devices

    source ./flash.sh
  ;;
  "6")
    echo -e "\033[0;32m fastboot device list: \033[0m"
    ./platform-tools/fastboot devices

    source ./flash.sh
  ;;
  "7")
    echo -e "\033[0;32m Rebooting your device to system! Have a good day! \033[0m";
    ./platform-tools/fastboot reboot

    source ./flash.sh
  ;;
  "8")
    echo -e "\033[0;32m Rebooting your device to Recovery! \033[0m";
    ./platform-tools/fastboot reboot recovery

    source ./flash.sh
  ;;
  "9")
    echo -e "\033[0;32m Rebooting your device to Bootloader! \033[0m";
    ./platform-tools/fastboot reboot bootloader

    source ./flash.sh
  ;;
  "10")
    echo -e "\033[0;32m Rebooting your device to Fastboot! \033[0m";
    ./platform-tools/fastboot reboot fastboot

    source ./flash.sh
  ;;
  "11")
    echo -e "\033[0;32m Great Choice! Heading up to Stock ROM Flash system! \033[0m";
    source ./flash-stock-rom.sh;
  ;;
  *)
    echo -e '\033[0;31m Script execution aborted. \033[0m';
    exit 1
  ;;
esac

