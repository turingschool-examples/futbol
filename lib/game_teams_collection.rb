require 'csv'
require_relative 'game_team'
require_relative 'csvloadable'
require_relative 'games_collection'

class GameTeamsCollection
  include CsvLoadable

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
    gamescollection = GamesCollection.new("./data/games.csv")
    game_teams1 = create_game_teams("./data/game_teams.csv") #could inherit
    #parent class stattracker to have access to gamescollection without building it

    reg_game_ids = gamescollection.reg_season_game_ids(season_id)

    reg_team_to_allper = reg_game_ids.reduce({}) do |acc, game_id|
      z = game_teams1.find_all {|team| team.game_id == game_id}
      if acc[z[0].team_id] == nil
        acc[z[0].team_id] = []
        acc[z[0].team_id] << z[0].faceoffwinpercentage.to_i
      else
        acc[z[0].team_id] << z[0].faceoffwinpercentage.to_i
      end
      if acc[z[1].team_id] == nil
        acc[z[1].team_id] = []
        acc[z[1].team_id] << z[1].faceoffwinpercentage.to_i
      else
        acc[z[1].team_id] << z[1].faceoffwinpercentage.to_i
      end
      acc
    end

    reg_team_to_avgper = reg_team_to_allper.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end
  end

  def post_season_team_percentages(season_id)
    gamescollection = GamesCollection.new("./data/games.csv")
    game_teams1 = create_game_teams("./data/game_teams.csv")

    post_game_ids = gamescollection.post_season_game_ids(season_id)

    post_team_to_allper = post_game_ids.reduce({}) do |acc, game_id|
      z = game_teams1.find_all {|team| team.game_id == game_id}
      if acc[z[0].team_id] == nil
        acc[z[0].team_id] = []
        acc[z[0].team_id] << z[0].faceoffwinpercentage.to_i
      else
        acc[z[0].team_id] << z[0].faceoffwinpercentage.to_i
      end
      if acc[z[1].team_id] == nil
        acc[z[1].team_id] = []
        acc[z[1].team_id] << z[1].faceoffwinpercentage.to_i
      else
        acc[z[1].team_id] << z[1].faceoffwinpercentage.to_i
      end
      acc
    end

    post_team_to_avgper = post_team_to_allper.reduce({}) do |acc, kv|
      id = kv[0]
      avg = (kv[1].sum) / (kv[1].length).to_f

      acc[id] = [avg]
      acc
    end
  end

  def biggest_bust_id(season_id)
    x = reg_season_team_percentages(season_id)
    y = post_season_team_percentages(season_id)

    team_to_decrease = x.reduce({}) do |acc, regkv|
      if y.has_key?(regkv[0]) == true
        team_id = regkv[0]
        regper = regkv[1][0]
        postper = y[regkv[0]][0]
        if regper > postper
            acc[team_id] = (regper - postper)
        end
      end
      acc
    end

    biggest_decrease = team_to_decrease.max_by{|k, v| v}
    biggest_decrease[0]
  end


end


# winningest_coach	Name of the Coach with the best win percentage for
# the season	String

# biggest_bust	Name of the team with the biggest decrease between regular season
# and postseason win percentage.	String
