mobs:register_mob("mobs_xenomorph:xenomorph", {
	type = "monster",
	passive = false,
	reach = 4,
	damage = 4,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 12,
	dogshoot_count2_max = 3,
	hp_min = 12,
	hp_max = 22,
	armor = 30,
	follow = {"default:mese"},
	shoot_interval = 1.5,
	arrow = "mobs_xenomorph:rlaser",
	shoot_offset = 1,
	collisionbox = {-1, -0, -1, 1, 2, 1},
	visual = "mesh",
	mesh = "xenomorph.b3d",
	textures = {
		{"scifi_xenomorph.png"},
	},
	sounds = {
		random = "mobs_dungeonmaster",
		shoot_attack = "mobs_fireball",
	},
	visual_size = {x=3, y=3},
	makes_footstep_sound = false,
	walk_velocity = 2,
	run_velocity = 5,
	fly = true,
	drops = {
		{name = "default:mese", chance = 10, min = 1, max = 1}
	},
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
	do_custom = function(self, dtime)
		if not self.v2 then
			self.v2 = 0
			self.max_speed_forward = 6
			self.max_speed_reverse = 2
			self.accel = 6
			self.terrain_type = 3
			self.driver_attach_at = {x = 0, y = 5, z = -1}
			self.driver_eye_offset = {x = 0, y = 18, z = 0}
		end
		if self.driver then
			mobs.drive(self, "walk", "stand", true, dtime)
			return false
		end
		return true
	end,
	on_die = function(self, pos)
		if self.driver then
			minetest.add_item(pos, "mobs:saddle")
			mobs.detach(self.driver, {x = 1, y = 0, z = 1})
			self.saddle = nil
		end
	end,
	on_rightclick = function(self, clicker)
		if not clicker or not clicker:is_player() then
			return
		end
		if mobs:feed_tame(self, clicker, 30, false, true) then
			if self.tamed then
				self.attack_monsters = true
				self.attack_npcs = false
				self.attack_players = false
				self.fall_damage = 0
				self.fly = false
				self.type = "animal"
			end
			return
		end
		if mobs:protect(self, clicker) then
			return
		end
		if self.tamed and clicker:get_player_name() == self.owner then
			local inv = clicker:get_inventory()
			if self.driver and self.driver == clicker then
				mobs.detach(clicker, {x = 1, y = 0, z = 1})
				if inv:room_for_item("main", "mobs:saddle") then
					inv:add_item("main", "mobs:saddle")
				else
					minetest.add_item(clicker:get_pos(), "mobs:saddle")
				end
				self.saddle = nil
			elseif self.saddle or (not self.driver
			and clicker:get_wielded_item():get_name() == "mobs:saddle") then
				self.object:set_properties({stepheight = 1.1})
				mobs.attach(self, clicker)
				if not self.saddle then
					inv:remove_item("main", "mobs:saddle")
					self.saddle = true
				end
			end
		end
		mobs:capture_mob(self, clicker, 0, 0, 70, false)
	end,
	do_punch = function(self, hitter)
		if self.driver and hitter == self.driver then
			return false
		end
	end
})


-- mobs:register_spawn("mobs_xenomorph:xenomorph", {"default:ice"}, 20, 10, 9000, 1, 31000)
-- name, nodes, max_light, min_light, chance, active_object_count, max_height, day_toggle

mobs:spawn({
	name = "mobs_xenomorph:xenomorph",
	nodes = {
		"default:stone_with_mese",
		"default:stone_with_iron",
		"default:mese",
		"default:stone_with_diamond",
		"default:stone_with_copper"
	},
	neighbors = {"vacuum:vacuum", "air"},
	chance = 2000,
	interval = 20,
	active_object_count = 1,
	min_height = 5000,
	max_height = 10000,
})

mobs:register_egg("mobs_xenomorph:xenomorph", "xenomorph", "fire_basic_flame.png", 0)

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
