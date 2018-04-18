////////////////////////////////////////////////////////////////////
/////////// SuperCollider Workshop #7 - Buffer
////////////////////////////////////////
///////////// Super zvuky v SuperCollideri///////////////////
/////////////////////////////////////////////////Fero Kiraly///////////////////////////
////////////////////////////////////////////////////////////////




/////////////// OBSAH //////////////////
////////////////////////////////////////


    //0)  Zaujimavy software ktory sme dnes spominali
    //1)  Buffer




////0)
/////////////////////  iny zaujimavy software
/////////////////////////////



/*
 sketchup, processing.org, iannix, tidalcycles

 mozete si to pogooglit

*/



////1)
/////////////////////  Buffer
/////////////////////////////

Buffer
s.boot
a = Buffer.read(s,"/home/paum/Projekty/samples/glitch2/glitch_010.aiff")
a.free
a.play

a.numFrames // pocet frameov, alebo samplov v nahravke

a.bufnum // cislo buffra


s.sampleRate

a.plot
a.play

p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b = Buffer.read(s,p)
b.play
b.bufnum

/* prehravac */
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0, rate = 1 |
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate , doneAction: 2)
    )
}).add;

x = Synth(\help_PlayBuf, [\bufnum,a, \rate,1])




/* nahravac */
~buf = Buffer.alloc(s, s.sampleRate * 4)

~buf.plot


(
SynthDef(\recBuf,{ arg buffer=0;
	var in;
	in = SoundIn.ar(0);
	RecordBuf.ar(in, buffer);
}).add;
)


~rec = Synth(\recBuf,[\buffer,~buf])
~rec.free

~buf.plot
~buf.play


/*  Nahravanie na seba v loope       */

/*
  - Alokujeme pamat pre buffer

  - Vytvorime 2 Synthdefy:
  1. ktory nahrava do buffru
  2. ktory prehrava

  - hrame sa !
*/

~buf.free; // vymazat alokovany buffer, pre istotu
~buf = Buffer.alloc(server: s, numFrames: s.sampleRate * 4,  numChannels: 1) // alokovanie pamate na 4 sekundy

/* nahravanie sa vrstvi vdaka parametru preLevel:1 */
(
SynthDef(\recBufLoop,{ arg buffer=0;
	var in;
	in = SoundIn.ar(0);
	RecordBuf.ar(in, buffer, preLevel: 1);
}).add;
)

/* prehravac ktory nahravku loopuje vdaka parametru loop:1  */
SynthDef(\playBufLoop, {| out = 0, bufnum = 0, rate = 1 |
    Out.ar(out,
        PlayBuf.ar(numChannels:1, bufnum, BufRateScale.kr(bufnum) * rate, loop:1) // cita len MONO lebo numChannels: 1
    )
}).add;

~buf.zero // vynulovanie buffra
~buf.plot // vykreslenie buffra

~rec = Synth(\recBufLoop,[\buffer,~buf]) // zacne nahravat
~player = Synth(\playBufLoop, [\bufnum,~buf, \rate,1]) //zacne prehravat

~player.free
~rec.free
~buf.free




///////////////////////////////////////////////////////////////////////////////




(
SynthDef.new(\samplePlayer,{

	    arg buf, out = 0, start = 0, len = 1, rate = 1, amp = 1, pan = 0, atk = 0.01, rel = 0.01 ;
		var sig, env;

		start = start * BufFrames.kr(buf);
		len = len * BufFrames.kr(buf) / 44100;

		env = EnvGen.kr( Env( [0,1,1,0], [atk, len - atk ,rel], [3,0,-3] ) , doneAction:2);
		sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate,startPos:start, loop:0,  doneAction:2);


	    sig = sig * env * amp;
	    Out.ar(out, Pan2.ar(sig, pan) );
	}).add;
)

~s = Synth(\samplePlayer, [\buf, b, \start, 0.5.rand+0.01, \len, 0.1.rand+0.01, \amp, 0.5, \rate, 1] );

(
Pbindef(\x,
	\instrument, \samplePlayer,
	\buf, b,
	\start, 0.5.rand+0.01,
	\len, Pwhite(0.05,0.1) / 200,
    \amp, 0.5,
	\rate, Pbrown(0.5,1.2)  ,
	\dur, Pseq([0.5,0.5,0.2,0.2],inf) / 3
).play
)



















