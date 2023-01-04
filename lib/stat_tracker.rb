require 'csv'
class StatTracker
  attr_reader :game_path,
              :team_path,
              :game_teams_path

  def initialize(locations)
    @game_path = CSV.read(locations[:games], headers: true, skip_blanks: true, header_converters: :symbol)
    @team_path = CSV.read(locations[:teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def all_scores #HELPER for highest_total_score and lowest_total_score
   @game_path.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
  end

  def highest_total_score 
    all_scores.max
  end

  def lowest_total_score 
    all_scores.min
  end

  def home_wins_array #HELPER for percentage_home_wins
    @game_path.find_all do |row|
     row[:home_goals].to_i > row[:away_goals].to_i
    end
  end

  def percentage_home_wins 
    wins = home_wins_array.count
    (wins.to_f / @game_path.count).round(2)
  end

  def count_of_games_by_season
    season_id = @game_path.group_by { |row| row[:season] }
    season_id.each do |season, game|
      season_id[season] = game.count
    end
  end

  def average_goals_per_game
    (all_scores.sum / @game_path.count).to_f.round(2)
  end

  def average_goals_by_season
    games_group_by_season = @game_path.group_by { |row| row[:season] }
    average_season_goals = {}
    games_group_by_season.each do |season, games|
     total_goals = games.sum do |game|
        game[:away_goals].to_i + game[:home_goals].to_i
      end
      average_season_goals[season] = (total_goals / games.count.to_f).round(2)
    end
    average_season_goals
  end

  def count_of_teams
    @team_path.count
  end
end