local spawn = require('awful.spawn')
local app = require('configuration.apps').default.quake

local quake_id = 'notnil'
local quake_client
local opened = false
function create_shell()
  quake_id =
    spawn(
    app,
    {
      skip_decoration = true
    }
  )
end

function open_quake()
  quake_client.hidden = false
end

function close_quake()
  quake_client.hidden = true
end

toggle_quake = function()
  opened = not opened
  if not quake_client then
    create_shell()
  else
    if opened then
      open_quake()
    else
      close_quake()
    end
  end
end

_G.client.connect_signal(
  'manage',
  function(c)
    if (c.pid == quake_id) then
      quake_client = c
      c.opacity = 0.9
      c.floating = true
      c.skip_taskbar = true
      c.ontop = true
      c.above = true
      c.sticky = true
      c.hidden = not opened
      c.maximized_horizontal = true
    end
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if (c.pid == quake_id) then
      opened = false
      quake_client = nil
    end
  end
)

-- create_shell()
