--you can think of a lua module like one large function that sends a return at the end

local M = {}

-- M.setup= function()
--   print("Options:", opts)
-- end
-- functions we need:
-- - vim.keymap.set(...) -> create new keymaps
-- - nvim_get_keymap
-- vim.api would be helpful here
-- vim.api.nvim_get_keymap 

local find_mapping = function (maps, lhs)
  -- pairs
  -- iterates over every key in a table
  -- order not garenteed  
  -- ipairs
  -- in terate only over numeric keys in a table
  -- order IS garenteed
  for _, value in ipairs(maps) do -- since we are working with an array of values we want to use ipairs 
   if value.lhs == lhs then
    return value
   end
  end
end

M._stack = {}


M.push = function (name, mode, mappings)
  local maps = vim.api.nvim_get_keymap(mode)

  local existing_maps = {}
  for lhs, rhs in pairs(mappings) do
    local existing = find_mapping(maps, lhs)
    if existing then
     table.insert(existing_maps, existing)
    end
  end

  M._stack[name] = existing_maps

  for lhs, rhs in pairs(mappings) do
    -- TODO: need some way to pass options in here
    vim.keymap.set(mode, lhs, rhs)
  end
end

M.pop = function (name)
end

M.push("debug_mode", "n",  {
  [" st"] =  "echo 'Hello'",
  [" sz"] =  "echo 'Goodbye'",}
)
--[[
lua require("mapstack").push("debug_mode", "n",  {
  ["<leader>st"] =  "echo 'Hello'",
  ["<leader>sz"] =  "echo 'Goodbye'",
})
--]]


--[[
lua require("mapstack").pop("debug_mode", {
})
--]]


return M
