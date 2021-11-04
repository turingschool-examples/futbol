require 'csv'
require 'simplecov'

SimpleCov.start

class SeasonStats
  attr_reader :season_data
  def initialize(season_data)
    @season_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
    @season_log = {}
    season_log_method
  end

  def winningest_coach
  end

  def season_log_method
    @total_games_per_season = 0
    @season_data.each do |season|
        if season["HoA"] == "home"
          @total_games_per_season += 1
        end

        if @season_log.keys.include? (season["team_id"])
        else
          @season_log[season["team_id"]] = [(season["head_coach"]), 0, 0, 0, 0, 0]
        end

        win_count = 0
        if season["result"] == "WIN"
          win_count += 1
        end

        lose_count = 0
        if season["result"] == "LOSE"
          lose_count += 1
        end

        shots = (@season_log[season["team_id"]][3] += (season["shots"]).to_i)
        goals = (@season_log[season["team_id"]][4] += (season["goals"]).to_i)
        tackles = (@season_log[season["team_id"]][5] += (season["tackles"]).to_i)

        @season_log[season["team_id"]] = [(season["head_coach"]), win_count, lose_count, shots, goals, tackles]
      end
      require "pry"; binding.pry
    end
    #I need coach,
    #win_percent(win count,loss count),
    #shot/goal ratio,
    #and tackles

    #AAAAAALLL IN ONE BIG HASH
  end
