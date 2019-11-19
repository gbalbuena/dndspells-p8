pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

black = 0
white = 7
yellow = 10

txty = 10

function _init()
  ux = {
    selected = 1,
    modal = false };
end

function _update()
  input()
end

function _draw()
  cls()
  background()

  -- render list
  selected_spell = {}
  for index, spell in pairs(spells.lvl1) do
    col = white
    if (ux.selected == index) then
      if (ux.modal) then
        selected_spell = spell
        col = 2
      else
        col = yellow
      end
    end
    print(spell.name, 10, 10 + (index * 6) - (ux.selected * 6), col)
  end

  -- render modal
  if (ux.modal) then
    x = 6
    y = 6
    
    if (btnp(0)) txty = txty + y
    if (btnp(1)) txty = txty - y
    modal(selected_spell, x, txty)
  end

  if (not ux.modal) then
    header("paladin spells - 5th edition")
    footer()
  end
end

function input()
  if (ux.selected >= 1) then
    if (btnp(2)) then 
      ux.selected = ux.selected - 1
    end
    if (btnp(3)) then
      ux.selected = ux.selected + 1
    end
    if (btnp(5)) then
      ux.modal = not ux.modal;
    end
    -- reset modal scroll
    if btnp(2) or btnp(3) or btnp(5) then
      txty = 6
    end
  end
  if (ux.selected == 0) ux.selected = 1
end

function background()
  rectfill(0, 0, 128, 128, black)
end

