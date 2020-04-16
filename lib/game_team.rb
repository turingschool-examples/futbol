require_relative 'collection'
require_relative 'game'
require_relative 'hashable'
require_relative 'winable'
require_relative 'gameteamable'

class GameTeam < Collection
  extend Hashable
  include Winable
  extend Gameteamable

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
#what does this do?
  def self.game_team_shots_goals_count(arr_games)
    season = arr_games.first.game_id
    self.find_by(season)
  end

  def self.least_accurate_team(season)
     seasonal_hash = gets_team_shots_goals_count(season)
     seasonal_hash.map{|key,value|value[:average] = (value[:goals]/ value[:shots].to_f)}
     return seasonal_hash.min_by{|key,value| value[:average]}[0]
  end

  def self.most_accurate_team(season)
    seasonal_hash = gets_team_shots_goals_count(season)
    seasonal_hash.map{|key,value|value[:average] = (value[:goals]/ value[:shots].to_f)}
    return seasonal_hash.max_by{|key,value| value[:average]}[0]
  end

  def self.most_tackles(season_id)
    most_tackles = tackles_by_team(season_id).max_by { |key, value| value}
    most_tackles.first
  end

  def self.fewest_tackles(season_id)
    fewest_tackles = tackles_by_team(season_id).min_by { |key, value| value}
    fewest_tackles.first
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
    game_team_with_max = total_game_teams_per_team_id.max_by{|game_team| game_team.goals}
    return game_team_with_max.goals
  end

  def self.fewest_goals_scored(team_id)
    total_game_teams_per_team_id = find_by_team(team_id)
    game_team_with_min = total_game_teams_per_team_id.min_by{|game_team| game_team.goals}
    return game_team_with_min.goals
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

end
