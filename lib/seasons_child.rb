require './lib/futbol_csv_reader'

class SeasonsChild < CSVReader

  def initialize(locations)
    super(locations)
  end

  def winningest_coach(season)
    season_game_teams = game_teams_by_season(season)
    coaches_hash = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_hash.max_by do |coach|
      coach[1][2]
    end[0]
  end

  def worst_coach(season)
    season_game_teams = game_teams_by_season(season)
    coaches_records = win_percentage_by_coach(coaches_records(season_game_teams))
    winning_coach = coaches_records.min_by do |coach|
      coach[1][2]
    end[0]
  end

  def team_name(id)
    @teams.find do |row|
      row.team_id == id
    end.team_name.to_s
  end

  def accuracy_hash(season)
    season_game_teams = game_teams_by_season(season)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    season_game_teams.each do |row|
      hash[row.team_id][0] += row.goals
      hash[row.team_id][1] += row.shots
      hash[row.team_id][2] = hash[row.team_id][0]/hash[row.team_id][1].to_f
    end
    hash
  end

  def most_accurate_team(season)
    accurate_team_id = accuracy_hash(season).max_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def least_accurate_team(season)
    accurate_team_id = accuracy_hash(season).min_by do |team|
      team[1][2]
    end[0]
    return team_name(accurate_team_id)
  end

  def tackle_hash(season)
    season_game_teams = game_teams_by_season(season)
    hash = Hash.new{|h,k| h[k] = 0 }
    season_game_teams.each do |row|
      hash[row.team_id] += row.tackles
    end
    hash
  end

  def most_tackles(season)
    most_tackles_team_id = tackle_hash(season).max_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def fewest_tackles(season)
    most_tackles_team_id = tackle_hash(season).min_by do |team|
      team[1]
    end[0]
    return team_name(most_tackles_team_id)
  end

  def win_percentage_by_coach(coaching_hash)
    coaching_hash.keys.map do |key|
      total_games = coaching_hash[key][0] + coaching_hash[key][1]
      coaching_hash[key][2] = coaching_hash[key][0]/total_games.to_f
    end
    return coaching_hash
  end

  def game_teams_by_season(season)
    @game_teams.select do |row|
      row.game_id.to_s[0..3] == season.to_s[0..3]
    end
  end

  def games_by_season(season)
    @games.select do |row|
      row.season == season
    end
  end

  def coaches_records(game_teams)
    hash = Hash.new{|h,k| h[k] = [0,0,0.to_f] }
    game_teams.each do |row|
      if row.result == "WIN"
        hash[row.head_coach][0] += 1
      else
        hash[row.head_coach][1] += 1
      end
    end
    return hash
  end
end
