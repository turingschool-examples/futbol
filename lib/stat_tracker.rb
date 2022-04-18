require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_data = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_team_data = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    # @games_array = []
    @games = Game.fill_game_array(@game_data)
    @teams = Team.fill_team_array(@team_data)
    @game_teams = GameTeams.fill_game_teams_array(@game_team_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

# Game Statistics
  def highest_total_score
    highest_sum = 0
    @games.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      #require 'pry'; binding.pry
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end

# League Statistics
  def count_of_teams
    @teams.count
  end

  def best_offense
    team_hash = {}
    @game_teams.each do |game_team|
      if team_hash[game_team.team_id].nil?
        team_hash[game_team.team_id] = [game_team.goals]
      else
        team_hash[game_team.team_id] << game_team.goals
      end
    end
    sum_goals = 0
      team_hash.map do |team, goals|
        goals.each do |goal|
          sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
      end
      team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.reverse.to_h

      highest_avg = team_hash.values[0]
      team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
      end

      if team_hash.keys.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
        end
        return team_names
      else
        return team_name_helper(team_hash.keys[0])
      end




      binding.pry
      if highest_avg.length == 1
      end
      return team_hash

  end



  def team_name_helper(team_id)
    @teams.each do |team|
      if team.team_id == team_id
        return team.team_name
      end
    end
  end

  # Season Statistics

  # Team Statistics
  def team_info(team_id)
    team_hash = {}
    @teams.each do |team|
    # require 'pry'; binding.pry
      if team.team_id == team_id
        team_hash = {
        "team_id" => team.team_id,
        "franchise_id" => team.franchise_id,
        "team_name" => team.team_name,
        "abbreviation" => team.abbreviation,
        "link" => team.link
        }
      end
    end
    team_hash 
  end

  def season_games(game_id)
    season = ""
    @games.find do |game|
      if game_id[0..3] == game.season[0..3]
        season << game.season
      end
    end
    return season
  end

  def best_season(team_id)
    best_season = ""
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    games_by_season = {}
    team_by_id.each do |game|
      if games_by_season[season_games(game.game_id)].nil?
        games_by_season[season_games(game.game_id)] = [game]
      else
        games_by_season[season_games(game.game_id)] << game
      end
    end
    win_tracker = 0.0
    win_percentage = 0.0
    games_by_season.map do |season, games|
      games.each do |game|
        if game.result == "WIN"
          win_tracker += 1.0
        end
      end
      win_percentage = win_tracker / games.count * 100
      games_by_season[season] = win_percentage
      win_tracker = 0.0
    end
    highest = games_by_season.max_by {|season, percentage| percentage}[0]
  end

  def worst_season(team_id)
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    games_by_season = {}
    team_by_id.each do |game|
      if games_by_season[season_games(game.game_id)].nil?
        games_by_season[season_games(game.game_id)] = [game]
      else
        games_by_season[season_games(game.game_id)] << game
      end
    end
    win_tracker = 0.0
    win_percentage = 0.0
    games_by_season.map do |season, games|
      games.each do |game|
        if game.result == "WIN"
          win_tracker += 1.0
        end
      end
      win_percentage = win_tracker / games.count * 100
      games_by_season[season] = win_percentage
      win_tracker = 0.0
    end
    lowest = games_by_season.min_by {|season, percentage| percentage}[0]
  end

  def average_win_percentage(team_id)
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    win_counter = 0.0
    win_loss_tracker = team_by_id.map {|team| team.result}
    win_loss_tracker.each do |result|
      if result == ('WIN')
        win_counter += 1
      end
    end
    percentage = win_counter / win_loss_tracker.count
    percentage.round(2)
  end

  def most_goals_scored(team_id)
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    highest_goals = team_by_id.map do |id|
      id.goals
    end
    highest_goals.sort.pop
    # require 'pry'; binding.pry
  end

  def fewest_goals_scored(team_id)
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    highest_goals = team_by_id.map do |id|
      id.goals
    end
    highest_goals.sort.shift
  end

  def favorite_opponent(team_id)
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    id_of_every_game_played = team_by_id.flat_map {|game_team| game_team.game_id}
    opponents = @game_teams.find_all do |game_team|
      id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id
    end
    teams_by_id = opponents.group_by {|opponent| opponent.team_id}
    # require 'pry'; binding.pry
    opposing_win = 0.0
    teams_by_id.each do |team_id, game_teams|
      game_teams.each do |game_team|
        if game_team.result == 'WIN'
          opposing_win += 1
        end
      end
      opposing_win_percentage = opposing_win / game_teams.count
      teams_by_id[team_id] = opposing_win_percentage
      opposing_win = 0.0 
    end
    favorite = teams_by_id.min_by {|team_id, win_percentage| win_percentage}[0]
    @teams.each do |team| 
      if team.team_id.include?(favorite)
        return team.team_name
      end
    end
    # require 'pry'; binding.pry
  end

  def rival(team_id)
    team_by_id = @game_teams.find_all do |team|
      team.team_id == team_id
    end
    id_of_every_game_played = team_by_id.flat_map {|game_team| game_team.game_id}
    opponents = @game_teams.find_all do |game_team|
      id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id
    end
    teams_by_id = opponents.group_by {|opponent| opponent.team_id}
    # require 'pry'; binding.pry
    opposing_win = 0.0
    teams_by_id.each do |team_id, game_teams|
      game_teams.each do |game_team|
        if game_team.result == 'WIN'
          opposing_win += 1
        end
      end
      opposing_win_percentage = opposing_win / game_teams.count
      teams_by_id[team_id] = opposing_win_percentage
      opposing_win = 0.0 
    end
    least_favorite = teams_by_id.max_by {|team_id, win_percentage| win_percentage}[0]
    @teams.each do |team|
      if team.team_id.include?(least_favorite)
        return team.team_name
      end
    end
  end
end
