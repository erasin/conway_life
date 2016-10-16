local map =  {
	gun = {3,3,3,4,3,5,2,5,1,4}
	,block = {7,1,7,2,8,1,8,2}
	,boat = {12,2,13,2,13,3,11,3,12,4}
	,beehive = {17,2,18,2,19,3,16,3,17,4,18,4}
	,loaf = {24,1,25,1,25,1,23,2,24,3,25,4,26,2,26,3 }
}

function test()
    for title,ps in pairs(map) do
        local x,y = 0,0
        print(title)
        for i,p in pairs(ps) do
            if i%2 == 0 then
                y = p
                print(x,y)
            else	
                x = p
            end
        end
    end
end

return map
