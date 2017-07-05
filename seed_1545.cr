#!/usr/bin/env crystal

require "pg"
require "crecto"

require "./src/repo"
require "./src/race_stats/*"



# Games

sm64 = Game.new
sm64.name = "SM64"
sm64.series = "mario"
sm64.progress_unit = "Stars"
sm64.progress_max = 120
sunshine = Game.new
sunshine.name = "Sunshine"
sunshine.series = "mario"
sunshine.progress_unit = "Shines"
sunshine.progress_max = 120
galaxy1 = Game.new
galaxy1.name = "Galaxy 1"
galaxy1.series = "mario"
galaxy1.progress_unit = "stars"
galaxy1.progress_max = 120
galaxy2 = Game.new
galaxy2.name = "Galaxy 2"
galaxy2.series = "mario"
galaxy2.progress_unit = "stars"
galaxy2.progress_max = 242
kazooie = Game.new
kazooie.name = "Kazooie"
kazooie.series = "rare"
kazooie.progress_unit = "%"
kazooie.progress_max = 100
tooie = Game.new
tooie.name = "Tooie"
tooie.series = "rare"
tooie.progress_unit = "%"
tooie.progress_max = 100
dk64 = Game.new
dk64.name = "DK64"
dk64.series = "rare"
dk64.progress_unit = "%"
dk64.progress_max = 101
spyro1 = Game.new
spyro1.name = "Spyro 1"
spyro1.series = "spyro"
spyro1.progress_unit = "%"
spyro1.progress_max = 120
spyro2 = Game.new
spyro2.name = "Spyro 2"
spyro2.series = "spyro"
spyro2.progress_unit = "%"
spyro2.progress_max = 100
spyro3 = Game.new
spyro3.name = "Spyro 3"
spyro3.series = "spyro"
spyro3.progress_unit = "%"
spyro3.progress_max = 117
crash1 = Game.new
crash1.name = "Crash 1"
crash1.series = "crash"
crash1.progress_unit = "%"
crash1.progress_max = 100
crash2 = Game.new
crash2.name = "Crash 2"
crash2.series = "crash"
crash2.progress_unit = "%"
crash2.progress_max = 100
crash3 = Game.new
crash3.name = "Crash 3"
crash3.series = "crash"
crash3.progress_unit = "%"
crash3.progress_max = 105
sm64      = Repo.insert(sm64).instance
sunshine  = Repo.insert(sunshine).instance
galaxy1   = Repo.insert(galaxy1).instance
galaxy2   = Repo.insert(galaxy2).instance
kazooie   = Repo.insert(kazooie).instance
tooie     = Repo.insert(tooie).instance
dk64      = Repo.insert(dk64).instance
spyro1    = Repo.insert(spyro1).instance
spyro2    = Repo.insert(spyro2).instance
spyro3    = Repo.insert(spyro3).instance
crash1    = Repo.insert(crash1).instance
crash2    = Repo.insert(crash2).instance
crash3    = Repo.insert(crash3).instance



# Teams + Runners

red = Team.new
red.name = "Anything But Last"
orange = Team.new
orange.name = "Team Mornin'"
yellow = Team.new
yellow.name = "The Happy Little Speed Runners"
green = Team.new
green.name = "Y'all Just Got B E A N E D"
blue = Team.new
blue.name = "Team LilZ"
purple = Team.new
purple.name = "Iateyourgrapes"
red = Repo.insert(red).instance
orange = Repo.insert(orange).instance
yellow = Repo.insert(yellow).instance
green = Repo.insert(green).instance
blue = Repo.insert(blue).instance
purple = Repo.insert(purple).instance


burgerlands2 = Runner.new
burgerlands2.name = "burgerlands2"
burgerlands2.team_id = red.id
emoarbiter = Runner.new
emoarbiter.name = "EmoArbiter"
emoarbiter.team_id = red.id
gazco41 = Runner.new
gazco41.name = "Gazco41"
gazco41.team_id = red.id
holysanctum = Runner.new
holysanctum.name = "HolySanctum"
holysanctum.team_id = red.id
kiwikiller67 = Runner.new
kiwikiller67.name = "Kiwikiller67"
kiwikiller67.team_id = red.id
muimania = Runner.new
muimania.name = "Muimania"
muimania.team_id = red.id
nostalgia64 = Runner.new
nostalgia64.name = "Nostalgia64"
nostalgia64.team_id = red.id
odme = Runner.new
odme.name = "Odme"
odme.team_id = red.id
burgerlands2 = Repo.insert(burgerlands2).instance
emoarbiter = Repo.insert(emoarbiter).instance
gazco41 = Repo.insert(gazco41).instance
holysanctum = Repo.insert(holysanctum).instance
kiwikiller67 = Repo.insert(kiwikiller67).instance
muimania = Repo.insert(muimania).instance
nostalgia64 = Repo.insert(nostalgia64).instance
odme = Repo.insert(odme).instance


