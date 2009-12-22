require 'main'

class Server
  def new_session
    @user ||= User.first
  end

  def new_terrain
    Terrain.new
  end
end

$SAFE = 0   # disable eval() and friends

DRb.start_service("druby://localhost:8787", Server.new)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join
