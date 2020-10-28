require 'csv'
require_relative './game_teams'

class GameTeamsManager
  attr_reader :game_teams_data,
              :game_teams

  def initialize(file_location)
    @game_teams_data = file_location
    @game_teams = []
  end

  def all
    CSV.foreach(@game_teams_data, headers: true, header_converters: :symbol) do |row|
        game_team_attributes = {
                          game_id: row[:game_id],
                          team_id: row[:team_id],
                          HoA:     row[:HoA],
                          result:  row[:result],
                          settled_in: row[:settled_in],
                          head_coach: row[:head_coach],
                          goals:      row[:goals],
                          shots:      row[:shots],
                          tackles:    row[:tackles],
                          pim:        row[:pim],
                          powerPlayOpportunities: row[:powerPlayOpportunities],
                          powerPlayGoals:         row[:powerPlayGoals],
                          faceOffWinPercentage:   row[:faceOffWinPercentage],
                          giveaways: row[:giveaways],
                          takeaways: row[:takeaways]
                        }
      @game_teams << GameTeam.new(game_team_attributes)
    end
    @game_teams
  end

  def goals_by_team
    id_by_goals = Hash.new {|hash, key| hash[key] = 0}
    @game_teams.each do |game_team|
      if id_by_goals[game_team.team_id]
        id_by_goals[game_team.team_id] += game_team.goals
      else
        id_by_goals[game_team.team_id] = game_team.goals
      end
    end
    id_by_goals
  end

  def game_count(team_id)
    @game_teams.count do |game|
      game.team_id == team_id
    end
  end

  def best_offense
    hash = {}
    goals_by_team.map do |team_id, goals|
      hash[team_id] = (goals.to_f / game_count(team_id)).round(2)
    end
    hash.max_by do |team_id, average_goals|
      average_goals
    end.first
  end
end
