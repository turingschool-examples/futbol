require 'csv'

# game_data = CSV.open"./data/games.csv", headers: true, header_converters: :symbol

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = CSV.read "#{locations[:games]}", headers: true, header_converters: :symbol
    @teams = CSV.read "#{locations[:teams]}", headers: true, header_converters: :symbol
    @game_teams = CSV.read "#{locations[:game_teams]}", headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    game_score = []
    @games.each do |row|
      game_score << row[:away_goals].to_i + row[:home_goals].to_i
    end
    game_score.max
  end


class A

def initialize(argument)
  @argument = argument
  @argument = row[:game_id]

end

class B

  def initialize(argument)
    @argument = argument
  end
end
  # def initialize(locations)


  #   @games = CSV.open ""
  #   @teams = CSV.open ""
  #   @game_teams = CSV.open ""
  # end
  #
  # def self.from_csv(locations)
  #   StatTracker.new(locations)
  # end

end


# contents = CSV.open "./data/event_attendees.csv", headers: true, header_converters: :symbol
# # puts contents
#
# attendees = []
#
# big_contents[0] do |row|
#  p row[:game_id]
#
# end