cosmoing = Runner.new
cosmoing.name = "Cosmoing"
cosmoing.team_id = orange.id
hsi_wu = Runner.new
hsi_wu.name = "hsi_wu"
hsi_wu.team_id = orange.id
icupspeedruns = Runner.new
icupspeedruns.name = "icupspeedruns"
icupspeedruns.team_id = orange.id
lazybearbanjo = Runner.new
lazybearbanjo.name = "LazyBearBanjo"
lazybearbanjo.team_id = orange.id
strongmanlin = Runner.new
strongmanlin.name = "StrongmanLin"
strongmanlin.team_id = orange.id
theballaam96 = Runner.new
theballaam96.name = "theballaam96"
theballaam96.team_id = orange.id
totozigemm = Runner.new
totozigemm.name = "TOTOzigemm"
totozigemm.team_id = orange.id
cosmoing = Repo.insert(cosmoing).instance
hsi_wu = Repo.insert(hsi_wu).instance
icupspeedruns = Repo.insert(icupspeedruns).instance
lazybearbanjo = Repo.insert(lazybearbanjo).instance
strongmanlin = Repo.insert(strongmanlin).instance
theballaam96 = Repo.insert(theballaam96).instance
totozigemm = Repo.insert(totozigemm).instance


claire = Runner.new
claire.name = "Claire"
claire.team_id = yellow.id
connor75 = Runner.new
connor75.name = "Connor75"
connor75.team_id = yellow.id
dickhiskhan = Runner.new
dickhiskhan.name = "Dickhiskhan"
dickhiskhan.team_id = yellow.id
g0goTBC = Runner.new
g0goTBC.name = "g0goTBC"
g0goTBC.team_id = yellow.id
krismarqz = Runner.new
krismarqz.name = "KrisMarqz"
krismarqz.team_id = yellow.id
monger7 = Runner.new
monger7.name = "Monger7"
monger7.team_id = yellow.id
sonicboomsensei = Runner.new
sonicboomsensei.name = "SonicBoomSensei"
sonicboomsensei.team_id = yellow.id
tebt = Runner.new
tebt.name = "Tebt"
tebt.team_id = yellow.id
wedc517 = Runner.new
wedc517.name = "Wedc517"
wedc517.team_id = yellow.id
zacho = Runner.new
zacho.name = "Zacho"
zacho.team_id = yellow.id
claire = Repo.insert(claire).instance
connor75 = Repo.insert(connor75).instance
dickhiskhan = Repo.insert(dickhiskhan).instance
g0goTBC = Repo.insert(g0goTBC).instance
krismarqz = Repo.insert(krismarqz).instance
monger7 = Repo.insert(monger7).instance
sonicboomsensei = Repo.insert(sonicboomsensei).instance
tebt = Repo.insert(tebt).instance
wedc517 = Repo.insert(wedc517).instance
zacho = Repo.insert(zacho).instance


bandow2000 = Runner.new
bandow2000.name = "Bandow2000"
bandow2000.team_id = green.id
conklesToTheMax = Runner.new
conklesToTheMax.name = "ConklesToTheMax"
conklesToTheMax.team_id = green.id
johanian = Runner.new
johanian.name = "Johanian"
johanian.team_id = green.id
nerf = Runner.new
nerf.name = "nerf"
nerf.team_id = green.id
notvanni = Runner.new
notvanni.name = "notvanni"
notvanni.team_id = green.id
secretHumorMan = Runner.new
secretHumorMan.name = "SecretHumorMan"
secretHumorMan.team_id = green.id
skiCrazedTeddy = Runner.new
skiCrazedTeddy.name = "SkiCrazedTeddy"
skiCrazedTeddy.team_id = green.id
theMartonFi = Runner.new
theMartonFi.name = "TheMartonFi"
theMartonFi.team_id = green.id
yeswally1 = Runner.new
yeswally1.name = "Yeswally1"
yeswally1.team_id = green.id
bandow2000 = Repo.insert(bandow2000).instance
conklesToTheMax = Repo.insert(conklesToTheMax).instance
johanian = Repo.insert(johanian).instance
nerf = Repo.insert(nerf).instance
notvanni = Repo.insert(notvanni).instance
secretHumorMan = Repo.insert(secretHumorMan).instance
skiCrazedTeddy = Repo.insert(skiCrazedTeddy).instance
theMartonFi = Repo.insert(theMartonFi).instance
yeswally1 = Repo.insert(yeswally1).instance


