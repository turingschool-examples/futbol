require 'csv'
require 'simplecov'

SimpleCov.start

class TeamStats
  attr_reader :team_data
  def initialize(team_data)
    @team_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
    @team_info = CSV.parse(File.read("./data/teams.csv"), headers: true)
    @team_log = {}
    @team_info_log = {}
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

  def season_log_method
    
  end

  def team_info
    @team_info_log
  end
end
