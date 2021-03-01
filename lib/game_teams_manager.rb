require_relative './game_team'
require 'CSV'

class GameTeamsManager
  attr_reader :game_teams

  def initialize(data_path)
    @game_teams = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << GameTeam.new(row)
    end
    list_of_data
  end

  def create_hash_int(key, value, data_list)
    hash = Hash.new(0)
    data_list.each do |datum|
      hash[key.call(datum)] += value.call(datum)
    end
    hash
  end

  def create_hash_list(key, value, data_list)
    hash = Hash.new { |h, k| h[k] = [] }
    data_list.each do |datum|
      hash[key.call(datum)] << value.call(datum)
    end
    hash
  end

  def get_proportion_hash(numerator_hash, denominator_hash)
    hash = numerator_hash.merge(denominator_hash) do |key, numerator, denominator|
      (numerator/denominator.to_f).round(2)
    end
  end

  def get_proportion_hash_list(hash, criterion = "WIN")
    hash.each do |key, value|
      hash[key] = (value.count(criterion)/value.count.to_f).round(2)
    end
  end

  def score_ratios_hash(season_games_ids)#new
    data_list = select_season_games(season_games_ids)

    team_id_key = Proc.new{|game_team| game_team.team_id}
    goal_value = Proc.new{|game_team| game_team.goals}
    shots_value = Proc.new{|game_team| game_team.shots}

    goals_hash = create_hash_int(team_id_key, goal_value, data_list)
    shots_hash = create_hash_int(team_id_key, shots_value, data_list)

    get_proportion_hash(goals_hash, shots_hash)
  end

  def select_season_games(season_games_ids)
    @game_teams.find_all do |game_team|
      season_games_ids.include?(game_team.game_id)
    end
  end

  def get_team_tackle_hash(season_games_ids)
    season_list = select_season_games(season_games_ids)

    team_id = Proc.new{|game_team| game_team.team_id}
    tackles = Proc.new{|game_team| game_team.tackles}

    create_hash_int(team_id, tackles, season_list)
  end

  def winningest_coach(season_games)
    data_list = select_season_games(season_games_ids)
    coach_hash = all_coachs_records(season)
    coach_hash.key(coach_hash.values.max)
  end

  def worst_coach(season_games)
    data_list = select_season_games(season_games_ids)
    coach_hash = all_coachs_records(season)
    coach_hash.key(coach_hash.values.min)
  end

  def all_coachs_records(season)
    coach_key = Proc.new{|game_team| game_team.head_coach}
    result_value = Proc.new{|game_team| game_team.result}
    coach_hash_win_list = create_hash_list(coach_key, result_value, data_list)
    coach_hash_win_ratio = get_proportion_hash_list(coach_hash_win_list)
  end

  def favorite_opponent(team_id)
    opponent_list = get_list_of_games_rivales_play_in(team_id)

    team_id = Proc.new{|game_team| game_team.team_id}
    result = Proc.new{|game_team| game_team.result}
    rivals = create_hash_list(team_id, result, opponent_list)
    rival_proportions = get_proportion_hash_list(rivals)

    rival_proportions.key(rival_proportions.values.min)
  end

  def rival(team_id)
    opponent_list = get_list_of_games_rivales_play_in(team_id)

    team_id = Proc.new{|game_team| game_team.team_id}
    result = Proc.new{|game_team| game_team.result}
    rivals = create_hash_list(team_id, result, opponent_list)

    rival_proportions = get_proportion_hash_list(rivals)
    rival_proportions.key(rival_proportions.values.max)
  end

  def get_list_of_games_rivales_play_in(team_id)
    played = @game_teams.find_all do |game_team|
      team_id == game_team.team_id
    end
    opponent_list = []
    played.each do |game_A|
      opponent_game = @game_teams.find do |game_B|
        game_A.game_id == game_B.game_id && game_A.team_id != game_B.team_id
      end
      opponent_list << opponent_game
    end
    opponent_list
  end

  def total_goals_by_team
    team_id = Proc.new{|game_team| game_team.team_id}
    goals = Proc.new{|game_team| game_team.goals}
    create_hash_int(team_id, goals, @game_teams)
  end

  def total_games_by_team
    team_id = Proc.new{|game_team| game_team.team_id}
    goals = Proc.new{|game_team| game_team = 1}
    create_hash_int(team_id, goals, @game_teams)
  end

  def best_offense
    games = total_games_by_team
    goals = total_goals_by_team
    average = get_proportion_hash(goals, games)
    average.key(average.values.max)
  end

  def worst_offense
    games = total_games_by_team
    goals = total_goals_by_team
    average = get_proportion_hash(goals, games)
    average.key(average.values.min)
  end
end
