-- claude_mcp.lua
-- Integration with Claude Desktop via MCP protocol

local M = {}

-- Configuration options with defaults
M.config = {
  socket_path = os.getenv("HOME") .. "/.config/claude/mcp.sock",
  timeout = 5000, -- milliseconds
  debug = false
}

-- Initialize the module with user config
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Register commands
  vim.api.nvim_create_user_command("ClaudeChat", function(args)
    M.start_claude_session(args.args)
  end, { nargs = "?", desc = "Start Claude chat with optional prompt" })

  vim.api.nvim_create_user_command("ClaudeProject", function()
    M.start_project_session()
  end, { desc = "Start Claude chat about current project" })
end

-- Connect to MCP socket
function M.connect_to_mcp()
  local socket = vim.loop.new_pipe(false)
  local connected = false

  -- Attempt to connect
  local ok, err = pcall(function()
    socket:connect(M.config.socket_path)
    connected = true
  end)

  if not ok or not connected then
    if M.config.debug then
      vim.notify("Failed to connect to Claude MCP: " .. (err or "unknown error"), vim.log.levels.ERROR)
    end
    return nil
  end

  return socket
end

-- Send a request to MCP
function M.send_mcp_request(method, params)
  local socket = M.connect_to_mcp()
  if not socket then
    vim.notify("Couldn't connect to Claude MCP socket. Is Claude running?", vim.log.levels.ERROR)
    return nil
  end

  -- Generate a request ID
  local request_id = math.floor(math.random() * 10000)

  -- Build the JSON-RPC request
  local request = {
    jsonrpc = "2.0",
    id = request_id,
    method = method,
    params = params or {}
  }

  local json_request = vim.json.encode(request)

  if M.config.debug then
    vim.notify("Sending request: " .. json_request, vim.log.levels.DEBUG)
  end

  -- Send the request
  socket:write(json_request .. "\n")

  -- For simplicity, we're not handling responses in this basic implementation
  -- In a more advanced implementation, you'd read the response

  -- Close the socket
  socket:close()

  return request_id
end

-- Start a new Claude chat session with the given prompt
function M.start_claude_session(prompt)
  prompt = prompt or "How can I help you with your code today?"

  -- Use the proper MCP method to start a new session
  M.send_mcp_request("sessions/create", {
    prompt = prompt
  })

  vim.notify("Started new Claude chat session", vim.log.levels.INFO)
end

-- Start a session focused on the current project
function M.start_project_session()
  -- Get the current project directory (assumes git project)
  local ok, project_dir = pcall(function()
    return vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  end)

  if not ok or project_dir == "" then
    vim.notify("Not in a git repository. Using current working directory.", vim.log.levels.WARN)
    project_dir = vim.fn.getcwd()
  end

  -- Get current file path relative to project
  local current_file = vim.fn.expand("%:p")
  local relative_path = vim.fn.fnamemodify(current_file, ":.")

  -- Build a prompt that references the project
  local prompt = string.format(
    "I'm working on a project located at %s. " ..
    "I'm currently looking at file %s. " ..
    "Help me understand and work with this codebase.",
    project_dir,
    relative_path
  )

  M.start_claude_session(prompt)
end

return M
