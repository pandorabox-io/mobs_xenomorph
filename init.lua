


mobs:register_mob("mobs_xenomorph:xenomorph", {
	type = "monster",
	passive = false,
	reach = 4,
	damage = 4,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 30,
   shoot_interval = 1.5,
   arrow = "mobs_xenomorph:rlaser",
   shoot_offset = 1,
	collisionbox = {-1, -0, -1, 1, 2, 1},
	visual = "mesh",
	mesh = "xenomorph.b3d",
	textures = {
		{"scifi_xenomorph.png"},
	},
	visual_size = {x=3, y=3},
	makes_footstep_sound = false,
	walk_velocity = 2,
	run_velocity = 5,
        -- fly = true, TODO: test
        -- fly_in = "default:water_source",
        -- fall_speed = 0,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 25,
		walk_start = 2,
		walk_end = 27,
		stand_start = 59,
		stand_end = 73,
		run_start = 2,
		run_end = 27,
		punch_start = 30,
		punch_end = 59,

	},
})


-- mobs:register_spawn("mobs_xenomorph:xenomorph", {"default:ice"}, 20, 10, 9000, 1, 31000)
-- name, nodes, max_light, min_light, chance, active_object_count, max_height, day_toggle

mobs:spawn({
        name = "mobs_xenomorph:xenomorph",
        nodes = {"default:stone_with_mese"},
        min_light = 0,
        max_light = 14,
        chance = 7000,
        active_object_count = 1,
        min_height = 5000,
        max_height = 10000,
})


mobs:register_egg("mobs_xenomorph:xenomorph", "xenomorph", "scifi_spider_inv.png", 0)


mobs:register_arrow("mobs_xenomorph:rlaser", {
   visual = "sprite",
   visual_size = {x = 0.5, y = 0.5},
   textures = {"scifi_mobs_rlaser.png"},
   velocity = 18,
   tail = 1, -- enable tail
   tail_texture = "scifi_mobs_rlaser.png",

   hit_player = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 8},
      }, nil)
   end,
   
   hit_mob = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 8},
      }, nil)
   end,

   hit_node = function(self, pos, node)
      mobs:explosion(pos, 1, 1, 1)
   end,
})

