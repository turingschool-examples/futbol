require_relative "stat_tracker"

class TeamStatistics
  attr_reader :stat_tracker_copy, :csv_team_table
  def initialize(csv_files, stat_tracker)
    @csv_team_table = csv_files.teams
    @csv_games_table = csv_files.games
    @csv_game_teams_table = csv_files.game_teams
    @stat_tracker_copy = stat_tracker
  end

  def team_info
    hash = {}
    @csv_team_table.each do |team|
      if hash[team[1].team_id].nil?
          hash[team[1].team_id] = [team[1].abbreviation, team[1].franchiseId,
          team[1].link, team[1].team_id, team[1].team_name]
      end
      @stat_tracker_copy.team_info_stat = hash
      # require "pry"; binding.pry
    end
  end

  def total_games_played_per_season_by_team
    hash = {}
    @csv_games_table.each do |game|
      if hash[game[1].season].nil?
          hash[game[1].season] = [game[1].home_team_id, game[1].away_team_id]
          #require "pry"; binding.pry
      else
        hash[game[1].season] << [game[1].home_team_id, game[1].away_team_id]
      end
    end
    hash.each do |key, value|
      value.flatten!
    end
    games_played_per_season = total_games_per_season(hash)
    games_played_per_season
    # require "pry"; binding.pry
  end

  def total_games_per_season(input)
    season_hash = {}
    new_hash = {}
    input.each do |season|
      season[1].each do |team_id|
        if new_hash[team_id].nil?
          new_hash[team_id]= season[1].count(team_id)
        end
      end
      season_hash[season[0]] = new_hash
      new_hash = {}
    end
    season_hash
  end
end

# method: looks througb all the games, dtermine who has the biggest win %
# add agove to an array, including all seasons
# then for best season, .max & worst season .min
