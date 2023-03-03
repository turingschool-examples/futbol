require 'csv'
require_relative 'game'
require_relative 'team'

class StatTracker 
  #include modules

  def self.from_csv(locations)
    new(locations)
  end

  attr_reader :game_data, :team_data, :game_teams_data

  def initialize(locations)
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @team_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def all_games
    @game_data.map do |row|
      Game.new(row)
    end
  end

  def all_teams
    @team_data.map do |row|
      team = Team.new(row)
      team.games = all_games.select { |game| game.home_id == team.team_id || game.away_id == team.team_id }
      team
    end
  end

  def all_game_teams
    @game_teams_data.map do |row|
      GameTeam.new(row)
    end
  end

  def highest_total_score
    all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end

  def games_by_season
    seasons = Hash.new([])
    all_games.each do |game|
      seasons[game.season] = []
    end
    seasons.each do |season, games_array|
      all_games.each do |game|
        games_array << game if game.season == season
      end
    end
    seasons
  end
  
  # def lowest_scoring_visitor
  #   away_games = []
  #   all_games.each do |game|
  #     away_games.push(game.away_id) if game.away_id = 3
  #   end
  #   away_games
  # end
  def count_of_teams
    @team_data.count
  end

  def percentage_home_wins
    team_wins = all_game_teams.select do |team|
    team.result == "WIN" && team.home_or_away == "home"
    end
    home_games = all_game_teams.select do |game|
    game.home_or_away == "home"
    end
    (team_wins.count / home_games.count.to_f).round(2)
  end
end
