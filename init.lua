


mobs:register_mob("scifi_mobs:xenomorph", {
	type = "monster",
	passive = false,
	reach = 4,
	damage = 4,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 30,
   shoot_interval = 1.5,
   arrow = "scifi_mobs:rlaser",
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

mobs:register_spawn("scifi_mobs:xenomorph", {"default:steelblock","default:stone"}, 20, 10, 15000, 2, 31000)

mobs:register_egg("scifi_mobs:xenomorph", "xenomorph", "scifi_spider_inv.png", 0)


mobs:register_arrow("scifi_mobs:rlaser", {
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

