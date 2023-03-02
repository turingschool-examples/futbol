require 'csv'
require_relative './league'

class StatTracker
  attr_reader :league

  def self.from_csv(locations)
    data = {}
    locations.each do |key, csv_file_path|
      data[key] = CSV.open(csv_file_path, headers: true, header_converters: :symbol)
      data[key] = data[key].to_a.map do |row|
        row.to_h
      end
    end
    self.new(:futbol, data)
  end
  
  def initialize(league_name, data)
    @league = League.new(league_name, data)
  end

  def get_reg_and_post_seasons(season_id)
    @league.seasons.find_all do |season|
      season.year == season_id
    end
  end

  def highest_total_score

  end

  def lowest_total_score

  end

  def percentage_home_wins

  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def most_tackles(season_id)
    team_and_tackles = Hash.new(0) 
    season = @league.seasons.find_all{ |season| season.year == season_id }
    require 'pry'; binding.pry
    season.games.each do |game|
      team_and_tackles[game.refs[:home_team].name] += game.team_stats[:home_team][:tackles].to_i
      team_and_tackles[game.refs[:away_team].name] += game.team_stats[:away_team][:tackles].to_i
    end
    require 'pry'; binding.pry

    team_and_tackles.max_by{ |team, tackles| tackles}.first


    require 'pry'; binding.pry


    # each game in the season .find_all { |game| game.season_id == season_id }
    # @league.seasons.each do |season|
    #   season.each do |game|
    #     game
    #   end
    # end
    
  end

  def fewest_tackles

  end
end

game_path = './spec/fixtures/games_sample.csv'
team_path = './data/teams.csv'
game_teams_path = './spec/fixtures/game_teams_sample.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
