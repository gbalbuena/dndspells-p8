pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

spells_list = {
}

spells_detail = {
}

function _update()
  main_screen.update()
end

function _draw()
  cls(7)
  for i = 0, 130, 10 do
    line(0, 1 * i, 128, 1 * i, 1)
    line(1 * i, 128, 1 * i, 0, 1)
  end
  
  main_screen.draw()
end





-->8
function main_screen_update()
  if (btnp(2)) main_screen.selected = main_screen.selected - 1
  if (btnp(3)) main_screen.selected = main_screen.selected + 1
end

function main_screen_draw()
  classes={
    "barbarian","bard","cleric","druid",
    "fighter","monk","paladin","ranger",
    "rogue","sorcerer","warlock","wizard"}
  col = 6
  for i, class in pairs(classes) do
    print(class, 0, 10 * i, col)
    if (main_screen.selected == i) then
      print(class, 1, (10 * i) + 1, 5)  
    end
  end
end

main_screen = {
  selected = 1,
  update = main_screen_update,
  draw = main_screen_draw
}
