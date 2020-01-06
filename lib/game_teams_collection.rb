require 'csv'
require_relative 'game_team' #what's the need for inheritance when you can
#access methods through require (instructor/mod2 support)
require_relative 'csvloadable'
require_relative 'games_collection'
require_relative 'create_objects'


class GameTeamsCollection #< StatTracker
  include CsvLoadable
  include CreateObjects

  attr_reader :game_teams

  def initialize(game_teams_path)
    @game_teams = create_game_teams(game_teams_path)
    all_games_by_team_id
  end

  def create_game_teams(game_teams_path)
    create_instances(game_teams_path, GameTeam)
  end

  def highest_scoring_visitor
    team_id_to_goal = game_teams.reduce({}) do |acc, gameteam|
      if gameteam.hoa == "away"
        if acc[gameteam.team_id] == nil
          acc[gameteam.team_id] = []
          acc[gameteam.team_id] << gameteam.goals
        else
          acc[gameteam.team_id] << gameteam.goals
        end
      end
      acc
    end
    id_to_average = team_id_to_goal.reduce({}) do |acc, keyvalue|
      id = keyvalue[0]
      avg = (keyvalue[1].sum) / (keyvalue[1].length).to_f

      acc[id] = [avg]
      acc
    end

    highest_avg = id_to_average.max_by{|k,v| v}

    highest_avg[0]
  end

  def lowest_scoring_visitor
    t_id_to_goal = game_teams.reduce({}) do |acc, gameteam|
      if gameteam.hoa == "away"
        if acc[gameteam.team_id] == nil
          acc[gameteam.team_id] = []
          acc[gameteam.team_id] << gameteam.goals
        else
          acc[gameteam.team_id] << gameteam.goals
        end
      end
      acc
    end

    id_to_average = t_id_to_goal.reduce({}) do |acc, keyvalue|
      id = keyvalue[0]
      avg = (keyvalue[1].sum) / (keyvalue[1].length).to_f

      acc[id] = [avg]
      acc
    end

    lowest_avg = id_to_average.min_by{|k,v| v}

    lowest_avg[0]
  end

  def highest_scoring_home_team
    id_to_goal = game_teams.reduce({}) do |acc, gameteam|
      if gameteam.hoa == "home"
        if acc[gameteam.team_id] == nil
          acc[gameteam.team_id] = []
          acc[gameteam.team_id] << gameteam.goals
        else
          acc[gameteam.team_id] << gameteam.goals
        end
      end
      acc
    end

    id_to_average = id_to_goal.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end

    highest_avg = id_to_average.max_by{|k,v| v}

    highest_avg[0]
  end

  def lowest_scoring_home_team
    id_to_goal = game_teams.reduce({}) do |acc, gameteam|
      if gameteam.hoa == "home"
        if acc[gameteam.team_id] == nil
          acc[gameteam.team_id] = []
          acc[gameteam.team_id] << gameteam.goals
        else
          acc[gameteam.team_id] << gameteam.goals
        end
      end
      acc
    end

    id_to_average = id_to_goal.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end

    lowest_avg = id_to_average.min_by {|k, v| v}

    lowest_avg[0]
  end

  def winningest_team_id
    team_records = percent_sort_by_id(@all_games_by_team, "WIN")
    team_records.max_by { |team_id, percentage| percentage }[0]
  end

  def best_fans_team_id
    home_win_percents.keys.max_by do |key|
      (home_win_percents[key] - away_win_percents[key])
    end
  end

  def worst_fans_team_id
    home_win_percents.keys.find_all do |key|
      (home_win_percents[key] < away_win_percents[key])
    end
  end

  def all_games_by_team_id
    @all_games_by_team = @game_teams.group_by { |game| game.team_id }
  end

  def home_win_percents
    home_games_teams = hoa_game_sorter("home")
    percent_sort_by_id(home_games_teams, "WIN")
  end

  def away_win_percents
    away_games_teams = hoa_game_sorter("away")
    percent_sort_by_id(away_games_teams, "WIN")
  end

  def percent_sort_by_id(to_sort, stat)
    to_sort.reduce({}) do |records, games|
      wlt_percent_calculator(games[1], stat)
      records[games[0]] = @wlt_percentage
      records
    end
  end

  def wlt_percent_calculator(games_array, stat)
    wlt_total = (games_array.find_all { |game| game.result == stat }).length
    percentage = (wlt_total.to_f / games_array.length.to_f).round(3)
    return @wlt_percentage = 0 if percentage.nan? == true
    @wlt_percentage = percentage
  end

  def hoa_game_sorter(h_a)
    @all_games_by_team.reduce({}) do |records, games|
      records[games[0]] = games[1].find_all {|game| game.hoa == h_a }
      records
    end
  end
end
