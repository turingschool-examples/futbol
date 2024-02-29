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

  def percentage_home_wins
    total_game_count = self.games.length # 7441
    win_counter = 0 # 3237
    self.games.each do |game|
      if game.home_goals > game.away_goals
        win_counter += 1
      end
    end
    (win_counter / total_game_count.to_f).round(2)
  end

  def percentage_ties
    total_game_count = self.games.length # 7441
    tie_counter = 0 # 1517
    self.games.each do |game|
      if game.away_goals == game.home_goals
        tie_counter += 1
      end
    end
    (tie_counter / total_game_count.to_f).round(2)
  end

end