require 'csv'
require_relative 'game_team'
require_relative 'csvloadable'
require_relative 'games_collection'
require_relative 'create_objects'


class GameTeamsCollection
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

  def all_games_by_season(season)
   @game_teams.find_all do |game|
     game if game.game_id.to_s[0..3] == season[0..3]
   end
  end

  def shot_goal_ratio(season)
    shot_goals = {}
    season_by_team(season).map do |id, games|
      goals = (games.sum { |game| game.goals }).to_f
      shots = (games.sum { |game| game.shots }).to_f
      shot_goals[id] = (goals / shots).round(3)
    end
    shot_goals
  end

  def reg_season_team_percentages(season_id)
    gamescollection = games_collection("./data/games.csv")
    game_teams1 = create_game_teams("./data/game_teams.csv")
    reg_game_ids = gamescollection.reg_season_game_ids(season_id)
    reg_team_to_allresults = reg_game_ids.reduce({}) do |acc, game_id|
      reg_gameteams_byid = game_teams1.find_all {|team| team.game_id == game_id}
      if acc[reg_gameteams_byid[0].team_id] == nil
        acc[reg_gameteams_byid[0].team_id] = []
        acc[reg_gameteams_byid[0].team_id] << reg_gameteams_byid[0].result
      else
        acc[reg_gameteams_byid[0].team_id] << reg_gameteams_byid[0].result
      end
      if acc[reg_gameteams_byid[1].team_id] == nil
        acc[reg_gameteams_byid[1].team_id] = []
        acc[reg_gameteams_byid[1].team_id] << reg_gameteams_byid[1].result
      else
        acc[reg_gameteams_byid[1].team_id] << reg_gameteams_byid[1].result
      end
      acc
    end
    reg_team_to_winpercent = reg_team_to_allresults.reduce({}) do |acc, kv|
      team_id = kv[0]
      win_count = kv[1].count("WIN")
      total_games = kv[1].length
      win_percentage = (win_count / total_games.to_f) * 100
      acc[team_id] = [win_percentage]
      acc
    end
  end

  def post_season_team_percentages(season_id)
    gamescollection = games_collection("./data/games.csv")
    game_teams1 = create_game_teams("./data/game_teams.csv")
    post_game_ids = gamescollection.post_season_game_ids(season_id)
    post_team_to_allresults = post_game_ids.reduce({}) do |acc, game_id|
      post_gameteams_byid = game_teams1.find_all {|gameteam| gameteam.game_id == game_id}
      if acc[post_gameteams_byid[0].team_id] == nil
        acc[post_gameteams_byid[0].team_id] = []
        acc[post_gameteams_byid[0].team_id] << post_gameteams_byid[0].result
      else
        acc[post_gameteams_byid[0].team_id] << post_gameteams_byid[0].result
      end
      if acc[post_gameteams_byid[1].team_id] == nil
        acc[post_gameteams_byid[1].team_id] = []
        acc[post_gameteams_byid[1].team_id] << post_gameteams_byid[1].result
      else
        acc[post_gameteams_byid[1].team_id] << post_gameteams_byid[1].result
      end
      acc
    end
    post_team_to_winpercent = post_team_to_allresults.reduce({}) do |acc, kv|
      team_id = kv[0]
      win_count = kv[1].count("WIN")
      total_games = kv[1].length
      win_percentage = (win_count / total_games.to_f) * 100
      acc[team_id] = [win_percentage]
      acc
    end
  end

  def biggest_bust_id(season_id)
    reg_team_id_topercent = reg_season_team_percentages(season_id)
    post_team_id_topercent = post_season_team_percentages(season_id)
    all_teamids = reg_team_id_topercent.keys + post_team_id_topercent.keys
    all_teamids = all_teamids.uniq.sort

    teamid_to_decrease = all_teamids.reduce({}) do |acc, team_id|
      reg_winpercent = reg_team_id_topercent[team_id][0]
      post_team_id_topercent[team_id] = [0.0] if post_team_id_topercent[team_id] == nil
      post_winpercent = post_team_id_topercent[team_id][0]
      if reg_winpercent > post_winpercent
        acc[team_id] = (reg_winpercent - post_winpercent)
      end
      acc
    end
    teamid_to_decrease.max_by { |teamid, percentage| percentage }.first
  end

  def biggest_surprise_id(season_id)
    reg_team_id_topercent = reg_season_team_percentages(season_id)
    post_team_id_topercent = post_season_team_percentages(season_id)
    all_teamids = reg_team_id_topercent.keys + post_team_id_topercent.keys
    all_teamids = all_teamids.uniq.sort

    teamid_to_increase = all_teamids.reduce({}) do |acc, team_id|
      reg_winpercent = reg_team_id_topercent[team_id][0]
      post_team_id_topercent[team_id] = [0.0] if post_team_id_topercent[team_id] == nil
      post_winpercent = post_team_id_topercent[team_id][0]
      if post_winpercent > reg_winpercent
        acc[team_id] = (post_winpercent - reg_winpercent)
      end
      acc
    end
    teamid_to_increase.max_by { |teamid, percentage| percentage }.first
  end

  def season_by_coach(season)
    all_games_by_season(season).group_by { |game| game.head_coach }
  end

  def coach_wins_losses(season)
    coach_wins_losses =  Hash.new(0)
    season_by_coach(season).map do |coach, games|
      coach_wins_losses[coach] = games.map { |game| game.result }
    end
    coach_wins_losses
  end

  def coach_percentage(season)
    coach_wins_losses(season).reduce({}) do |acc, coachresults|
      acc[coachresults[0]] = (coachresults[1].count("WIN") / (coachresults[1].length).to_f) * 100
      acc
    end
  end

  def worst_coach_name(season)
    coach_percentage(season).min_by { |coach, losses| losses }.first
  end

  def winningest_coach_name(season)
    coach_percentage(season).max_by { |coach, wins| wins }.first
  end

  def most_accurate_team_id(season)
    shot_goal_ratio(season).max_by { |id, pcts| pcts }.first
  end

  def least_accurate_team_id(season)
    shot_goals = {}
    season_by_team(season).map do |id, games|
      shot_goals[id] = games.map do |game|
        (game.goals.to_f / game.shots.to_f).round(3)
      end
    end
    (shot_goals.min_by {|id, pcts| (pcts.sum / pcts.length).round(3)})[0]
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

  def season_by_team(season)
    all_games_by_season(season).group_by { |game| game.team_id }
  end

  def team_total_tackles(season)
    team_total_tackles =  Hash.new(0)
    season_by_team(season).map do |id, games|
      team_total_tackles[id] = games.sum { |game| game.tackles }
    end
    team_total_tackles
  end

  def most_tackles_team_id(season)
    team_total_tackles(season).max_by { |team_id, totaltackles| totaltackles }.first
  end

  def fewest_tackles_team_id(season)
    team_total_tackles(season).min_by { |team_id, totaltackles| totaltackles }.first
  end
end
