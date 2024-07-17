require 'ruby2d'

set background: 'white', width: 640, height: 640

SPRITE_SCALE = 4
TILE_SIZE = 16
CAT_SPRITE_SIZE = 48
CAT_SPEED = 2

def cat_sprite_box(row, column)
  {
    x: (column - 1) * CAT_SPRITE_SIZE,
    y: (row - 1) * CAT_SPRITE_SIZE,
    width: CAT_SPRITE_SIZE,
    height: CAT_SPRITE_SIZE,
    time: 100
  }
end

def cat_row_animation(row)
  [
    cat_sprite_box(row, 1),
    cat_sprite_box(row, 2),
    cat_sprite_box(row, 3),
    cat_sprite_box(row, 4),
    cat_sprite_box(row, 5),
    cat_sprite_box(row, 6),
    cat_sprite_box(row, 7),
    cat_sprite_box(row, 8)
  ]
end

cat = Sprite.new(
  'sprites/Characters/Premium Charakter Spritesheet.png',
  width: CAT_SPRITE_SIZE * SPRITE_SCALE,
  height: CAT_SPRITE_SIZE * SPRITE_SCALE,
  animations: {
    walk_forward: cat_row_animation(5),
    walk_back: cat_row_animation(6),
    walk_right: cat_row_animation(7),
    walk_left: cat_row_animation(8)
  }
)

tree = Sprite.new(
  'sprites/Objects/Tree animations/tree_sprites.png',

)

grass_tileset = Tileset.new(
  'sprites/Tilesets/ground tiles/New tiles/Grass_tiles_v2.png',
  tile_width: TILE_SIZE,
  tile_height: TILE_SIZE,
  scale: SPRITE_SCALE,
  z: -1
)

def tile_coord(row, col)
  {
    x: ((col - 1) * TILE_SIZE * SPRITE_SCALE),
    y: ((row - 1) * TILE_SIZE * SPRITE_SCALE)
  }
end

def tile_field(rows, cols)
  coords = rows.to_a.map do |row|
    cols.to_a.map do |col|
      tile_coord(row, col)
    end
  end

  coords.flatten
end

grass_tileset.define_tile('top_left', 0, 0)
grass_tileset.define_tile('top_middle', 1, 0)
grass_tileset.define_tile('top_right', 2, 0)
grass_tileset.define_tile('middle_left', 0, 1)
grass_tileset.define_tile('middle_middle', 1, 1)
grass_tileset.define_tile('middle_right', 2, 1)
grass_tileset.define_tile('bottom_left', 0, 2)
grass_tileset.define_tile('bottom_middle', 1, 2)
grass_tileset.define_tile('bottom_right', 2, 2)

grass_tileset.set_tile('top_left', [
  tile_coord(1, 1)
])

grass_tileset.set_tile('top_middle', tile_field((1..1), (2..9)))

grass_tileset.set_tile('top_right', [
  tile_coord(1, 10)
])

grass_tileset.set_tile('middle_left', tile_field((2..6), (1..1)))

grass_tileset.set_tile('middle_middle', tile_field((2..6), (2..9)))

grass_tileset.set_tile('middle_right', tile_field((2..9), (10..10)))

grass_tileset.set_tile('bottom_left', [
  tile_coord(7, 1)
])

grass_tileset.set_tile('bottom_middle', tile_field((7..7), (2..4)))
grass_tileset.set_tile('bottom_middle', tile_field((10..10), (2..9)))

grass_tileset.set_tile('bottom_right', [
  tile_coord(10, 10)
])

cat.play animation: :walk_forward

on :key_held do |event|
  case event.key
    when 'left'
      cat.play animation: :walk_left

      if (cat.x > -CAT_SPRITE_SIZE)
        cat.x = cat.x - CAT_SPEED
      end
    when 'right'
      cat.play animation: :walk_right

      if (cat.x < (Window.width - (3 * CAT_SPRITE_SIZE)))
        cat.x = cat.x + CAT_SPEED
      end
    when 'up'
      cat.play animation: :walk_back

      if (cat.y > -CAT_SPRITE_SIZE)
        cat.y = cat.y - CAT_SPEED
      end
    when 'down'
      cat.play animation: :walk_forward

      if (cat.y < (Window.height - (3 * CAT_SPRITE_SIZE)))
        cat.y = cat.y + CAT_SPEED
      end
  end
end

show