require 'csv'
require 'simplecov'

SimpleCov.start

class TeamStats
  attr_reader :team_data
  def initialize(team_data)
    @team_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
    @team_info = CSV.parse(File.read("./data/teams.csv"), headers: true)
    @game_data  = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    @team_log = {}
    @team_info_log = {}
    @alpha_hash_3000 = {}
    team_info_log_method
  end

  def team_info_log_method
    @team_info.each do |game|
      if @team_info_log.keys.include? (game["team_id"])
        else
        @team_info_log[game["team_id"]] = [[game["franchiseId"]], [game["teamName"]], [game["abbreviation"]], [game["link"]]]
      end
    end
  end

  def team_info
    @team_info_log
  end

  # def season_log_method
  #   season_hash = {}
  #   @season_data.each do |game|
  #     if @alpha_hash_3000.keys.include? (game["season"])
  #     else
  #       @alpha_hash_3000[game["season"]] = [season_hash[game["team_id"]] = (game["head_coach"]), 0, 0, 0, 0, 0]
  #     end
  #     shots = (@alpha_hash_3000[game["team_id"]][3] += (game["shots"]).to_i)
  #     goals = (@alpha_hash_3000[game["team_id"]][4] += (game["goals"]).to_i)
  #     tackles = (@alpha_hash_3000[game["team_id"]][5] += (game["tackles"]).to_i)
  #     @alpha_hash_3000[game["team_id"]] = [(game["head_coach"]), 0, 0, shots, goals, tackles] #<<<<Helps understand hash
  #     #{[20122013 => {"3"=>["John Tortorella", 0, 5, 38, 8, 179], "6"=>["Claude Julien", 9, 0, 76, 24, 271], "5"=>["Dan Bylsma", 0, 4, 32, 2, 150], "17"=>["Mike Babcock", 4, 2, 40, 12, 181], "16"=>["Joel Quenneville", 2, 4, 50, 8, 142]}
  #   end
  #   require "pry"; binding.pry
  #   win_loss_counter
  # end

  def win_loss_counter
    @season_data.each do |game|
      if game["result"] == "WIN"
        @season_log[game["team_id"]][1] += 1
      else
        @season_log[game["team_id"]][2] += 1
      end
    end
  end
end
