local M = {}

local api = require('nvim-tree.api')

local function expand_all(node)
  print("Node being processed:", vim.inspect(node))
  if node.type == "directory" and not node.open then
    print("Opening directory:", node.name)
    api.node.open.edit(node)
  end

  node = api.tree.get_node_at_cursor()

  for _, child in ipairs(node.nodes or {}) do
    expand_all(child)
  end
end

function M.expand_tree()
  local tree = api.tree.get_nodes()
  if tree then
    for _, node in ipairs(tree.nodes) do
      expand_all(node)
    end
  end
end

return M

