require 'csv'
class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = create_games(locations[:games])
    @teams = create_teams(locations[:teams])
    @game_teams = create_game_teams(locations[:game_teams])
  end

  def create_games(game_path)
    games = []
    CSV.foreach(game_path, headers: true, header_converters: :symbol ) do |info|
      game = info.to_h
      game[:away_goals] = game[:away_goals].to_i
      game[:home_goals] = game[:home_goals].to_i
      games << game
    end
    games
  end

  def create_teams(team_path)
    teams = []
    CSV.foreach(team_path, headers: true, header_converters: :symbol ) do |info|
      teams << info.to_h
    end
    teams
  end

  def create_game_teams(game_teams_path)
    game_teams = []
    CSV.foreach(game_teams_path, headers: true, header_converters: :symbol ) do |info|
      game_team = info.to_h
      game_team[:goals] = game_team[:goals].to_i
      game_team[:shots] = game_team[:shots].to_i
      game_team[:tackles] = game_team[:tackles].to_i
      game_team[:pim] = game_team[:pim].to_i
      game_team[:powerplayopportunities] = game_team[:powerplayopportunities].to_i
      game_team[:powerplaygoals] = game_team[:powerplaygoals].to_i
      game_team[:faceoffwinpercentage] = game_team[:faceoffwinpercentage].to_f
      game_team[:giveaways] = game_team[:giveaways].to_i
      game_team[:takeaways] = game_team[:takeaways].to_i
      game_teams << game_team
    end
    game_teams
  end

  def self.from_csv(locations)
    new(locations)
  end

  def highest_total_score
    games_total_scores_array.max
  end

  def lowest_total_score
    games_total_scores_array.min
  end

  def games_total_scores_array
    @games.map { |game| game[:away_goals] + game[:home_goals] }
  end
end