require 'simplecov'
Simplecov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/coach'

class CoachTest < Minitest::Test

  def setup
    @coach = Coach.new
    @game1 = GameTeam.new(2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7)
    @game2 = GameTeam.new(2012030221,6,home,WIN,OT,Claude Julien,3,12,51,6,4,1,55.2,4,5)
    @game3 = GameTeam.new(2012030222,3,away,LOSS,REG,John Tortorella,2,9,33,11,5,0,51.7,1,4)
    @game4 = GameTeam.new(2012030222,6,home,WIN,REG,Claude Julien,3,8,36,19,1,0,48.3,16,6)
    @game5 = GameTeam.new(2012030223,6,away,WIN,REG,Claude Julien,2,8,28,6,0,0,61.8,10,7)
    @game6 = GameTeam.new(2012030223,3,home,LOSS,REG,John Tortorella,1,6,37,2,2,0,38.2,7,9)
    @game7 = GameTeam.new(2012030224,6,away,WIN,OT,Claude Julien,3,10,24,8,4,2,53.7,8,6)
    @game8 = GameTeam.new(2012030224,3,home,LOSS,OT,John Tortorella,2,8,40,8,4,1,46.3,9,7)
    @game9 = GameTeam.new(2012030225,3,away,LOSS,REG,John Tortorella,1,7,25,13,2,1,50.9,5,3)
    @game10 = GameTeam.new(2012030225,6,home,WIN,REG,Claude Julien,3,8,35,11,3,1,49.1,12,9)


end
