require './lib/game_teams'
require './lib/team_stats'

module LeagueStats

  def count_of_teams
    teams = TeamStats.create_list_of_teams(@teams)
    teams.map { |team| team.length}
  end

  def best_offense
    game_teams = GameTeams.create_list_of_games(@game_teams)
    scores = []
    game_teams.each do |team_id, goals|
      scores << goals.sum / goals.length if team_id == team_id
    end
    scores.sort[-1]
  end

  def worst_offense
    game_teams = GameTeams.create_list_of_games(@game_teams)
    scores = []
    game_teams.each do |team_id, goals|
      scores << goals.sum / goals.length if team_id == team_id
    end
    scores[0]
  end

  def highest_scoring_visitor
    game_teams = GameTeams.create_list_of_games(@game_teams)
    scores = []
      scores << goals.sum / goals.length if team_id == team_id && if hoa == hoa
    end
    scores.sort[-1]
  end




end
