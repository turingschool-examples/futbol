class GameStats

  attr_reader :game_path, :team_path, :game_teams_path, :games_array

  def initialize(locations)
    @game_path = locations[:games]
    require'pry';binding.pry
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @games_array = []
    # fill_game_array
  end
  def fill_game_array
    @games.each do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      games_array << Game.new(game_id,season,type,date_time,
        away_team_id,home_team_id,away_goals,home_goals,
        venue,venue_link)
      end
  end

    def highest_total_score
      sum = 0
      highest_sum = 0
      @games_array.each do |game|
        sum = game.away_goals.to_i + game.home_goals.to_i
        #require 'pry'; binding.pry
        highest_sum = sum if sum > highest_sum
      end
      highest_sum
    end

end
