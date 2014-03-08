CloudDrawings
=============

The piece I played at OtherMinds 19

Requirements:

* This piece requires the Conductor quark.
* It can also optionally use the NanoKontrol2 class https://github.com/celesteh/NanoKontrol2.sc

Howto install:

Put the GrainPIC_Extensions folder into your SuperCollider extensions.  

Howto run:

Then open CloudDrawings.scd, select all and run.

The SuperCollider files should all be cross-platform.

Linux-users:

The shell scripts are linux-specific but are not required for linux users.

* jack_script.sh solves some problems I had with getting jack to use my audio card with the correct settings.
* stylus_script.sh is extremely useful for using a touch screen when plugged into a projector. It handles a changed screen geometry if the projector is running at a different ratio than your normal screen.
* start.sh is just a single command so I don;t have to remember multiple things while on stage.

Controllers:

This piece optionally uses a NanoKontrol via this class: https://github.com/celesteh/NanoKontrol2.sc


Notes:
* I started writing this several years ago and did not do the MVC design very well at all, so this needs a major overhall,
but at least is playable in the mean time.
* There are no help files. Sorry.  But there is some very old documentation here: http://www.berkeleynoise.com/celesteh/podcast/projects/grainpic/


Finally, please drop me a line if you perform this any place. celesteh@gmail.com
