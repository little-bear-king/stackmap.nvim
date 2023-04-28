# This file is for testing and uses plugins and functions from Plenary.nvim made my TJ DeVries. My Current key mapping for running the tester is <leader>t
local find_map = function(maps, lhs)
  for _, map in ipairs(maps) do
    if map.lhs == lhs then
      return map
    end
  end
end

describe("stackmap", function ()
  it("can be required", function ()
    require("stackmap")
  end)

  it("can push a single mapping", function ()
    local rhs = "echo 'This is a test'"
    require"stackmap".push("test1", "n", {
      asdfasdf = rhs,
    })

    local maps = vim.api.nvim_get_keymap("n")
    local found = find_map(maps, "asdfasdf")
    assert.are.same(rhs, found.rhs)
  end)
  it("can push multiple mappings", function()
    local rhs = "echo 'This is a test'"
    require"stackmap".push("test1", "n", {
      ["asdf_1"] = rhs .. "1",
      ["asdf_2"] = rhs .. "2",
    })
    local maps = vim.api.nvim_get_keymap("n")
    local found_1 = find_map(maps, "asdf_1")
    assert.are.same(rhs .. "1", found_1.rhs)
    
    local found_2 = find_map(maps, "asdf_2")
    assert.are.same(rhs .. "2", found_2.rhs)
    -- TODO: keep watching the Bash to basics video on youtube showing how to write a lua plugin for nvim
  end)
end)
