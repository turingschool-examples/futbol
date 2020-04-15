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

  def self.coaches_in_season(season_id)
    search_term = season_id.to_s[0..3]
    game_teams_in_season = all.find_all do |gt|
      gt.game_id.to_s[0..3] == search_term
    end
    game_teams_in_season.map {|gameteam| gameteam.head_coach}.uniq
  end

  def self.results_by_coach(season_id)
    search_term = season_id.to_s[0..3]
    results_by_coach_by_season = Hash.new { |hash, key| hash[key] = [] }
    coaches_in_season(season_id).each do |coach|
      all.find_all do |gt|
        if gt.game_id.to_s[0..3] == search_term && coach == gt.head_coach
            results_by_coach_by_season[coach] << gt.result
        end
      end
    end
    results_by_coach_by_season
  end

  def self.total_games_coached(season_id)
    total_games_coached_by_season = {}
    results_by_coach(season_id).map do |coach, results|
      total_games_coached_by_season[coach] = results.length
    end
    total_games_coached_by_season
  end

  def self.wins_by_coach(season_id)
    wins_by_coach_by_season = Hash.new { |hash, key| hash[key] = 0 }
    results_by_coach(season_id).each do |coach, results|
      results.each do |result|
        wins_by_coach_by_season[coach] += 1 if result == "WIN"
      end
    end
    wins_by_coach_by_season
  end

  def self.winningest_coach(season_id)
    coaches_in_season(season_id).max_by {|coach| (wins_by_coach(season_id)[coach].to_f / total_games_coached(season_id)[coach].to_f).round(2)}
  end

  def self.worst_coach(season_id)
    coaches_in_season(season_id).min_by do |coach|
      (wins_by_coach(season_id)[coach].to_f / total_games_coached(season_id)[coach].to_f).round(2)
    end
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

  def self.opponents_records(team_id)
    game_ids = all.map {|gt| gt.game_id if gt.team_id == team_id }.compact
    opponents_records = Hash.new { |hash, key| hash[key] = [] }
    game_ids.each do |game_id|
      all.find_all do |gt|
        opponents_records[gt.team_id] << gt.result if gt.game_id == game_id && gt.team_id != team_id
      end
    end
    opponents_records
  end

  def self.opponents_wins(team_id)
    opponent_wins = Hash.new { |hash, key| hash[key] = 0 }
    opponents_records(team_id).each do |team_id, record|
      record.each do |result|
        opponent_wins[team_id] += 1 if result == "WIN"
      end
    end
    opponent_wins
  end

  def self.favorite_opponent_id(team_id)
    team_id = team_id
    record_length = {}
    opponents_records(team_id).map do |team_id, record|
      record_length[team_id] = record.length
    end
    opponents = opponents_records(team_id).keys
    opponents.min_by {|opponent| (opponents_wins(team_id)[opponent].to_f / record_length[opponent].to_f).round(2)}
  end

  def self.rival_id(team_id)
    team_id = team_id
    record_length = {}
    opponents_records(team_id).map do |team_id, record|
      record_length[team_id] = record.length
    end
    opponents = opponents_records(team_id).keys
    opponents.max_by {|opponent| (opponents_wins(team_id)[opponent].to_f / record_length[opponent].to_f).round(2)}
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

  def win?
    return 1 if @result == "WIN"
    0
  end

end
