require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'

class StatTracker < GameManager

  attr_reader :games, :game_details, :teams, :seasons

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
    all_games = @games_array.select do |row| row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    away_wins = all_games.select do |row| row.away_team_id == "#{id}" && row.away_goals > row.home_goals
    end
    home_wins = all_games.select do |row| row.home_team_id == "#{id}" && row.away_goals < row.home_goals
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

end

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stats = StatTracker.from_csv(locations)
p stats.worst_season(6)
