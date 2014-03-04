
// TWIST JACKS!!!

s.waitForBoot({
	var scribble, bus1, bus2, bus_syn, buf_syn, sources, filt, control, window, default, pulse, blip, scale,
	playact, stopact, buf, date, channels, should_record, nano, pairs, notify;



	channels = 2; // change for more
	should_record = false;

	bus1 = Bus.audio(s, channels);
	bus2 = Bus.audio(s, channels);
	sources = Group(s);
	filt = Group(s, 'addToTail');
	control = Group(s, 'addToTail');

	nano = NanoKontrol2.new;
	notify = { |message|
		("notify-send -t 10 '" + "CloudDrawings" + "' '"++ message ++ "'").unixCmd(postOutput:false);
	};

	SynthDef( "sinedbGrains", { arg out = 0, pan = 0, highfreq = 2000, lowfreq = 200,
		grainDur = 0.04, gate = 1, density = 5, hidb = -20, lowdb;

		var dust, env, wfreq, freq, mainEnv, sine, panner, amp, wamp;

		//amp = db.dbamp;
		dust = Dust.kr(density);
		wfreq = Dwhite(lowfreq, highfreq, inf);
		wamp = Dwhite(lowdb.dbamp, hidb.dbamp, inf);
		freq = Demand.kr(dust, 0, wfreq);
		amp = Demand.kr(dust, 0, wamp);
		env = EnvGen.kr(Env.sine(grainDur, amp), (dust > 0)*(gate), doneAction: 0);
		mainEnv = EnvGen.kr(Env.asr(0.01, 1, 0.01, 1), gate.if(gate, env) , doneAction:2);

		sine = SinOsc.ar(freq, 0, env);

		//panner = Pan2.ar(sine, pan, mainEnv);
		panner = PanAz.ar(channels, sine, pan, mainEnv, (channels >2).if({3}, {channels.floor}));

		Out.ar(out, panner);

	}).add;

	SynthDef( "sinedbGrains", { arg out = 0, pan = 0, highfreq = 2000, lowfreq = 200,
		grainDur = 0.04, gate = 1, density = 5, hidb = -20, lowdb;

		var dust, env, wfreq, freq, mainEnv, sine, panner, amp, wamp;

		//amp = db.dbamp;
		dust = Dust.kr(density);
		wfreq = Dwhite(lowfreq, highfreq, inf);
		wamp = Dwhite(lowdb.dbamp, hidb.dbamp, inf);
		freq = Demand.kr(dust, 0, wfreq);
		amp = Demand.kr(dust, 0, wamp);
		env = EnvGen.kr(Env.sine(grainDur, amp), (dust > 0)*(gate), doneAction: 0);
		mainEnv = EnvGen.kr(Env.asr(0.01, 1, 0.01, 1), gate.if(gate, env) , doneAction:2);

		sine = SinOsc.ar(freq, 0, env);

		//panner = Pan2.ar(sine, pan, mainEnv);
		panner = PanAz.ar(channels, sine, pan, mainEnv, (channels >2).if({3}, {channels.floor}));

		Out.ar(out, panner);

	}).add;

	SynthDef( "sawdbGrains", { arg out = 0, pan = 0, highfreq = 2000, lowfreq = 200,
		grainDur = 0.04, gate = 1, density = 5, hidb = -20, lowdb;

		var dust, env, wfreq, freq, mainEnv, sine, panner, amp, wamp;

		//amp = db.dbamp;
		dust = Dust.kr(density);
		wfreq = Dwhite(lowfreq, highfreq, inf);
		wamp = Dwhite(lowdb.dbamp, hidb.dbamp, inf);
		freq = Demand.kr(dust, 0, wfreq);
		amp = Demand.kr(dust, 0, wamp);
		env = EnvGen.kr(Env.sine(grainDur, amp), (dust > 0)*(gate), doneAction: 0);
		mainEnv = EnvGen.kr(Env.asr(0.01, 1, 0.01, 1), gate.if(gate, env) , doneAction:2);

		sine = Saw.ar(freq, env);

		//panner = Pan2.ar(sine, pan, mainEnv);
		panner = PanAz.ar(channels, sine, pan, mainEnv, (channels >2).if({3}, {channels.floor}));

		Out.ar(out, panner);

	}).add;

	SynthDef( "pulsedbGrains", { arg out = 0, pan = 0, highfreq = 2000, lowfreq = 200,
		grainDur = 0.04, gate = 1, density = 5, hidb = -20, lowdb, width = 0.5;

		var dust, env, wfreq, freq, mainEnv, sine, panner, amp, wamp;

		//amp = db.dbamp;
		dust = Dust.kr(density);
		wfreq = Dwhite(lowfreq, highfreq, inf);
		wamp = Dwhite(lowdb.dbamp, hidb.dbamp, inf);
		freq = Demand.kr(dust, 0, wfreq);
		amp = Demand.kr(dust, 0, wamp);
		env = EnvGen.kr(Env.sine(grainDur, amp), (dust > 0)*(gate), doneAction: 0);
		mainEnv = EnvGen.kr(Env.asr(0.01, 1, 0.01, 1), gate.if(gate, env) , doneAction:2);

		sine = Pulse.ar(freq, width, env);

		//panner = Pan2.ar(sine, pan, mainEnv);
		panner = PanAz.ar(channels, sine, pan, mainEnv, (channels >2).if({3}, {channels.floor}));

		Out.ar(out, panner);

	}).add;

	SynthDef( "blipdbGrains", { arg out = 0, pan = 0, highfreq = 2000, lowfreq = 200,
		grainDur = 0.04, gate = 1, density = 5, hidb = -20, lowdb, harmonics = 200;

		var dust, env, wfreq, freq, mainEnv, sine, panner, amp, wamp;

		//amp = db.dbamp;
		dust = Dust.kr(density);
		wfreq = Dwhite(lowfreq, highfreq, inf);
		wamp = Dwhite(lowdb.dbamp, hidb.dbamp, inf);
		freq = Demand.kr(dust, 0, wfreq);
		amp = Demand.kr(dust, 0, wamp);
		env = EnvGen.kr(Env.sine(grainDur, amp), (dust > 0)*(gate), doneAction: 0);
		mainEnv = EnvGen.kr(Env.asr(0.01, 1, 0.01, 1), gate.if(gate, env) , doneAction:2);

		sine = Blip.ar(freq, harmonics, env);

		//panner = Pan2.ar(sine, pan, mainEnv);
		panner = PanAz.ar(channels, sine, pan, mainEnv, (channels >2).if({3}, {channels.floor}));

		Out.ar(out, panner);

	}).add;


	SynthDef(\ampBus, {arg in, out, amp;
		var inner;

		inner = In.ar(in, channels);
		inner  = inner.tanh * amp;
		Out.ar(out, inner.tanh);
	}).store;


	SynthDef("help-Buffer",{ arg out = 0, bufnum, gate;

		var env;

		env = EnvGen.kr(Env.asr(),gate, doneAction:2);
		Out.ar( out,
			PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:1, doneAction:2) * env
		)
	}).add;



	SynthDef( "filts", { arg in = 3, out = 0, pan = 0, highfreq = 2000, lowfreq = 200,
		/*gate = 1,*/ q=0.2, db = -20, dur;

		var noise, env, panner, amp;

		amp = db.dbamp;

		noise = In.ar(in, 1);
		//noise = WhiteNoise.ar;
		noise = RHPF.ar(noise, lowfreq,q);
		noise = RLPF.ar(noise, highfreq, q);

		//env = EnvGen.kr(Env.asr(0.01, 1, 0.01, amp, 'sine'), gate, doneAction:2);
		//env = EnvGen.kr(Env.sine(dur, amp), doneAction:2);
		env = EnvGen.kr(Env.triangle(dur, amp), doneAction: 2);
		//panner = Pan2.ar(noise, pan, env);
		panner = PanAz.ar(channels, noise, pan, env, (channels >2).if({3}, {channels.floor}));

		Out.ar(out, panner);

	}).add;

	s.sync;
	1.wait;

	//buf = Buffer.read(s, "/home/celesteh/Documents/inProgress/extra20/frigo/frigoL-11.aiff");

	s.makeWindow;
	scribble = GrainPicScribble.new(projectorMode:true);
	0.5.wait;
	scribble.setDuration(1200);
	//scribble.lowPitch_(50); // OTHERMINDS

	//scale = Scala("~/Documents/scl/bohlen_12.scl".standardizePath);
	//scale.setRoot(scribble.lowPitch.value);

	//scribble.playAction_({
	//	buf_syn = Synth.new("help-Buffer",[\bufnum, buf.bufnum, \out, bus1], sources, \addToHead); "foo".postln;
	//});

	//scribble.stopAction_({buf_syn.set(\gate, 0);})






	//
	// recordings
	//

	should_record.if({

		var recording_channels, jack_ports, filename;

		filename = "/home/celesteh/Documents/inProgress/summer2013tour/sc-symposium/GrainPIC/sounds/" ++ // paths
			Date.getDate.stamp;

		s.recChannels = channels;

		s.prepareForRecord(filename ++ ".aiff");
		s.sync;


		recording_channels = channels.collect({|i| "SuperCollider:out_"++(i+1) }); // all the jack we think we have
		jack_ports = SCJConnection.getallports.values;
		recording_channels = recording_channels.select({|i| jack_ports.includes(i.asSymbol)}); // the ones that actually exist



		//("echo \"type control-c to stop recording\";" + // reminder
		//	"/usr/bin/recordmydesktop -o" + filename  ++ ".ogv --channels" + recording_channels.size + "--use-jack") // file name, number of channels
		//.ccatList(recording_channels).replace(",", "") // get rid of commas between the jack connection names
		//.postln
		//.runInTerminal;
		("ffmpeg -f jack -ac 2 -i ffmpeg -f x11grab -r 30 -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0" +
    filename ++ ".mkv"
        ).runInTerminal;

		0.5.wait;

		recording_channels.do({|channel, i|
			("/usr/bin/jack_connect" + channel + "ffmpeg:input_"++(i+1)).postln.unixCmd;
			//channel.postln;
		});

		s.record;
	});

	// end of recordings




	bus_syn = Synth.new(\ampBus, [\in, bus2, \out, 0, \amp, 1], control);

	scribble.dbAction = { |db| db = db.value; db.postln; bus_syn.set(\amp, db.dbamp)};

	// set the default settings for newly created clouds


	// the settings should be a function which returns an instance of the Conductor class
	// the Conductor object must contain a Pbind
	// the associated cloud is an argument to the function


	default = {|instrument = \sinedbGrains, duration = 0.01509|
		{arg cloud;
			Conductor.make({ arg cond, x, pan, density, grainDur;



				var div, frameDur, lowFreq, highFreq, dur, hidb, lowdb, dbslider;

				hidb = CV.new;
				lowdb = CV.new;

				hidb.spec_(\db, -20);
				lowdb.spec_(\db);
				pan.spec_(\pan);
				density.sp(10, 0.001, 100);
				grainDur.sp(duration, 0.001, 1);
				x.sp(cloud.boundingRect.left, cloud.boundingRect.left, cloud.boundingRect.right, 0, 'linear');

				lowFreq = \rest;

				pan.value = -1.0.rrand(1.0);

				// we can add different gui object besides just sliders.
				// here is a range slider tied to 2 number boxes

				cond.gui.guis = (

					dbRange: [\vrslider, [lowdb, hidb]],
					hiNlow:		[\numerical, lowdb, hidb]


				);

				// we'll put the slider and the number boxes together in the last
				// row of the control window

				cond.gui.keys = #[x, pan, density, grainDur, [dbRange, hiNlow]];

				cond.pattern_(

					Pbind(

						\dur, Prout({
							cloud.inside.size.do({
								dur = cloud.getPixelDur;
								dur = dur + dur.sum3rand;
								dur.yield;
							});
						}),


						[\highfreq, \lowfreq, \div], Pfunc({

							var arr, freqRange, loopArr, popped, left;

							div =1;

							arr = cloud.getFreqs(x);
							highFreq = arr.first;
							lowFreq = arr.last;
							div = lowFreq.size;
							[highFreq, lowFreq, div];
						}),


						\grainDur, grainDur,
						\density, Pfunc({arg evt; density.value / evt[\div]}),
						\hidb,  hidb,
						\lowdb, lowdb,
						\pan, pan,
						\legato, 2, //1.1,
						\group, sources.nodeID,
						\out, bus2,

						\instrument, instrument

					)
				)
			});
	};};

	pulse = {|instrument = \pulsedbGrains, duration = 0.01509, width = 0.5|
		{arg cloud;
			Conductor.make({ arg cond, x, pan, density, grainDur;



				var div, frameDur, lowFreq, highFreq, dur, hidb, lowdb, dbslider, wide;

				hidb = CV.new;
				lowdb = CV.new;
				wide = CV.new.value = width;

				hidb.spec_(\db, -20);
				lowdb.spec_(\db);
				pan.spec_(\pan);
				density.sp(10, 0.001, 100);
				grainDur.sp(duration, 0.001, 1);
				x.sp(cloud.boundingRect.left, cloud.boundingRect.left, cloud.boundingRect.right, 0, 'linear');

				lowFreq = \rest;

				pan.value = -1.0.rrand(1.0);

				// we can add different gui object besides just sliders.
				// here is a range slider tied to 2 number boxes

				cond.gui.guis = (

					dbRange: [\vrslider, [lowdb, hidb]],
					hiNlow:		[\numerical, lowdb, hidb]


				);

				// we'll put the slider and the number boxes together in the last
				// row of the control window

				cond.gui.keys = #[x, pan, density, grainDur, wide, [dbRange, hiNlow]];

				cond.pattern_(

					Pbind(

						\dur, Prout({
							cloud.inside.size.do({
								dur = cloud.getPixelDur;
								dur = dur + dur.sum3rand;
								dur.yield;
							});
						}),


						[\highfreq, \lowfreq, \div], Pfunc({

							var arr, freqRange, loopArr, popped, left;

							div =1;


							//left = cloud.boundingRect.left;

							//cloud.inside.do({ arg boundArr, count;
							//	arr = cloud.getFreqs(left + count);
							//	highFreq = arr.first;
							//	lowFreq = arr.last;
							//	div = lowFreq.size;
							//	[highFreq, lowFreq, div].yield;
							//});

							arr = cloud.getFreqs(x);
							highFreq = arr.first;
							lowFreq = arr.last;
							div = lowFreq.size;
							[highFreq, lowFreq, div];
						}),


						\grainDur, grainDur,
						\density, Pfunc({arg evt; density.value / evt[\div]}),
						\hidb,  hidb,
						\lowdb, lowdb,
						\pan, pan,
						\legato, 2, //1.1,
						\group, sources.nodeID,
						\out, bus2,

						\instrument, instrument

					)
				)
			});
	};};

	blip = {|instrument = \blipdbGrains, duration = 0.01509, harms = 200|
		{arg cloud;
			Conductor.make({ arg cond, x, pan, density, grainDur, harmonics;



				var div, frameDur, lowFreq, highFreq, dur, hidb, lowdb, dbslider, wide;

				hidb = CV.new;
				lowdb = CV.new;

				hidb.spec_(\db, -20);
				lowdb.spec_(\db);
				pan.spec_(\pan);
				density.sp(10, 0.001, 100);
				grainDur.sp(duration, 0.001, 1);
				x.sp(cloud.boundingRect.left, cloud.boundingRect.left, cloud.boundingRect.right, 0, 'linear');


				harmonics.sp(100, 1, 1000, 1, 'exponential');

				lowFreq = \rest;

				pan.value = -1.0.rrand(1.0);

				// we can add different gui object besides just sliders.
				// here is a range slider tied to 2 number boxes

				cond.gui.guis = (

					dbRange: [\vrslider, [lowdb, hidb]],
					hiNlow:		[\numerical, lowdb, hidb]


				);

				// we'll put the slider and the number boxes together in the last
				// row of the control window

				cond.gui.keys = #[x, pan, density, grainDur, harmonics, [dbRange, hiNlow]];

				cond.pattern_(

					Pbind(

						\dur, Prout({
							cloud.inside.size.do({
								dur = cloud.getPixelDur;
								dur = dur + dur.sum3rand;
								dur.yield;
							});
						}),


						[\highfreq, \lowfreq, \div], Pfunc({

							var arr, freqRange, loopArr, popped, left;

							div =1;


							//left = cloud.boundingRect.left;

							//cloud.inside.do({ arg boundArr, count;
							//	arr = cloud.getFreqs(left + count);
							//	highFreq = arr.first;
							//	lowFreq = arr.last;
							//	div = lowFreq.size;
							//	[highFreq, lowFreq, div].yield;
							//});

							arr = cloud.getFreqs(x);
							highFreq = arr.first;
							lowFreq = arr.last;
							div = lowFreq.size;
							[highFreq, lowFreq, div];
						}),


						\grainDur, grainDur,
						\density, Pfunc({arg evt; density.value / evt[\div]}),
						\hidb,  hidb,
						\lowdb, lowdb,
						\pan, pan,
						\legato, 2, //1.1,
						\group, sources.nodeID,
						\out, bus2,

						\instrument, instrument

					)
				)
			});
	};};


	// ok now let's control what happens with new cloud creation

	scribble.defaultSettings_(default.value);

	pairs = [
		["Xenakian Granular", { scribble.defaultSettings_(default.value);} ],
		["Xenakian Granular Long", { scribble.defaultSettings_(default.value(\sinedbGrains, 0.3.rand(0.6))); }],
		["Granular Saw", { scribble.defaultSettings_(default.value(\sawdbGrains)); }],
		["Granular Saw Long", { scribble.defaultSettings_(default.value(\sawdbGrains, 0.3.rrand(0.6))); }],
		["Granular Pulse", {scribble.defaultSettings_(pulse.value(\pulsedbGrains, 0.001.rrand(0.02), 0.4.rrand(0.6))); }],
		["Granular Pulse Long", {scribble.defaultSettings_(pulse.value(\pulsedbGrains, 0.2.rrand(0.6), 0.4.rrand(0.6))); }],
		["Granular Blip", {scribble.defaultSettings_(blip.value(\blipdbGrains, 0.001.rrand(0.02), 100.rrand(600))); }],
		["Granular Blip Long", {scribble.defaultSettings_(pulse.value(\blipdbGrains, 0.2.rrand(0.6), 100.rrand(600))); }]
	];






	window = Window("sounds", Rect(0, 0, 340, 380));

	pairs.do({ |item, index|
		Button(window, Rect (20, (20 + (index * 40)), 300, 30)).states_([[item.first, Color.black, Color.clear]])
		.action_(item.last);

		nano.setAction(("sBt"++(index+1)).asSymbol, {
			item.last.value;
			notify.(item.first);
		});
	});

	/*
	Button(window, Rect (20, 20, 300, 30)).states_([["Xenakian Granular", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(default.value);
	});
	Button(window, Rect (20, 60, 300, 30)).states_([["Xenakian Granular Long", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(default.value(\sinedbGrains, 0.3.rand(0.6)));
	});
	Button(window, Rect (20, 100, 300, 30)).states_([["Xenakian Granular Saw", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(default.value(\sawdbGrains));
	});

	Button(window, Rect (20, 140, 300, 30)).states_([["Xenakian Granular Saw Long", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(default.value(\sawdbGrains, 0.3.rrand(0.6)));
	});


	Button(window, Rect (20, 180, 300, 30)).states_([["Xenakian Granular Pulse", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(pulse.value(\pulsedbGrains, 0.001.rrand(0.02), 0.4.rrand(0.6)));
	});

	Button(window, Rect (20, 220, 300, 30)).states_([["Xenakian Granular Pulse Long", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(pulse.value(\pulsedbGrains, 0.2.rrand(0.6), 0.4.rrand(0.6)));
	});

	Button(window, Rect (20, 260, 300, 30)).states_([["Xenakian Granular Blip", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(blip.value(\blipdbGrains, 0.001.rrand(0.02), 100.rrand(600)));
	});

	Button(window, Rect (20, 300, 300, 30)).states_([["Xenakian Granular Blip Long", Color.black, Color.clear]]).action_({

		scribble.defaultSettings_(pulse.value(\blipdbGrains, 0.2.rrand(0.6), 100.rrand(600)));
	});
	*/

	window.front;
	window.alwaysOnTop = true;

	nano.setAction(\playBt, {|v| (v!=0).if({ AppClock.sched(0, {scribble.play; nil;}); }); });
	nano.setAction(\stopBt, {|v| (v!=0).if({ AppClock.sched(0, {scribble.stop; nil;}); }); });
	nano.setAction(\ffwBt, { |v| (v!=0).if({ AppClock.sched(0, {scribble.grow; nil;}); }); });





});