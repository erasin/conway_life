

--- Creates a class using shallow copy.
-- An instance of the class can be created by calling the class as a
-- function.
-- The class' <code>__super</code> key refers to its parent class, if
-- any.
-- The <code>init</code> function can be overridden to initialize
-- instances of the class; Arguments provided when the class is called
-- is passed to this <code>init</code> function.
-- @param parent [optional] The parent class to subclass from.
-- @return The newly created class.
function class(parent)
  parent = parent or {init=function() end}
  local new = {init=function() end}

  -- A child class is a shallow copy of its parent class.
  if type(parent) == "table" then
    for k, v in pairs(parent) do
      new[k] = v
    end
    new.__super = parent
  end

  -- Each class is the metatable of all of its instances.
  new.__index = new

  return setmetatable(new, {__call = function(t , ...)
    local instance=setmetatable({}, new);
    new.init(instance, ...)
    instance.__class = new
    return instance
  end})
end

-- table copy
function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end