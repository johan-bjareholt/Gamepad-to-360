Gamepad-to-360
=========

A shell script to make third party game controllers work as xbox360 controllers on linux.
A simplified hook to xboxdrv. Great for making any game controller work with source games!

### Dependencies

To be able to run this program
- evdev (standard package on most distros)
- [xboxdrv](https://github.com/Grumbel/xboxdrv)

To be able to add your own controllers
- evtest

To install both on ubuntu:
sudo apt-get install xboxdrv evtest

### Usage

1. Cd into the git directory 
2. start the script with `sh gamepad-connect.sh start`
3. Choose the correct device number ( [Don't know which one it is?](#faq1) )
4. Select your gamepad model

The program has to be running while you want the controller to be in use

If your controller is not supported, you can add it yourself. It is pretty easy actually

### How to add your own controller

Start the script with debug as arg`sh gamepad-connect.sh debug` to see the input from your controller.
The value in this output is the pressed or released buttons identifier.

Open up the controller-example.cfg.
You will see that every line begins with `KEY_#XXX`. Replace XXX with the button identifier number

For example, if the debug returns 279 when you press and release the A button, change the line `KEY_#XXX=a` to `KEY-#279=a`


## FAQ

#### <a name="faq1"></a>Which /dev/input/event is my controller?

If you do not know which one it is, plug out your controller and type `ls /dev/input/event*`, plug it back in, type the command again. The eventX that is apparent on the second time you wrote the command but not the first, is your controller.

#### My controller isn't showing up in /dev/input/event

I'm sorry but i cannot help you here since these are driver issues.
Something that i would recommend is to get a distro with a newer kernel and evdev versions.
The script runs great on my laptop with Arch, but does not work with my desktop running Ubuntu 12.04. I do not know if newer ubuntu versions works with it, but it's highly possible.

Start with seeing if lsusb detects it, if it doesn't you can probably blame your kernel.
