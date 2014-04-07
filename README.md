Gamepad-to-360
=========

A shell script to make third party game controllers work as xbox360 controllers on linux.
A simplified hook to xboxdrv. Makes any game controller work great with source games!

### Dependencies

To be able to run this program
- xboxdrv

To be able to add your own controllers
- evtest

### How to use. it

Cd into the git directory and start the script with `sh gamepad-connect.sh`

Choose the correct /dev/input/eventX.
If you do not know which one it is, plug out your controller and type `ls /dev/input/event*`, plug it back in and the newest event number will probably be your controller.

Then it's just to select the correct controller and press 1 to start!

The program has to be running while you want the controller to be in use

If your controller is not supported, you can add it yourself. It is pretty easy actually

### How to add your own controller

Start the script as usual but choose debug (number 3) instead of start to see the input from your controller.
The value in this output is the pressed or released buttons identifier.

Now open up the controller-example.cfg.
You will see that every line begins with `KEY_#XXX`. XXX is the buttons number, so if you change this number to the one returned before.

For example, if the debug returns 279 when you press and release the A button, change the line `KEY_#XXX=a` to `KEY-#279=a`
