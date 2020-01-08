require 'csv'
require_relative './game'
require_relative './team'
require 'pry'

class Season < Game

  @@all_seasons = []

  def self.all
    @@all_seasons
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all_seasons = csv.map {|row| Season.new(row)}
  end

  def initialize(league_info)
    @game_id = league_info[:game_id]
    @team_id = league_info[:team_id].to_i
    @hoa = league_info[:hoa]
    @result = league_info[:result]
    @settled_in = league_info[:settled_in]
    @head_coach = league_info[:head_coach]
    @shots = league_info[:shots].to_i
    @goals = league_info[:goals].to_i
    @tackles = league_info[:tackles].to_i
    @pim = league_info[:pim].to_i
    @power_play_opportunities = league_info[:powerplayopportunities].to_i
    @power_play_goals = league_info[:powerplaygoals].to_i
    @face_off_win_percentage = league_info[:faceoffwinpercentage].to_i
    @giveaways = league_info[:giveaways].to_i
    @takeaways = league_info[:takeaways].to_i
  end

  def self.total_home_games_played
    total_home_games = @@all_seasons.reduce({}) do |acc, season|
      if acc.keys.include?(season.team_id) && season.hoa == "home"
        acc[season.team_id] += 1
      elsif season.hoa == "home"
        acc[season.team_id] = 1
      end
      acc
    end
  end

  def self.total_away_games_played
    total_away_games = @@all_seasons.reduce({}) do |acc, season|
      if acc.keys.include?(season.team_id) && season.hoa == "away"
        acc[season.team_id] += 1
      elsif season.hoa == "away"
        acc[season.team_id] = 1
      end
      acc
    end
  end

  def self.home_win_percentage
    total_home_games_played
    testy = @@all_seasons.reduce({}) do |acc, season|
      if acc.keys.include?(season.team_id) && (season.hoa == "home" && season.result == "WIN")
        acc[season.team_id] += 1
      elsif (season.hoa == "home" && season.result == "WIN")
        acc[season.team_id] = 1
      end
      acc
    end
    # require "pry"; binding.pry
  end

  # def self.home_win_percentage
  #   @@all_seasons.reduce({0}) do |acc, season|
  #     require "pry"; binding.pry
  #     if acc.keys.include?(season.team_id)
  #       acc[season.team_id] =
  #     # {team_id => total wins / total games}
  #   end
  # end

  def self.best_fans

  end

  def self.winningest_team

  end

  def self.seasons_filter(season_id)
    season_filter = @@all_seasons.find_all do |season|
      season if season_id.slice(0..3) == season.game_id.slice(0..3)
    end
  end

  def self.find_team_name(id)
    testy = @@all_teams.find do |team|
      return team.team_name if team.team_id == id[0]
    end
  end

  def self.most_tackles(season_id)
    seasons_by_season = seasons_filter(season_id)
    team_tackles = seasons_by_season.reduce(Hash.new(0)) do |result, season|
      result[season.team_id] += season.tackles
      result
    end
    id_stat = team_tackles.max_by {|k, v| v}
    find_team_name(id_stat)
  end

  def self.fewest_tackles(season_id)
    seasons_by_season = seasons_filter(season_id)
    team_tackles = seasons_by_season.reduce(Hash.new(0)) do |result, season|
      result[season.team_id] += season.tackles
      result
    end
    id_stat = team_tackles.min_by {|k, v| v}
    find_team_name(id_stat)
  end

  def self.winningest_coach(season_id)
    seasons_by_season = seasons_filter(season_id)
    coach_wins = seasons_by_season.reduce(Hash.new(0)) do |result, season|
      result[season.head_coach] += 1 if season.result == "WIN"
      result
    end
    coach_total_games = seasons_by_season.reduce(Hash.new(0)) do |result, season|
      result[season.head_coach] += 1
      result
    end
    coach_percentage = coach_total_games.reduce(coach_wins) do |result, (coach, total_games)|
      result[coach] = ((result[coach] / total_games.to_f) * 100).round(2)
      result
    end
    coach = coach_percentage.max_by {|k, v| v}
    coach[0]
  end

  def self.worst_coach(season_id)
    seasons_by_season = seasons_filter(season_id)
    coach_wins = seasons_by_season.reduce(Hash.new(0)) do |result, season|
      result[season.head_coach] += 1 if season.result == "WIN"
      result
    end
    coach_total_games = seasons_by_season.reduce(Hash.new(0)) do |result, season|
      result[season.head_coach] += 1
      result
    end
    coach_percentage = coach_total_games.reduce(coach_wins) do |result, (coach, total_games)|
      result[coach] = ((result[coach] / total_games.to_f) * 100).round(2)
      result
    end
    coach = coach_percentage.min_by {|k, v| v}
    coach[0]
  end

  def self.most_accurate_team(season_id)	#Name of the Team with the best ratio of shots to goals for the season	String
    ratio_per_game_hash = shot_to_goal_ratio_per_game(season_id)
    team_accuracy_average_hash = average_shots_per_goal_by_team(ratio_per_game_hash)
    max_value_team(team_accuracy_average_hash)
  end

  def self.least_accurate_team(season_id)	#Name of the Team with the best ratio of shots to goals for the season	String
    ratio_per_game_hash = shot_to_goal_ratio_per_game(season_id)
    team_accuracy_average_hash = average_shots_per_goal_by_team(ratio_per_game_hash)
    min_value_team(team_accuracy_average_hash)
  end

  def self.shot_to_goal_ratio_per_game(season_id)
    game_team_objects_array_by_season = seasons_filter(season_id)
    ratio_per_game_hash = game_team_objects_array_by_season.reduce (Hash.new([])) do |acc, season|
      if acc.keys.include?(season.team_id)
        acc[season.team_id] << (season.goals/season.shots.to_f).round(2)
      elsif !acc.keys.include?(season.team_id)
        acc[season.team_id] = [(season.goals/season.shots.to_f).round(2)]
      end
      acc
    end.compact
  end

  def self.average_shots_per_goal_by_team(ratio_per_game_hash)
    ratio_per_game_hash.each do |key, value|
      ratio_per_game_hash[key] = (value.sum / value.count.to_f).round(2)
    end
  end

  def self.max_value_team(team_accuracy_average_hash)
    team_id_2 = team_accuracy_average_hash.max_by {|k, v| v}
    find_team_name(team_id_2)
  end

  def self.min_value_team(team_accuracy_average_hash)
    team_id_3 = team_accuracy_average_hash.min_by {|k, v| v}
    find_team_name(team_id_3)
  end

  def self.find_team_name(id)
    testy = @@all_teams.find do |team|
      return team.team_name if team.team_id == id[0]
    end
  end


  # def coach_wins
  #   seasons_by_season.reduce(Hash.new(0)) do |result, season|
  #     result[season.head_coach] += 1 if season.result == "WIN"
  #     result
  #   end
  # end
  #
  # def coach_total_games
  #   coach_total_games = seasons_by_season.reduce(Hash.new(0)) do |result, season|
  #     result[season.head_coach] += 1
  #     result
  #   end
  # endend


# team_accuracy_hash = shot_to_goal_ratio_per_game(season_id)
# team_accuracy_average_hash = average_shots_per_goal_by_team(team_accuracy_hash)
# binding.pry
# max_value_team(team_accuracy_average_hash)
