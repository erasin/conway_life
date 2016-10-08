require("util")

-- Life = {}
Life = class()

function Life:init(m,n)
	local matrix = {}
	for i = 0, m do
		local row = {}
		for j = 0, n do
			row[j] = 0
		end
		matrix[i] = row
	end

	self.matrix = matrix
	self.m = m 
	self.n = n

	-- local o = o or {}
	-- setmetatable(o,self)
	-- self.__index = self
	-- return o

end

function Life:live(x,y)
	self.matrix[x][y] = 1
end

function Life:die(x,y)
	self.matrix[x][y] = 0
end

-- 下一周期更新
function Life:next_gen()
	local X = deepCopy(self.matrix)
	local matrix = self.matrix
	for i = 0, self.m do 
		for j = 0, self.n do 
			local s = 0 

			for q = i-1,i+1 do 
				for p = j-1, j+1 do 
					if p > 0 and p < self.m and q > 0 and q < self.n then 
						s = s + matrix[q][p]
					end
				end
			end

			s = s - self.matrix[i][j]

			-- 周围为 3 或者 为 2 的时候活
			if s == 3 or (s + matrix[i][j]) == 3 then 
				X[i][j] = 1
			else
				X[i][j] = 0
			end 

		end
	end

	self.matrix = deepCopy(X)
end
