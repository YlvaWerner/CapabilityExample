# CapabilityExample

## Capabilities is a design pattern / structure developed at Hazelight.
This project is the simplest example of Capabilities.

The Capability folder holds the system / structure itself. 
This is just an example of how a CapabilityTickManager could be implemented. 
I strongly encourage you to modify the classes to suit your specific needs.
The Bow actor is an example of how capabilities can look like in action.

## Capabilities
* Components vs Actor decision making.
* Components aren't allowed to make decisions
* But we don't want blob actorns
* Capabilities are extensions of the actors decision making
* Capabilities makes decisions / behavior instead of components
* Components are instead data which capabilities share and can act on
* Capabilities are isolated files <- No spaghetti or awareness of other capabilities!
* One way street communication

