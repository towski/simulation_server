class Window
  include FFI::NCurses

  def initialize(server)
    @server = server
    initscr
    curs_set 0
    raw
    keypad stdscr, 1
    noecho
    @win = newwin(42, 124, 0, 0)
    box(@win, 0, 0)
    @inner_win = newwin(40, 122, 1, 1)
    @right_win = newwin(20, 20, 1, 45)
    nodelay(@inner_win, 1)
    curs_set 0
  end
   
  def show
    begin
      ch = 1 
      while ch != 27
        @user = @server.new_session
        box(@win, 0, 0)
        wrefresh(@win)
        wrefresh(@inner_win)
        ch = wgetch(@inner_win)#.to_i#(@inner_win)
        wclear(@inner_win)
        #box(win, 0, 0)
        name = keyname(ch)
        case name
          when "w": @user.y -= 1 unless @user.y <= 1;
          when "s": @user.y += 1;
          when "a": @user.x -= 1 unless @user.x <= 1;
          when "d": @user.x += 1;
        end
        @user.save if @user.changed?
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
    "homo sapien" => "@",
    "dirt" => ".", 
    nil    => " "
  }

  def redraw
    #string = "name: %s dec: %d char: [%c]" % [name, ch, ch]
    display_string = ""
    display_string = @user.map.grid.map do |row| 
      row.map do |thing| 
        ICONS[thing]
      end.join 
    end.join("\n")
    waddstr(@inner_win, display_string)
    #addstr "Press any key (Escape to exit): "
    #printw "name: %s dec: %d char: [%c]", :string, name, :int, ch, :int, ch
  end
end
