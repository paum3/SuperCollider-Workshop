////////////////////////////////////////////////////////////////////
/////////// SuperCollider Workshop #6 - Piezo mic, Bus, Group
////////////////////////////////////////
///////////// Super zvuky v SuperCollideri///////////////////
/////////////////////////////////////////////////Fero Kiraly///////////////////////////
////////////////////////////////////////////////////////////////




/////////////// OBSAH //////////////////
////////////////////////////////////////


    //0)  Piezo
    //1)  Synthef pre piezo
    //2)  Bus, Group



////0)
/////////////////////  Piezo
/////////////////////////////


/*

  dnes sme si vyrabali piezo snimac/mikrofon

  maly 3.5mm jack ----------- jednozilovy tieneny kabel --------------- piezo kruzok

  zaujimave navody su na tomto webe:
 https://www.cigarboxguitar.com/knowledge-base/cigar-box-guitar-piezo-wiring-diagrams/




*/



////1)
/////////////////////  Synthef pre piezo
/////////////////////////////

{Out.ar(0, SoundIn.ar(1))}.play // skuska zvuku

(
SynthDef(\piezoEff, { | amp = 1 |
	var sig = SoundIn.ar(1);
	sig = FreeVerb.ar(sig, room: 0.8);
	sig = Pan2.ar(sig,0);
	Out.ar(0, sig * amp);
}).add
)

a = Synth(\piezoEff)


a.free
s.meter



////1)
/////////////////////  Bus
/////////////////////////////



(
// tento synth pocuva mic a posiela zvuk dalej cez Bus
SynthDef(\piezo, { | amp = 1, bus = 0 |
	var sig = SoundIn.ar(1);
	Out.ar(bus, sig * amp);
}).add;


// tento synth je effekt (reverb), ktory prima zvuk na Buse, zefektuje a posierla na hardverovy vystup
SynthDef(\reverb,{ |in, pan = 0|
	var sig = In.ar(in);
	sig = FreeVerb.ar(sig, room: 0.8);
	sig = Pan2.ar(sig, pan);
	Out.ar(0,sig);
}).add;

~kablik = Bus.audio(s,1); // Bus, je to nieco ako vurualny kablik, rura, kde sa da nieco posielat a na druhom konci prijimat

)

Bus.openHelpFile

~eff = Synth(\reverb,[\in, ~kablik])
~piezo = Synth(\piezo, [\bus, ~kablik])

~eff.free
~piezo.free


/*

 v pripade ze pouzivame Bus, je dolezite poradie synthov, ten ktory prijima musi byt vytvoreny skor ako ten ktory posiela

 Davam do pozornosti dokument v helpe s nazvom Order of execution

*/


// AKo SA \to NEMA\
~piezo = Synth(\piezo, [\bus, ~kablik])
~eff = Synth(\reverb,[\in, ~kablik])
/// koniec AKo SA \to NEMA



Group.openHelpFile
~efektyGrp = Group.new
~zdrojeGrp = Group.new(~efektyGrp, \addBefore)
s.plotTree // graficke zobrazenie group
~piezo = Synth(\piezo, [\bus, ~kablik], target: ~zdrojeGrp)
~eff = Synth(\reverb,[\in, ~kablik], target: ~efektyGrp)




















