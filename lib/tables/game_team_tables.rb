require './lib/helper_modules/csv_to_hashable'
require './lib/helper_modules/team_returnable'
require './lib/instances/game_team'

class GameTeamTable
  include CsvToHash
  include ReturnTeamable
  attr_reader :game_team_data, :teams, :stat_tracker
  def initialize(locations, stat_tracker)
    @game_team_data = from_csv(locations, 'GameTeam')
    @stat_tracker = stat_tracker
  end

  def get_season(season)
    season = @stat_tracker.game_by_season[season.to_i].map do |season|
      season.game_id
    end
    ids = @game_team_data.map do |gameteam|
      gameteam.game_id
    end
    overlap = season & ids
  end

  def winningest_coach(season)
    games_by_season = games_by_season(season)
    winning_coach_hash =games_by_season.group_by do |game|
       game.head_coach if game.result == "WIN"
      end
    win_count = winning_coach_hash.each { |k, v| winning_coach_hash[k] = v.count}.reject{|coach| coach == nil}
    win_count.max_by{|coach, win| win}[0]
  end

  def worst_coach(season)
    games_by_season = games_by_season(season)
    winning_coach_hash = games_by_season.group_by do |game|
       game.head_coach if game.result == "LOSS"
      end
    win_count = winning_coach_hash.each { |k, v| winning_coach_hash[k] = v.count}.reject{|coach| coach == nil}
    win_count.min_by{|coach, win| win}[0]
  end

  def most_accurate_team(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by do |game|
      game.team_id
    end
    ratio_of_g_to_s = games_by_team_id_hash.each do |team, ratio|
      games_by_team_id_hash[team] = ratio.map do |array|
        (array.goals.to_f / array.shots.to_f).round(2)
      end
    end
    r1 = ratio_of_g_to_s.max_by do |team_id, ratio|
      ratio.sum
    end
    r1[0]
  end

  def least_accurate_team(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by do |game|
      game.team_id
    end
    ratio_of_g_to_s = games_by_team_id_hash.each do |team, ratio|
      games_by_team_id_hash[team] = ratio.map do |array|
        (array.goals.to_f / array.shots.to_f).round(2)
      end
    end
    r1 = ratio_of_g_to_s.min_by do |team_id, ratio|
      ratio.sum
    end
    r1[0]
  end

  def most_tackles(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by do |game|
      game.team_id
    end
    container = games_by_team_id_hash.each do |team, games|
      games_by_team_id_hash[team] = games.sum do |lul|
        lul.tackles
      end
    end
    thereturn = container.max_by do |team_id, tackle|
      tackle
    end
    thereturn[0]
  end

  def fewest_tackles(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by do |game|
      game.team_id
    end
    container = games_by_team_id_hash.each do |team, games|
      games_by_team_id_hash[team] = games.sum do |lul|
        lul.tackles
      end
    end
    thereturn = container.min_by do |team_id, tackle|
      tackle
    end
    thereturn[0]
  end

  def games_by_season(season)
    season = @stat_tracker.game_by_season[season.to_i].map do |season|
      season.game_id
    end
    ids = @game_team_data.map do |gameteam|
      gameteam.game_id
    end
    overlap = season & ids
    games_by_season= @game_team_data.find_all do |games|
      overlap.include?(games.game_id)
    end
  end
end
