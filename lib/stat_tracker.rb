require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = read_from_file(locations[:games])
    teams = read_from_file(locations[:teams])
    game_teams = read_from_file(locations[:game_teams])
    stat_tracker = self.new(games, teams, game_teams)
  end

  def self.read_from_file(file)
    CSV.parse(File.read(file), headers: true)
  end

# ************* LeagueStatistics *************

  def group_by(data, key, value)
    hash = {}
    data = self.instance_variable_get(data)
    data.each do |row|
      if hash[row[key]]
        hash[row[key]] << row[value]
      else
        hash[row[key]] = [row[value]]
      end
    end
    hash
  end

  def count_of_teams
    @teams["teamName"].count
  end

  def best_offense
    team_id = group_by(:@game_teams, "team_id", "goals").max_by do |team_id, goals_in_game|
      goals_in_game.map(&:to_i).sum / (goals_in_game.length)
    end.first
    @teams.find {|row| row["team_id"] == team_id}["teamName"]
  end
# ************* Season Statistics *************
  def total_games_played_by_coach_helper
    games_coached_hash =  @game_teams["head_coach"].group_by(&:itself)
      games_coached_hash.map{|key, value| [key, value.length]}.to_h
      end
  def total_games_won_by_coach_helper


      end
  end
#   def all_coaches_total_games_helper
#     all_coaches_helper.group_by(&:itself)
#   end
# end
