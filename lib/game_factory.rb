require 'csv'

class GameFactory
  attr_reader :games

  def initialize
    @games = []
  end 
  
  
  def create_games(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_details = {
        :game_id => row[:game_id], 
        :season => row[:season],
        :type => row[:type],
        :date_time => row[:date_time], 
        :away_team_id => row[:away_team_id], 
        :home_team_id => row[:home_team_id], 
        :away_goals => row[:away_goals], 
        :home_goals => row[:home_goals], 
        :venue => row[:venue],
        :venue_link => row[:venue_link]
      }
      @games.push(game_details)
    end
  end
  
  def percentage_home_wins
    home_wins = 0 
    @games.each do |game|
      if game[:home_goals] > game[:away_goals]
        home_wins += 1
      end
    end
    home_wins / @games.count * 100
  end
  
  def percent_of_ties
    ties = @games.count do |game|
      game[:away_goals] == game[:home_goals]

    end
    (ties.to_f / @games.length).round(2)
  end
end
