local Command = {}

Command.type = 0 -- 1 表示 Position, 2 表示 敌人, 3 表示 友军
Command.target = nil -- 可能是 Position 或者 player
