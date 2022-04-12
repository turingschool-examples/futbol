require 'csv'
require 'pry'
class StatTracker

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = create_game_teams(game_teams)
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
    stat_tracker1 = self.new(games, teams, game_teams)
    # require "pry";binding.pry
  end

  def create_game_teams(game_teams)
    game_team_array = []
    game_teams.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      power_play_opportunities = row[:power_play_opportunities]
      power_play_goals = row[:power_play_goals]
      face_off_win_percentage = row[:face_off_win_percentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      # binding.pry
      game_team_array << GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,power_play_opportunities,power_play_goals,face_off_win_percentage,giveaways,takeaways)
    end
    return game_team_array
  end

end
