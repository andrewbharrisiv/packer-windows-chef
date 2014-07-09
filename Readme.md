# Packer Windows Generator #
This is the configuration repository for generating windows vagrant boxes using
the command line utility Packer. Most information about Packer can be found at
its website http://www.packer.io/. The specifics of the windows configuration
is detailed below.

## Unattended Installation ##
----
The easiest way to install a Windows OS in a automated way is through the use
of an Autounattend.xml answer file. In the answer file in this repository,
there are a couple of areas to pay particular attention to: the serial key
provided to validate the OS, the operations invoked after install which include
setup for the OpenSSH Server, configuring the vagrant user, opening ports in
windows firewall, and some other setup and configuration commands.

## Shell Provisioner ##
----
The shell provisioner can only be run reliably through the windows command
line, which nessesitates the use of batch files. These batch files are
responsible for setting up the nessisary software needed for the vagrant
box and are installed via the chocolatey package managment system which
is documented in depth at https://chocolatey.org/. In addition to installing
software, the scripts also ensure that the proper paths are exported into the
machine level path environment variable.

## Chef Solo Provisioner ##
----
While not used at this time, the Chef Solo provisioner is a viable option for
future provisioning needs after the shell provisioner, provided the chef
package is still installed from chocolatey as is currently sepcified in
chocopacks.bat.