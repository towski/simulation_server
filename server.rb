require 'main'
URI="druby://localhost:8787"

class Server
  def new_session
    @user ||= User.first
  end

  def new_terrain
    Terrain.new
  end
end

$SAFE = 0   # disable eval() and friends

DRb.start_service(URI, Server.new)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join
