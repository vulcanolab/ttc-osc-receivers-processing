## An OSC State receiving sample based on Processing that produces a flow field 
_(freely inspired by the © Daniel Shiffman NOC example)_

A Java-Processing sketch sample specially built for receiving state data (understand "surface data") in the shape of OpenSoundControl messages coming from the [free OSC State iPhone app](https://itunes.apple.com/us/app/osc-state-tapioca-toys/id1456542260?mt=8) that's available on the App Store.

It works with [Processing 3.3.4](https://processing.org/download/ "download Processing") and later, and its [OSC library](http://www.sojamo.de/libraries/oscp5).

(VIDEO) Check in out in action: https://vimeo.com/326081120.

![OSC State communicating with Processing sample on Mac](https://tapioca.toys/assets/img/tapioca-toys-osc-processing-03.jpg?v=2 "OSC State communicating with Processing sample on Mac")

Receive everything on the `14041` port number, use `/tapiocatoys/state` as message pattern and check for a `ii` typetag. The first integer is the id of one of the 32 by 24 "osc pixels", and the other integer is its grayscale value ranging from 0 to 255.
