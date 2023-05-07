local M = {}
function M.erl_version()
  local handle = io.popen("erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell")
  if not handle then return 0 end
  local output = handle:read('*a')
  local v = output:gsub('[\n\r"]', '')
  local version = tonumber(v)
  if not version then return 0 end
  return version
end

function M.elixir_ls_usable()
  local handle = io.popen("elixir --short-version")
  if not handle then return false end
  local output = handle:read('*a')
  local v = output:gsub('[\n\r]', '')
  local major, minor, _ = string.match(v, "(%d+)%.(%d+)%.(%d+)")
  major = tonumber(major)
  minor = tonumber(minor)
  return major and major >= 1 and minor >= 12
end

return M