five_mon = Runner.new
five_mon.name = "5mon"
five_mon.team_id = blue.id
dact = Runner.new
dact.name = "Dact"
dact.team_id = blue.id
feranator115 = Runner.new
feranator115.name = "FERANATOR115"
feranator115.team_id = blue.id
kaptainKohl = Runner.new
kaptainKohl.name = "KaptainKohl"
kaptainKohl.team_id = blue.id
konditioner = Runner.new
konditioner.name = "Konditioner"
konditioner.team_id = blue.id
martyrrSenpai = Runner.new
martyrrSenpai.name = "MartyrrSenpai"
martyrrSenpai.team_id = blue.id
obiyo = Runner.new
obiyo.name = "Obiyo"
obiyo.team_id = blue.id
sniperKing = Runner.new
sniperKing.name = "SniperKing"
sniperKing.team_id = blue.id
spikeVegeta = Runner.new
spikeVegeta.name = "SpikeVegeta"
spikeVegeta.team_id = blue.id
theSludgyGamer = Runner.new
theSludgyGamer.name = "TheSludgyGamer"
theSludgyGamer.team_id = blue.id
five_mon = Repo.insert(five_mon).instance
dact = Repo.insert(dact).instance
feranator115 = Repo.insert(feranator115).instance
kaptainKohl = Repo.insert(kaptainKohl).instance
konditioner = Repo.insert(konditioner).instance
martyrrSenpai = Repo.insert(martyrrSenpai).instance
obiyo = Repo.insert(obiyo).instance
sniperKing = Repo.insert(sniperKing).instance
spikeVegeta = Repo.insert(spikeVegeta).instance
theSludgyGamer = Repo.insert(theSludgyGamer).instance


beuchi = Runner.new
beuchi.name = "Beuchi"
beuchi.team_id = purple.id
gdo = Runner.new
gdo.name = "GDO"
gdo.team_id = purple.id
hagginater = Runner.new
hagginater.name = "hagginater"
hagginater.team_id = purple.id
jag = Runner.new
jag.name = "Jag"
jag.team_id = purple.id
nocturne_ = Runner.new
nocturne_.name = "Nocturne_"
nocturne_.team_id = purple.id
paracusia = Runner.new
paracusia.name = "Paracusia"
paracusia.team_id = purple.id
robthegamer115 = Runner.new
robthegamer115.name = "Robthegamer115"
robthegamer115.team_id = purple.id
spyro = Runner.new
spyro.name = "Spyro"
spyro.team_id = purple.id
whitePaaws = Runner.new
whitePaaws.name = "WhitePaaws"
whitePaaws.team_id = purple.id
beuchi = Repo.insert(beuchi).instance
gdo = Repo.insert(gdo).instance
hagginater = Repo.insert(hagginater).instance
jag = Repo.insert(jag).instance
nocturne_ = Repo.insert(nocturne_).instance
paracusia = Repo.insert(paracusia).instance
robthegamer115 = Repo.insert(robthegamer115).instance
spyro = Repo.insert(spyro).instance
whitePaaws = Repo.insert(whitePaaws).instance



# Runs

# Anything But Last
Repo.insert(Run.new(burgerlands2,   crash1,    1, Time::Span.new( 1, 35,  0).to_i))
Repo.insert(Run.new(odme,           galaxy2,   2, Time::Span.new(10, 20,  0).to_i))
Repo.insert(Run.new(holysanctum,    spyro2,    3, Time::Span.new( 3, 30,  0).to_i))
Repo.insert(Run.new(gazco41,        spyro1,    4, Time::Span.new( 1, 35,  0).to_i))
Repo.insert(Run.new(kiwikiller67,   dk64,      5, Time::Span.new( 6, 10,  0).to_i))
Repo.insert(Run.new(gazco41,        spyro3,    6, Time::Span.new( 3, 40,  0).to_i))
Repo.insert(Run.new(emoarbiter,     tooie,     7, Time::Span.new( 5, 45,  0).to_i))
Repo.insert(Run.new(burgerlands2,   crash3,    8, Time::Span.new( 2, 30,  0).to_i))
Repo.insert(Run.new(holysanctum,    crash2,    9, Time::Span.new( 2, 30,  0).to_i))
Repo.insert(Run.new(muimania,       sunshine, 10, Time::Span.new( 4, 15,  0).to_i))
Repo.insert(Run.new(nostalgia64,    galaxy1,  11, Time::Span.new( 7, 10,  0).to_i))
Repo.insert(Run.new(muimania,       sm64,     12, Time::Span.new( 2, 10,  0).to_i))
Repo.insert(Run.new(emoarbiter,     kazooie,  13, Time::Span.new( 2, 45,  0).to_i))


