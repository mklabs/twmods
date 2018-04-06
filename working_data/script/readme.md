# Beastmen Children of Chaos

Beta.

This mod implements a new Beastmen faction for the Mortal Empires campaign: the
Children of Chaos.

> And in that time of darkness,
> Man became Beast,
> And Beast became Man

Headed by either Taurox or Ghorros Warhoof, lead the ruthless herds of Beastmen
from deep within the twisted forested woodlands of Talabecland or Naggaroth in
their path to destruction of Mankind.

*Note*: It is still in development and has some rough edges (comestic mostly),
and features I'd like to implement but I feel like it is almost ready for me to
publish and get some early feedbacks.

# Features

- 2 new legendary lords: Taurox, the Brass Bull and Ghorros, Sire of a Thousand Young.
- 2 new starting position: Talabeclan's Great Forest or in Karond Kar.
- Custom faction and lord traits
- Additionnal quest battles for legendary items and campaign final battles.
- Custom victory conditions for the faction and chapter objectives for both lords.
- While being a different faction than the main Beastmen faction, you are still
  able to recruit Khazrak, Malagor or Morghur using the same unlock conditions
  (and I believe you can still confederate them).

# Legendary lords

*Taurox*

Known as the Brass Bull, Taurox is a monstrous engine of destruction,
formed of living brass in the shape of a terrible Doombull, dedicated solely to
the spilling of blood in Khorne's name.

He comes with strong faction/lord traits and character skills for Minotaur
units. Think of him as a Gorebull on steroids.

*Ghorros Warhoof*

Ghorros Warhoof, Sire of a Thousand Young, is a gnarled, ancient Centigor who
is forever fighting, rutting or getting drunk. His unnaturally long life has
spanned many centuries and he has slaughtered his way through countless wars
without succumbing to his injuries.

Ghorros is tailored after Kholek and should feel similar on the battlefield,
while still being a Centigor with Great Weapon. His traits and character skills
should lead to a bunch of Centigor flavor armies.

# Faction & Lord traits

*Taurox*

- Hero capacity: +1 for Gorebulls
- Unit experience: +2 for Minotaurs
- Upkeep: -35% for Minotaur units (Lord's army)
- Recruitment cost: -50% for Minotaur units (Lord's army)

*Ghorros Warhoof*

- Campaign movement range: +10%
- Upkeep: -25% for Centigor units
- Unit experience: +2 for Centigor units
- Recruitment cost: -50% for Centigor units (Lord's army)
- Horde growth: +4 (Lord's army)

# Starting positions

Taurox, starts in the heart of Talabeclan's great forest. The early game will
consist around fighting the faction of Talabecland, followed by all the
remaining Empire factions. It should feel somewhat similar to Morghur while
still feeling fresh and unique (more so if I manage to implement the scenario
and quest battles I have in mind). Mid and late game will most likely be more
diverse, especially when aiming for the long campaign victory.

Ghorros, starts near Clan Rictus and Naggaroth, in the forest of Karond Kar. It
should imply a very new and refreshing starting experience for Beastmen, being
situated outside of the Old World. It also should feel a little bit more
challenging, as your early ennemies will most likely be Naggaroth and Clan
Rictus.

# Custom quest battles (todo)

- Another final quest battle following the Fall of Man, this time featuring
  the destruction of the Oak of Ages.
- 4 legendary items quest battles, 2 for Taurox, 2 for Ghorros.

# Custom victory conditions

- Short campaign:
  - Usual victory conditions for Beastmen
  - Destroy the Wood Elves in addition to the Empire and Bretonnia.
- Long campaign:
  - Usual victory conditions for Beastmen
  - Destroy all major factions.

# Custom chapter objectives:

- Both Ghorros and Taurox have different chapter objectives, designed to
  follow their expected route in the campaign, depending on their starting
  position and victory conditions.

# Todo

- Finish up the skill tree for Taurox and Ghorros
  - Implement all for rank7 skill for beastmen
  - Implement unique skill for Taurox and Ghorros

* Add proper victory condition
  - Destroy 5/10 of the following factions: (see how to implement)
    - Empire
    - Kisvlev
    - Bretonia
    - Dwarf
    - Grenskins
    - Vampire Counts / Von Carstein
    - Vargs / Skaelings
    - Wood elf
    - Naggarond / Cult of Pleasrue
    - Clan Rictus / Clan Mors / Clan Pestilens
    - Hexoatl / Last Defenders
    - Lothern / Order of Loremaster

- Implement chapter objectives for Taurox / Ghorros
  - Would be nice to have it configurable through dilemna at the start, change
    chapter objectives accordingly.
  - Another way of doing so would be to change the next chapter, based on the
    player army position and region when the chapter has been completed.

- Rework mesh definitions and models for Taurox / Ghorros
  - Taurox: Gorebull / Doombull as a base (currently looking like a regular gorebull)
  - Ghorros: Kholek / Centigor GW as a base (currently using Kholek models)

- Implement legendary items for Taurox / Ghorros
  - Taurox: Rune tortured axes / Brass Armour
  - Ghorros: Mansmasher (Great spiked club, magic weapoing) / Talisman (magic resistance)

- Implement quest battles
  - Taurox: 2 qb for items
  - Ghorros: 2 qb for items
  - Final / chapter objectives:
    - the fall of man
    - Oak of Ages
    - Siege of Talabecland
    - Siege of Middenheim
    - ...
    - Implement basic quest battle for Taurox
      - Hook it up in campaign
    - Implement Taurox rune-tortured axes
      - Add it as anciliary for quest battle
