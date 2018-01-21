require 'rubygems'
require 'gosu'

class GameWindow < Gosu::Window

  def initialize
    super(640,480,false)
    self.caption = "Stars of Rage"
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @soundtrack = Gosu::Song.new(self,'sor.mp3')
    @wallhit = Gosu::Sample.new(self,'blip.wav')
    @player = Gosu::Image.new(self,'starfighter.bmp', false)
    @background = Gosu::Image.new(self,'max.jpg')
    @bgrepeat = Gosu::Image.new(self,'max.jpg')
    @x = 320 - @player.width/2
    @y = 340 - @player.height/2
    @b = -@background.height + 480
    @d = -@background.height * 2 + 480
    @true = false
  end
  
  def update
   if @d > 480
     @d = -@background.height
   end
   if @b > 480
    @b = -@background.height
   end    
  @b +=2
  @d +=2
  collision
  end

def collision
  if @x < 0
    @x +=1
    @wallhit.play
  elsif @x > (640 - @player.width)
    @x -=1
    @wallhit.play
  elsif @y < 0
    @y +=1
    @wallhit.play
  elsif @y > (480 - @player.height)
    @y -=1
    @wallhit.play
  else 
    @x -= 4 if button_down?(Gosu::KbLeft)
    @x += 4 if button_down?(Gosu::KbRight)
    @y -= 4 if button_down?(Gosu::KbUp)
    @y += 4 if button_down?(Gosu::KbDown)
  end
end


def draw
  start_game
end

def start_game
  @font.draw("Welcome to Stars of Rage!",210,140,0)
  @font.draw("Press space to start",230,160,0)
  if button_down?(Gosu::KbSpace)
    @true = true 
  end
  if @true == true
    main
  end
end

def main
  @player.draw(@x, @y,1)
  @background.draw(0,@b,0)
  @bgrepeat.draw(0,@d,0)
  @soundtrack.play(true)
end

def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end

end

window = GameWindow.new
window.show