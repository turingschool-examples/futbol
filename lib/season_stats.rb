require 'csv'
require 'simplecov'

SimpleCov.start

class SeasonStats
  attr_reader :season_data
  def initialize(season_data)
    @season_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
    @season_log = {}
    @total_games_per_season = 0
    season_log_method
  end

  def season_log_method
    @season_data.each do |game|
        if game["HoA"] == "home"
          @total_games_per_season += 1
        end
        if @season_log.keys.include? (game["team_id"])
        else
          @season_log[game["team_id"]] = [(game["head_coach"]), 0, 0, 0, 0, 0]
        end
        shots = (@season_log[game["team_id"]][3] += (game["shots"]).to_i)
        goals = (@season_log[game["team_id"]][4] += (game["goals"]).to_i)
        tackles = (@season_log[game["team_id"]][5] += (game["tackles"]).to_i)
        @season_log[game["team_id"]] = [(game["head_coach"]), 0, 0, shots, goals, tackles] #<<<<Helps understand hash
      end
      win_loss_counter
    end

    def win_loss_counter
      @season_data.each do |game|
        if game["result"] == "WIN"
          @season_log[game["team_id"]][1] += 1
        else
          @season_log[game["team_id"]][2] += 1
        end
      end
    end

    def winningest_coach #best win % of season (gameswon/totalgames)
      win_percentage = 0.0
      winningest_coach = nil
      @season_log.each do |team|
        if team[1][1] / (team[1][2] + team[1][1]).to_f > win_percentage
          winningest_coach = team[1][0]
          win_percentage = 100 * (team[1][1] / (team[1][2] + team[1][1])).to_f
        else
        end
      end
      winningest_coach
    end

    def worst_coach #worst win % of season (gameswon/totalgames)
      win_percentage = 100.0
      worst_coach = nil
      @season_log.each do |team|
        if team[1][1] / (team[1][2] + team[1][1]).to_f < win_percentage
          worst_coach = team[1][0]
          win_percentage = 100 * (team[1][1] / (team[1][2] + team[1][1])).to_f
        else
        end
      end
      worst_coach
    end

    def most_accurate_team #best ratio of shots to goals for the season
      accuracy = 0.0
      most_accurate_team_id = nil
      @season_log.each do |team|
        if team[1][4] / (team[1][3]).to_f > accuracy
          most_accurate_team_id = team[0]
          accuracy = 100 * team[1][4] / (team[1][3]).to_f
        else
        end
      end
      most_accurate_team_id
    end

    def least_accurate_team #worst ratio of shots to goals for the season
      accuracy = 100.0
      least_accurate_team_id = nil
      @season_log.each do |team|
        if team[1][4] / (team[1][3]).to_f < accuracy
          least_accurate_team_id = team[0]
          accuracy = 100 * team[1][4] / (team[1][3]).to_f
        else
        end
      end
      least_accurate_team_id
    end

    def most_tackles #most tackles in the season
      tackle_max = 0
      most_tackles_team_id = nil
      @season_log.each do |team|
        if team[1][5] > tackle_max
          tackle_max = team[1][5]
          most_tackles_team_id = team[0]
        else
        end
      end
      most_tackles_team_id
    end

    def fewest_tackles #fewest tackles in the season
      tackle_max = 1000
      fewest_tackles_team_id = nil
      @season_log.each do |team|
        if team[1][5] < tackle_max
          tackle_min = team[1][5]
          fewest_tackles_team_id = team[0]
        else
        end
      end
      fewest_tackles_team_id
    end
  end