# Team Mornin'
Repo.insert(Run.new(cosmoing,       sm64,      1, Time::Span.new( 3,  0,  0).to_i))
Repo.insert(Run.new(icupspeedruns,  tooie,     2, Time::Span.new( 5,  0,  0).to_i))
Repo.insert(Run.new(hsi_wu,         spyro3,    3, Time::Span.new( 4,  0,  0).to_i))
Repo.insert(Run.new(totozigemm,     crash3,    4, Time::Span.new( 3,  0,  0).to_i))
Repo.insert(Run.new(cosmoing,       galaxy2,   5, Time::Span.new(11,  0,  0).to_i))
Repo.insert(Run.new(strongmanlin,   sunshine,  6, Time::Span.new( 4,  0,  0).to_i))
Repo.insert(Run.new(totozigemm,     crash2,    7, Time::Span.new( 2,  0,  0).to_i))
Repo.insert(Run.new(hsi_wu,         spyro1,    8, Time::Span.new( 2,  0,  0).to_i))
Repo.insert(Run.new(totozigemm,     spyro2,    9, Time::Span.new( 2,  0,  0).to_i))
Repo.insert(Run.new(theballaam96,   dk64,     10, Time::Span.new( 6, 25,  0).to_i))
Repo.insert(Run.new(strongmanlin,   galaxy1,  11, Time::Span.new( 7,  0,  0).to_i))
Repo.insert(Run.new(hsi_wu,         crash1,   12, Time::Span.new( 2,  0,  0).to_i))
Repo.insert(Run.new(lazybearbanjo,  kazooie,  13, Time::Span.new( 2, 25,  0).to_i))


# The Happy Little Speed Runners
Repo.insert(Run.new(krismarqz,        crash2,    1, Time::Span.new( 1, 25,  0).to_i))
Repo.insert(Run.new(krismarqz,        crash3,    2, Time::Span.new( 2, 30,  0).to_i))
Repo.insert(Run.new(tebt,             crash1,    3, Time::Span.new( 1, 25,  0).to_i))
Repo.insert(Run.new(wedc517,          spyro2,    4, Time::Span.new( 2, 10,  0).to_i))
Repo.insert(Run.new(dickhiskhan,      kazooie,   5, Time::Span.new( 2, 15,  0).to_i))
Repo.insert(Run.new(dickhiskhan,      tooie,     6, Time::Span.new( 4, 50,  0).to_i))
Repo.insert(Run.new(g0goTBC,          sm64,      7, Time::Span.new( 2, 20,  0).to_i))
Repo.insert(Run.new(wedc517,          spyro3,    8, Time::Span.new( 3, 40,  0).to_i))
Repo.insert(Run.new(claire,           sunshine,  9, Time::Span.new( 3, 45,  0).to_i))
Repo.insert(Run.new(claire,           galaxy2,  10, Time::Span.new(10, 15,  0).to_i))
Repo.insert(Run.new(zacho,            spyro1,   11, Time::Span.new( 2, 30,  0).to_i))
Repo.insert(Run.new(sonicboomsensei,  galaxy1,  12, Time::Span.new( 7, 30,  0).to_i))
Repo.insert(Run.new(connor75,         dk64,     13, Time::Span.new( 5, 40,  0).to_i))


