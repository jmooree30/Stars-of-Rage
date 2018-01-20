require 'rubygems'
require 'gosu'

class GameWindow < Gosu::Window

  def initialize
    super(640,480,false)
    self.caption = "Stars of Rage"
    @soundtrack = Gosu::Song.new(self,'sor.mp3')
    @wallhit = Gosu::Sample.new(self,'blip.wav')
    @soundtrack.play(true)
    @player = Gosu::Image.new(self,'starfighter.bmp', false)
    @enemy = Gosu::Image.new(self,'starfighter.bmp', false)
    @background = Gosu::Image.new(self,'background.jpg')
    @x = 320 - @player.width/2
    @y = 340 - @player.height/2
    @a = 0
    @b = 0
  end
  
  def update
    @b +=3
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
    @player.draw(@x, @y,1)
    @background.draw(0,0,0)
    @enemy.draw(@a,@b,1)
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

window = GameWindow.new
window.show