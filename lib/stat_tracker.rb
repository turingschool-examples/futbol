require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'

class StatTracker < GameManager

  attr_reader :games, :game_details, :teams, :seasons,
              :all_games, :home_wins, :away_wins, :array1

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    @game_teams_array = []
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end

    @games_array = []
    CSV.foreach(locations[:games], headers: true) do |row|
      @games_array << Game.new(row)
    end

    @teams_array = []
    CSV.foreach(locations[:teams], headers: true) do |row|
      @teams_array << Team.new(row)
    end

    @team_hash = {}
CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
  @team_hash[row[2]] = Team.new(row)
end
  @seasons = seasons
  end

  def team_info(id)
    hash= {}
    team = @team_hash.values.select{ |x| x.team_id == "#{id}"}[0]
    hash["team id"] = team.team_id
    hash["franchise_id"] = team.franchise_id
    hash["team_name"] = team.team_name
    hash["abbreviation"] = team.abbreviation
    hash["link"] = team.link
    hash
  end

  def best_season(id)
    @all_games = @games_array.select do |row| row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    @away_wins = all_games.select do |row| row.away_team_id == "#{id}" && row.away_goals > row.home_goals
    end
    @home_wins = all_games.select do |row| row.home_team_id == "#{id}" && row.away_goals < row.home_goals
    end
    @seasons = (away_wins + home_wins).map{ |x| x.season}
    freq = seasons.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    seasons.max_by { |v| freq[v] }
  end

  def worst_season(id)
    self.best_season(id)
    @seasons
    freq = seasons.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    seasons.min_by { |v| freq[v] }
  end

  def average_win_percentage(id)
    self.best_season(id)
    @all_wins = (@away_wins + @home_wins)
    (@all_wins.length.to_f/@all_games.length.to_f).round(2)
  end

  def most_goals_scored(id)
    self.best_season(id)
    away = @all_games.map{ |rows| rows.away_goals}
    home = @all_games.map{ |rows| rows.home_goals}
    (away + home).sort[-1]
  end

  def fewest_goals_scored(id)
    self.most_goals_scored(id)
    away = @all_games.map{ |rows| rows.away_goals}
    home = @all_games.map{ |rows| rows.home_goals}
    (away + home).sort[0]
  end

  def favorite_opponent(id)
    self.best_season(id)
    teams = []
    @array1 = @all_games.select do |rows|
      if rows.home_team_id == "#{id}"
        if rows.away_goals > rows.home_goals
          teams << rows.away_team_id
        end
      elsif rows.away_team_id == "#{id}"
        if rows.away_goals == rows.home_goals
          teams << rows.home_team_id
        end
      end
    end
    freq = teams.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    numbs = teams.min_by { |v| freq[v] }
    @teams_array.select{ |team| team.team_id == numbs}[0].team_name
  end

  def rival(id)
    teams = []
    self.best_season(id)
    @all_games.each do |game|
      if game.away_team_id == "#{id}"
        teams << game.home_team_id
      elsif game.home_team_id == "#{id}"
        teams << game.away_team_id
      end
    end
    teams
    games_played_against = teams.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    teams1 = []
    @all_games.each do |game|
      if game.away_team_id == "#{id}"
        if game.away_goals < game.home_goals
          teams1 << game.home_team_id
        end
      elsif game.home_team_id == "#{id}"
        if game.away_goals > game.home_goals
          teams1 << game.away_team_id
        end
      end
    end
      teams1
      games_won_against = teams1.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      hash1 = games_won_against.merge(games_played_against){ |k, a_value, b_value| a_value .to_f / b_value.to_f}
      hash1.delete("14")
      team_final = hash1.max_by{|k,v| v}[0]
      @teams_array.select{ |row| row.team_id == team_final}[0].team_name
  end
end

# game_path = './data/games.csv'
# team_path = './data/teams.csv'
# game_teams_path = './data/game_teams.csv'
#
# locations = {
#   games: game_path,
#   teams: team_path,
#   game_teams: game_teams_path
# }
#
# stats = StatTracker.from_csv(locations)
# p stats.rival(18)
