class StatTracker
  attr_reader :games, :teams, :game_teams
  
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def self.from_csv(locations)
    games = Game.create_from_csv(locations[:games])
    teams = Team.create_from_csv(locations[:teams])
    game_teams = GameTeam.create_from_csv(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def find_team_name_by_id(team_id)
    Team.find_team_name_by_id(team_id)
  end

  def self.highest_scoring_home_team 
    find_team_name_by_id(GameTeam.scores_per_team_home.max_by {|team_id, goals| goals}.first)
  end

  def self.lowest_scoring_home_team
    find_team_name_by_id(GameTeam.scores_per_team_home.min_by {|team_id, goals| goals}.first)
  end
end