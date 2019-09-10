require_relative 'team'
require_relative 'game'
require_relative 'game_team'
require_relative '../module/game_stat'
require_relative '../module/league_stat'
require_relative '../module/team_stat'
require_relative '../module/season_stat'
require_relative '../module/opponent_stat'
require_relative '../module/seasonal_sumary_stat'
require 'csv'

class StatTracker
  include GameStat
  include LeagueStat
  include TeamStat
  include SeasonStat
  include OpponentStat
  include SeasonalSumaryStat
  attr_reader :all_teams, :all_games, :all_game_teams

  def initialize(team_hash, game_hash, game_teams_array)
    @all_teams = team_hash
    @all_games = game_hash
    @all_game_teams = game_teams_array
  end

  def self.from_csv(file_paths)
    all_teams = self.generate_hash(file_paths[:teams], Team)
    all_games = self.generate_hash(file_paths[:games], Game)
    all_game_teams = self.generate_hash(file_paths[:game_teams], GameTeam)
    self.new(all_teams, all_games, all_game_teams)
  end

  def self.generate_hash(location, obj_type)
    hash = Hash.new
    CSV.foreach(location, headers: true) do |row|
      obj = obj_type.new(row)
      if obj_type == GameTeam
        hash[row[0]] ||= {}
        hash[row["game_id"]][row["HoA"]] = obj
      else
        hash[row[0]] = obj
      end
    end
    hash
  end
end