function modal(spell, x, y)
  rectfill(0, 0, 128, 128, black)
  
  print(spell.name, x, y, 8)

  print("level",      x, y + (6 * 2), 2)
  print(spell.level, 60, y + (6 * 2), 6)
  
  print("school",      x, y + (6 * 3), 2)
  print(spell.school, 60, y + (6 * 3), 6)
  
  print("casting time",      x, y + (6 * 4), 2)
  print(spell.casting_time, 60, y + (6 * 4), 6)

  print("range",      x, y + (6 * 5), 2)
  print(spell.range, 60, y + (6 * 5), 6)

  print("components",     x, y + (6 * 6), 2)
  print(spell.components, 60, y + (6 * 6), 6)

  print("duration",     x, y + (6 * 7), 2)
  print(spell.duration, 60, y + (6 * 7), 6)
  
  from = 1
  to = 28
  for i=0,(#spell.description / 28) do
    desc = sub(spell.description, from, to)
    print(desc, x, y + (6 * (8 + i + 1)), 6)
    from = from + 28
    to = to + 28
  end
end

function header(title)
  rectfill(0, 0, 128, 6, 1) -- top
  print(title, 1, 1, 8)
end

function footer()
  rectfill(0, 128, 128, 121, 1) -- bottom
  print("v1.0.0", 104, 122, 13)
end


-->8
spells = {
  lvl1 = {
{ name="bane", school="enchantment", level="1st-level", casting_time="1 action", range="30 feet", components="v, s, m", duration="up to 1 minute", description="up to three creatures of your choice that you can see within range must make charisma saving throws. whenever a target that fails this saving throw makes an attack roll or a saving throw before the spell ends, the target must roll a d4 and subtract the number rolled from the attack roll or saving throw." },
    { name="bless", school="enchantment", level="1st-level", casting_time="1 action", range="30 feet", components="v, s, m", duration="up to 1 minute", description="you bless up to three creatures of your choice within range. whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw." },
    { name="command", school="enchantment", level="1st-level", casting_time="1 action", range="60 feet", components="v", duration="1 round", description="you speak a one-word command to a creature you can see within range. the target must succeed on a wisdom saving throw or follow the command on its next turn. the spell has no effect if the target is undead, if it doesn't understand your language, or if your command is directly harmful to it. some typical commands and their effects follow. you might issue a command other than one described here. if you do so, the dm determines how the target behaves. if the target can't follow your command, the spell ends. .  **approach.** the target moves toward you by the shortest and most direct route, ending its turn if it moves within 5 feet of you.. . **drop** the target drops whatever it is holding and then ends its turn.. . **flee.** the target spends its turn moving away from you by the fastest available means.. . **grovel.** the target falls prone and then ends its turn.. . **halt.** the target doesn't move and takes no actions. a flying creature stays aloft, provided that it is able to do so. if it must move to stay aloft, it flies the minimum distance needed to remain in the air." },
    { name="cure wounds", school="evocation", level="1st-level", casting_time="1 action", range="touch", components="v, s", duration="instantaneous", description="a creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. this spell has no effect on undead or constructs." },
    { name="detect evil and good", school="divination", level="1st-level", casting_time="1 action", range="self", components="v, s", duration="up to 10 minutes", description="for the duration, you know if there is an aberration, celestial, elemental, fey, fiend, or undead within 30 feet of you, as well as where the creature is located. similarly, you know if there is a place or object within 30 feet of you that has been magically consecrated or desecrated. the spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt." },
    { name="detect magic", school="divination", level="1st-level", casting_time="1 action", range="self", components="v, s", duration="up to 10 minutes", description="for the duration, you sense the presence of magic within 30 feet of you. if you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any. the spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt." },
    { name="detect poison and disease", school="divination", level="1st-level", casting_time="1 action", range="self", components="v, s, m", duration="up to 10 minutes", description="for the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. you also identify the kind of poison, poisonous creature, or disease in each case. the spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt." },
    { name="divine favor", school="evocation", level="1st-level", casting_time="1 bonus action", range="self", components="v, s", duration="up to 1 minute", description="your prayer empowers you with divine radiance. until the spell ends, your weapon attacks deal an extra 1d4 radiant damage on a hit." },
    { name="hellish rebuke", school="evocation", level="1st-level", casting_time="1 reaction, which you take in response to being damaged by a creature within 60 feet of you that you can see", range="60 feet", components="v, s", duration="instantaneous", description="you point your finger, and the creature that damaged you is momentarily surrounded by hellish flames. the creature must make a dexterity saving throw. it takes 2d10 fire damage on a failed save, or half as much damage on a successful one." },
    { name="heroism", school="enchantment", level="1st-level", casting_time="1 action", range="touch", components="v, s", duration="up to 1 minute", description="a willing creature you touch is imbued with bravery. until the spell ends, the creature is immune to being frightened and gains temporary hit points equal to your spellcasting ability modifier at the start of each of its turns. when the spell ends, the target loses any remaining temporary hit points from this spell." },
    { name="hunter’s mark", school="divination", level="1st-level", casting_time="1 bonus action", range="90 feet", components="v", duration="up to 1 hour", description="you choose a creature you can see within range and mystically mark it as your quarry. until the spell ends, you deal an extra 1d6 damage to the target whenever you hit it with a weapon attack, and you have advantage on any wisdom (perception) or wisdom (survival) check you make to find it. if the target drops to 0 hit points before this spell ends, you can use a bonus action on a subsequent turn of yours to mark a new creature." },
    { name="protection from evil and good", school="abjuration", level="1st-level", casting_time="1 action", range="touch", components="v, s, m", duration="up to 10 minutes", description="until the spell ends, one willing creature you touch is protected against certain types of creatures: aberrations, celestials, elementals, fey, fiends, and undead. the protection grants several benefits. creatures of those types have disadvantage on attack rolls against the target. the target also can't be charmed, frightened, or possessed by them. if the target is already charmed, frightened, or possessed by such a creature, the target has advantage on any new saving throw against the relevant effect." },
    { name="purify food and drink", school="transmutation", level="1st-level", casting_time="1 action", range="10 feet", components="v, s", duration="instantaneous", description="all nonmagical food and drink within a 5-foot radius sphere centered on a point of your choice within range is purified and rendered free of poison and disease." },
    { name="sanctuary", school="abjuration", level="1st-level", casting_time="1 bonus action", range="30 feet", components="v, s, m", duration="1 minute", description="you ward a creature within range against attack. until the spell ends, any creature who targets the warded creature with an attack or a harmful spell must first make a wisdom saving throw. on a failed save, the creature must choose a new target or lose the attack or spell. this spell doesn't protect the warded creature from area effects, such as the explosion of a fireball. if the warded creature makes an attack or casts a spell that affects an enemy creature, this spell ends." },
    { name="shield of faith", school="abjuration", level="1st-level", casting_time="1 bonus action", range="60 feet", components="v, s, m", duration="up to 10 minutes", description="a shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to ac for the duration." },
    { name="speak with animals", school="divination", level="1st-level", casting_time="1 action", range="self", components="v, s", duration="10 minutes", description="you gain the ability to comprehend and verbally communicate with beasts for the duration. the knowledge and awareness of many beasts is limited by their intelligence, but at a minimum, beasts can give you information about nearby locations and monsters, including whatever they can perceive or have perceived within the past day. you might be able to persuade a beast to perform a small favor for you, at the dm's discretion." }
  }
}
