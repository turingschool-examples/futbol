require_relative './game_team'
require 'CSV'

class GameTeamsCollection
  attr_reader :game_teams
  def initialize(file_path)
    @game_teams = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:HoA]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      powerplayopportunities = row[:powerPlayOpportunities]
      powerplaygoals = row[:powerPlayGoals]
      faceoffwinpercentage = row[:faceOffWinPercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      @game_teams << GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,powerplayopportunities,powerplaygoals,faceoffwinpercentage,giveaways,takeaways)
    end
  end

  def goals_by_team
    total_goals = Hash.new(0)
    game_teams.each do |game_team|
      total_goals[game_team.team_id] += game_team.goals
    end
    total_goals
  end

  def best_offense
    goals_by_team.max_by do |goals|
      goals[-1]
    end
  end
end
