
class Game 
  attr_reader :game_id,
              :season,
              :game_type,
              :game_date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(game_id, season, game_type, game_date_time, away_team_id, home_team_id, away_goals, home_goals)
    @game_id = game_id
    @season = season
    @game_type = game_type 
    @game_date_time = game_date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
  end

  def self.create_games 
    game_instance_array = []
    CSV.foreach("./data/game_subset.csv", headers: true, header_converters: :symbol) do |row|
      game_id =row[:game_id]
      season = row[:season]
      game_type = row[:type]
      game_date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      game_instance = Game.new(game_id, season, game_type, game_date_time, away_team_id, home_team_id, away_goals, home_goals)
      game_instance_array << game_instance
    end
    game_instance_array
  end

  def highest_total_score
    most_goals = 0
    games_data = Game.create_games
    games_data.each do |game|
      total_goals = (game.home_goals).to_i + (game.away_goals).to_i
      if total_goals > most_goals
        most_goals = total_goals
      end
    end
    most_goals
  end

  def lowest_total_score
    fewest_goals = 11
    games_data = Game.create_games
    games_data.each do |game|
      total_goals = (game.home_goals).to_i + (game.away_goals).to_i
      if total_goals < fewest_goals
        fewest_goals = total_goals
      end
    end
    fewest_goals
  end

end