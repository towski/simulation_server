require 'drb/drb'
require 'rubygems'
require 'ruby-debug'
require 'ffi-ncurses'
require 'window'

# The URI to connect to
SERVER_URI="druby://localhost:8787"

# Start a local DRbServer to handle callbacks.
#
# Not necessary for this small example, but will be required
# as soon as we pass a non-marshallable object as an argument
# to a dRuby call.
#DRb.start_service

server = DRbObject.new_with_uri(SERVER_URI)
Window.new(server).show
