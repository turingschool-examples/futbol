require_relative 'collection'
require_relative 'game'
require_relative 'hashable'

class GameTeam < Collection
  extend Hashable

  def self.find_by_team(team_id)
    all.find_all{|game| game.team_id == team_id}
  end

  def self.home_games
    (all.find_all {|gt| gt.hoa == "home" }).count
  end

  def self.percentage_home_wins
    home_wins = (all.find_all {|gt| gt.hoa == "home" && gt.result == "WIN" }).count.to_f
    ((home_wins / self.home_games)).round(2)
  end

  def self.percentage_visitor_wins
    visitor_wins = (all.find_all {|gt| gt.hoa == "home" && gt.result == "LOSS" }).count.to_f
    ((visitor_wins / self.home_games)).round(2)
  end

  def self.percentage_ties
    games_count = all.count.to_f
    ties_count = (all.find_all { |gt| gt.result == "TIE"}).count.to_f
    ((ties_count / games_count)).round(2)
  end

  def self.coach_record(season_id)
    game_teams_in_season = all.find_all {|gt| gt.season_id == season_id.to_s[0..3]}
    hash_of_hashes(game_teams_in_season, :head_coach, :wins, :games_played, :gt_win?, 1)
  end

  def self.winningest_coach(season_id)
    wins_by_coach = divide_hash_values(:wins, :games_played,coach_record(season_id))
    winningest = wins_by_coach.max_by {|coach, percent| percent}
    winningest[0]
  end

  def self.worst_coach(season_id)
    wins_by_coach = divide_hash_values(:wins, :games_played,coach_record(season_id))
    worst = wins_by_coach.min_by {|coach, percent| percent}
    worst[0]
  end

  def self.game_team_shots_goals_count(arr_games)
    season = arr_games.first.game_id
    self.find_by(season)
  end

  def self.get_goal_shots_by_game_team(game_teams)
    hash_of_hashes(game_teams,:team_id,:goals,:shots,:goals,:shots)
  end

  def self.least_accurate_team(season)
     seasonal_hash = gets_team_shots_goals_count(season)
     seasonal_hash.map{|key,value|value[:average] = (value[:goals]/ value[:shots].to_f).round(2)}
     return seasonal_hash.min_by{|key,value| value[:average]}[0]
  end

  def self.most_accurate_team(season)
    seasonal_hash = gets_team_shots_goals_count(season)
    seasonal_hash.map{|key,value|value[:average] = (value[:goals]/ value[:shots].to_f).round(2)}
    return seasonal_hash.max_by{|key,value| value[:average]}[0]
  end

  def self.gets_team_shots_goals_count(season)
    season_games = Game.grouped_by_season(season)
    matches = []
    season_games.each {|game|matches.concat(GameTeam.find_by(game.game_id))}
    stats_by_team = get_goal_shots_by_game_team(matches)
  end


  def self.games_by_team_name(season_id)
    game_id_first = season_id.to_s[0..3]
    all_games_by_id = all.find_all {|game| game.season_id == game_id_first}
    games_by_id = all_games_by_id.group_by { |game| game.team_id }
  end

  def self.tackles_by_team(season_id)
    tackles_by_team = {}
    games_by_team_name(season_id).each do |key, value|
      total_tackles = value.sum { |value| value.tackles}
      tackles_by_team[key] = total_tackles
    end
      tackles_by_team
  end

  def self.most_tackles(season_id)
    most_tackles = tackles_by_team(season_id).max_by { |key, value| value}
    most_tackles.first
  end

  def self.fewest_tackles(season_id)
    fewest_tackles = tackles_by_team(season_id).min_by { |key, value| value}
    fewest_tackles.first
  end

  def self.total_goals_per_team
    grouped_team = all.group_by{|game| game.team_id}
    grouped_team.keys.each_with_object({}) do |team_id , hash|
      hash[team_id] = (grouped_team[team_id].sum(&:goals) / grouped_team[team_id].length.to_f).round(2)
    end
  end

  def self.best_offense
    offensive_hash = total_goals_per_team
    offensive_hash.key(offensive_hash.values.max)
  end

  def self.worst_offense
    offensive_hash = total_goals_per_team
    offensive_hash.key(offensive_hash.values.min)
  end

  def self.most_goals_scored(team_id)
    total_game_teams_per_team_id = find_by_team(team_id)
    game_team_with_max = total_game_teams_per_team_id.max{|game_team| game_team.goals}
    return game_team_with_max.goals
  end

  def self.fewest_goals_scored(team_id)
    total_game_teams_per_team_id = find_by_team(team_id)
    game_team_with_min = total_game_teams_per_team_id.min{|game_team| game_team.goals}
    return game_team_with_min.goals
  end

  def self.game_teams_with_opponent(team_id)
    game_ids = all.map {|gt| gt.game_id if gt.team_id == team_id }.compact
    game_teams_with_these_ids = all.find_all do |gt|
      game_ids.include?(gt.game_id) && gt.team_id != team_id
    end
    game_teams_with_these_ids
  end

  def self.opponents_records(team_id)
    hash_of_hashes(game_teams_with_opponent(team_id), :team_id, :wins, :games_played, :gt_win?, 1)
  end

  def self.favorite_opponent_id(team_id)
    opponents = divide_hash_values(:wins, :games_played, opponents_records(team_id))
    fave = opponents.min_by {|opponent, percent| percent}
    fave[0]
  end

  def self.rival_id(team_id)
    opponents = divide_hash_values(:wins, :games_played, opponents_records(team_id))
    biggest_rival = opponents.max_by {|opponent, percent| percent}
    biggest_rival[0]
  end

    attr_reader :game_id,
                :team_id,
                :hoa,
                :result,
                :settled_in,
                :head_coach,
                :goals,
                :shots,
                :tackles,
                :pim,
                :power_play_opportunities,
                :power_play_goals,
                :face_off_win_percentage,
                :giveaways,
                :takeaways,
                :season_id

  def initialize(details)
    @game_id = details[:game_id]
    @team_id = details[:team_id]
    @hoa = details[:hoa]
    @result = details[:result]
    @settled_in = details[:settled_in]
    @head_coach = details[:head_coach]
    @goals = details[:goals].to_i
    @shots = details[:shots].to_i
    @tackles = details[:tackles].to_i
    @pim = details[:pim].to_i
    @power_play_opportunities = details[:powerplayopportunities].to_i
    @power_play_goals = details[:powerplaygoals].to_i
    @face_off_win_percentage = details[:faceoffwinpercentage].to_f.round(2)
    @giveaways = details[:giveaways].to_i
    @takeaways = details[:takeaways].to_i
    @season_id = @game_id.to_s[0..3]
  end

  def gt_win?
    return 1 if @result == "WIN"
    0
  end

end
