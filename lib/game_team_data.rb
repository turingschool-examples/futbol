require 'csv'

class GameTeamData
  attr_reader :game_teams
  def initialize
    @game_teams = []
  end

  def add_game_team
    games = CSV.open './data/game_teams.csv', headers: true, header_converters: :symbol
    games.each do |row|
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
      powerplayopportunities = row[:powerplayopportunities]
      powerplaygoals = row[:powerplayGoals]
      faceoffwinpercentage = row[:faceoffwinpercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      @game_teams << GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,powerplayopportunities,powerplaygoals,faceoffwinpercentage,giveaways,takeaways)
    end
  end
end