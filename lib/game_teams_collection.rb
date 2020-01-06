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
  end

  def create_game_teams(game_teams_path)
    create_instances(game_teams_path, GameTeam)
  end

  def highest_scoring_visitor_id
    id_t_g = game_teams.reduce({}) do |acc, gameteam|
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

    id_t_avg = id_t_g.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end

    highest_avg = id_t_avg.max_by {|k, v| v}

    highest_avg[0]
  end

  def lowest_scoring_visitor_id
    id_t_g = game_teams.reduce({}) do |acc, gameteam|
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

    id_t_avg = id_t_g.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end

    lowest_avg = id_t_avg.min_by {|k, v| v}

    lowest_avg[0]
  end

  def highest_scoring_home_team_id
    id_t_g = game_teams.reduce({}) do |acc, gameteam|
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

    id_t_avg = id_t_g.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end

    highest_avg = id_t_avg.max_by {|k, v| v}

    highest_avg[0]
  end

  def lowest_scoring_home_team_id
    id_t_g = game_teams.reduce({}) do |acc, gameteam|
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

    id_t_avg = id_t_g.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end

    lowest_avg = id_t_avg.min_by {|k, v| v}

    lowest_avg[0]
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
    matching_teamids = (reg_team_id_topercent.keys & post_team_id_topercent.keys).sort
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

    biggest_decrease = teamid_to_decrease.max_by{|k, v| v}
    biggest_decrease[0]
  end

  def biggest_surprise_id(season_id)
    reg_team_id_topercent = reg_season_team_percentages(season_id)
    post_team_id_topercent = post_season_team_percentages(season_id)
    matching_teamids = (reg_team_id_topercent.keys & post_team_id_topercent.keys).sort

    teamid_to_increase = matching_teamids.reduce({}) do |acc, team_id|
      reg_winpercent = reg_team_id_topercent[team_id][0]
      post_winpercent = post_team_id_topercent[team_id][0]
      if reg_winpercent < post_winpercent
        acc[team_id] = (post_winpercent - reg_winpercent)
      end
      acc
    end

    biggest_increase = teamid_to_increase.max_by{|k, v| v}
    biggest_increase[0]
  end

  def winningest_coach_name(season_id)
    gamescollection = GamesCollection.new("./data/games.csv")
    game_teams1 = create_game_teams("./data/game_teams.csv")

    game_ids = gamescollection.winningest_coach_game_ids(season_id)
    coach_to_results = game_ids.reduce({}) do |acc, gameid|
      game_teams1.each do |gameteam|
        if gameteam.game_id == gameid && acc[gameteam.head_coach] == nil
          acc[gameteam.head_coach] = []
          acc[gameteam.head_coach] << gameteam.result
        elsif gameteam.game_id == gameid && acc[gameteam.head_coach] != nil
          acc[gameteam.head_coach] << gameteam.result
        end
      end
      acc
    end

    coach_to_winpercent = coach_to_results.reduce({}) do |acc, coachresults|
      coachname = coachresults[0]
      win_count = coachresults[1].count("WIN")
      game_count = coachresults[1].length
      win_percentage = (win_count / game_count.to_f) * 100
      acc[coachname] = win_percentage
      acc
    end

    coach_withmaxpercent = coach_to_winpercent.max_by {|k, v| v}

    top_coach_name = coach_withmaxpercent[0]
  end

  def worst_coach_name(season_id)
    gamescollection = GamesCollection.new("./data/games.csv")
    game_teams1 = create_game_teams("./data/game_teams.csv")

    game_ids = gamescollection.winningest_coach_game_ids(season_id)
    coach_to_results = game_ids.reduce({}) do |acc, gameid|
      game_teams1.each do |gameteam|
        if gameteam.game_id == gameid && acc[gameteam.head_coach] == nil
          acc[gameteam.head_coach] = []
          acc[gameteam.head_coach] << gameteam.result
        elsif gameteam.game_id == gameid && acc[gameteam.head_coach] != nil
          acc[gameteam.head_coach] << gameteam.result
        end
      end
      acc
    end

    coach_to_winpercent = coach_to_results.reduce({}) do |acc, coachresults|
      coachname = coachresults[0]
      win_count = coachresults[1].count("WIN")
      game_count = coachresults[1].length
      win_percentage = (win_count / game_count.to_f) * 100
      acc[coachname] = win_percentage
      acc
    end

    coach_withminpercent = coach_to_winpercent.min_by {|k, v| v}

    bottom_coach_name = coach_withminpercent[0]
  end


end
