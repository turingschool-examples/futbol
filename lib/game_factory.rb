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
    percentage_wins = (home_wins.to_f / @games.count.to_f) * 100
    percentage_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0 
    @games.each do |game|
      if game[:away_goals] > game[:home_goals]
        visitor_wins += 1
      end
    end
    percentage_wins = (visitor_wins.to_f / @games.count.to_f) * 100
    percentage_wins.round(2)
  end
end