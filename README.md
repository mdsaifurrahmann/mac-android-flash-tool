# Xiaomi Android Flashing tool for MacOS & Linux

Flashing tool for all Xiaomi Devices compatible with MacOS and All Linux based Operating system. Simply clone, put the files; the rest will handle this script. Just choose your desire option.

You can check & use `adb sideload, adb devices, fastboot devices, flash VBMETA.img` and many more.

> ### Mac OS X requirements

The `grep` binary coming with Mac OS X doesn't match the same options as the GNU/Linux version. In order to make installation scripts working, you have to install the GNU/Linux version and add it to the path:

```
brew install grep
PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
```

If you want to use it as default, you can edit `.zshrc` or `.bashrc` to make the same permanent. Otherwise, it will be only for the current session.

> ### Flash Custom ROM

- To flash recovery; just put the `recovery.img` file to the root directory
- To use `adb sideload`; just put the `.zip` file to the root folder

---

> ### Flash Stock ROM

- Download the `fastboot` file from [Xiaomi Firmware Updater](https://xiaomifirmwareupdater.com/ "Xiaomi Firmware Updater") website for your xiaomi device.
- extract the compressed `fastboot` file inside the `stock-rom` folder.

---

Now, the rest of the operations will handle this script. In the mean time let's get a cup of coffee.