# Y'all Just Got B E A N E D
Repo.insert(Run.new(skiCrazedTeddy,   crash3,    1, Time::Span.new( 2, 15,  0).to_i))
Repo.insert(Run.new(notvanni,         crash1,    2, Time::Span.new( 1, 20,  0).to_i))
Repo.insert(Run.new(notvanni,         crash2,    3, Time::Span.new( 1, 25,  0).to_i))
Repo.insert(Run.new(theMartonFi,      kazooie,   4, Time::Span.new( 2, 20,  0).to_i))
Repo.insert(Run.new(secretHumorMan,   dk64,      5, Time::Span.new( 7,  0,  0).to_i))
Repo.insert(Run.new(nerf,             spyro1,    6, Time::Span.new( 1, 40,  0).to_i))
Repo.insert(Run.new(bandow2000,       galaxy1,   7, Time::Span.new( 7,  0,  0).to_i))
Repo.insert(Run.new(secretHumorMan,   tooie,     8, Time::Span.new( 4, 50,  0).to_i))
Repo.insert(Run.new(johanian,         sm64,      9, Time::Span.new( 3, 30,  0).to_i))
Repo.insert(Run.new(nerf,             spyro2,   10, Time::Span.new( 1, 55,  0).to_i))
Repo.insert(Run.new(johanian,         sunshine, 11, Time::Span.new( 5,  0,  0).to_i))
Repo.insert(Run.new(nerf,             spyro3,   12, Time::Span.new( 4, 20,  0).to_i))
Repo.insert(Run.new(conklesToTheMax,  galaxy2,  13, Time::Span.new(14, 30,  0).to_i))


# Y'all Just Got B E A N E D
Repo.insert(Run.new(spikeVegeta,      sm64,      1, Time::Span.new( 2, 15,  0).to_i))
Repo.insert(Run.new(martyrrSenpai,    spyro1,    2, Time::Span.new( 1, 50,  0).to_i))
Repo.insert(Run.new(obiyo,            dk64,      3, Time::Span.new( 6, 30,  0).to_i))
Repo.insert(Run.new(sniperKing,       sunshine,  4, Time::Span.new( 4,  0,  0).to_i))
Repo.insert(Run.new(five_mon,         spyro3,    5, Time::Span.new( 7,  0,  0).to_i))
Repo.insert(Run.new(theSludgyGamer,   galaxy2,   6, Time::Span.new(10,  0,  0).to_i))
Repo.insert(Run.new(dact,             crash1,    7, Time::Span.new( 1, 40,  0).to_i))
Repo.insert(Run.new(feranator115,     crash3,    8, Time::Span.new( 3, 30,  0).to_i))
Repo.insert(Run.new(spikeVegeta,      galaxy1,   9, Time::Span.new( 7, 15,  0).to_i))
Repo.insert(Run.new(kaptainKohl,      kazooie,  10, Time::Span.new( 2, 25,  0).to_i))
Repo.insert(Run.new(martyrrSenpai,    spyro2,   11, Time::Span.new( 2,  5,  0).to_i))
Repo.insert(Run.new(konditioner,      tooie,    12, Time::Span.new( 4, 35,  0).to_i))
Repo.insert(Run.new(dact,             crash2,   13, Time::Span.new( 1, 40,  0).to_i))


# Iateyourgrapes
Repo.insert(Run.new(whitePaaws,       spyro3,    1, Time::Span.new( 4,  0,  0).to_i))
Repo.insert(Run.new(nocturne_,        sunshine,  2, Time::Span.new( 3, 40,  0).to_i))
Repo.insert(Run.new(beuchi,           spyro1,    3, Time::Span.new( 2,  0,  0).to_i))
Repo.insert(Run.new(gdo,              tooie,     4, Time::Span.new( 4, 45,  0).to_i))
Repo.insert(Run.new(jag,              dk64,      5, Time::Span.new( 6, 40,  0).to_i))
Repo.insert(Run.new(nocturne_,        galaxy2,   6, Time::Span.new(10,  0,  0).to_i))
Repo.insert(Run.new(paracusia,        sm64,      7, Time::Span.new( 1, 55,  0).to_i))
Repo.insert(Run.new(beuchi,           spyro2,    8, Time::Span.new( 2, 10,  0).to_i))
Repo.insert(Run.new(spyro,            galaxy1,   9, Time::Span.new( 9,  0,  0).to_i))
Repo.insert(Run.new(robthegamer115,   crash3,   10, Time::Span.new( 4,  0,  0).to_i))
Repo.insert(Run.new(whitePaaws,       crash1,   11, Time::Span.new( 1, 25,  0).to_i))
Repo.insert(Run.new(robthegamer115,   crash2,   12, Time::Span.new( 2, 30,  0).to_i))
Repo.insert(Run.new(hagginater,       kazooie,  13, Time::Span.new( 2, 20,  0).to_i))


