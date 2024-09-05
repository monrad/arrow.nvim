local M = {}

function M.cwd()
  return vim.loop.cwd()
end

function M.git_root()
  local git_worktree = vim.fn.system "git rev-parse --is-inside-work-tree 2>&1"
  local git_root

  if git_worktree then
    git_root = vim.fn.system "git rev-parse --path-format=absolute --git-common-dir 2>&1"
  else
    git_root = vim.fn.system "git rev-parse --show-toplevel 2>&1"
  end

  if vim.v.shell_error == 0 then
    return git_root:gsub("\n$", "")
  end

  return M.cwd()
end

return M
