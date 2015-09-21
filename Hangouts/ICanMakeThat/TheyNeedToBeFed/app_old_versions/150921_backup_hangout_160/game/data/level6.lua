-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015 
-- =============================================================
-- 
-- =============================================================
-- B - Start/Begin
-- S - Square Platform
-- R - Round Platform
-- I - Charles Invisible Platform
-- T - Timed Round Platform (disappears after 3 seconds)

-- J - Laser Turret (Basic)
-- K - Laser Turret (Rotating)
-- L - Rocket Turret 

-- X - Spikes

-- C - Coin
-- M - Monster

local level = {}
level.platforms = 
{
	"___", "R_1", "L_2", "___", "L_3", "___", "___", "___",
	"___", "I_1", "R_1", "R_1", "R_1", "___", "___", "___",
	"___", "B_1", "___", "R_1", "L_4", "I_1", "___", "___",
	"___", "I_1", "K_3", "R_1", "K_4", "___", "___", "___",
	"___", "J_3", "R_1", "J_7", "___", "___", "___", "___",
	"___", "R_1", "R_1", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
}

level.dangers = 
{
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
}

level.other = 
{
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "C_4", "C_3", "C_1", "C_3", "___", "___",
	"___", "___", "C_3", "___", "___", "M_2", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "C_1", "___", "___", "___", "___", "___",
	"___", "C_1", "C_2", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
}

return level