class Window
  include FFI::NCurses

  def initialize(server)
    @server = server
    initscr
    curs_set 0
    @win = newwin(42, 122, 0, 0)
    box(@win, 0, 0)
    @inner_win = newwin(40, 120, 1, 1)
    nodelay(@inner_win, 1)
    curs_set 0
  end
   
  def show
    begin
      ch = 1 
      while ch != 27
        box(@win, 0, 0)
        wrefresh(@win)
        wrefresh(@inner_win)
        ch = wgetch(@inner_win)
        wclear(@inner_win)
        #box(win, 0, 0)
        name = keyname(ch)
        redraw
        sleep 0.2
      end
    rescue Object => e
      endwin
      puts e
    ensure
      endwin
    end
  end

  ICONS = {
    "homo sapien" => lambda { "@" },
    "dirt" => lambda { ["."," ","_"][rand(3)] }
  }

  def redraw
    #string = "name: %s dec: %d char: [%c]" % [name, ch, ch]
    @user = @server.new_session
    display_string = ""
    display_string = @user.map.grid.map do |row| 
      row.map do |thing| 
        if 
        ICONS[thing].call
      end.join 
    end.join("\n")
    @old_display = [[]] * 20
    @old_grid = @user.map.grid
    waddstr(@inner_win, display_string)
    #addstr "Press any key (Escape to exit): "
    #printw "name: %s dec: %d char: [%c]", :string, name, :int, ch, :int, ch
  end
end
