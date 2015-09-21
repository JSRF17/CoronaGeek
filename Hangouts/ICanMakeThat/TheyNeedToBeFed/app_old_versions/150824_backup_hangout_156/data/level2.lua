-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015 
-- =============================================================
-- 
-- =============================================================
-- B - Start/Begin
-- S - Square Platform
-- R - Round Platform

-- X - Spikes

-- C - Coin
-- M - Monster

local level = {}
level.platforms = 
{
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "R_1", "___", "___", "___",
	"___", "___", "___", "___", "R_1", "___", "___", "___",
	"___", "___", "S_1", "B_1", "R_1", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
}

level.dangers = 
{
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "X_1", "___", "___", "___",
	"___", "___", "___", "___", "X_4", "___", "___", "___",
	"___", "___", "X_3", "X_3", "X_2", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
}

level.other = 
{
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "M_4", "___", "___", "___",
	"___", "___", "___", "___", "C_3", "___", "___", "___",
	"___", "___", "C_2", "C_1", "C_2", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
	"___", "___", "___", "___", "___", "___", "___", "___",
}

return level