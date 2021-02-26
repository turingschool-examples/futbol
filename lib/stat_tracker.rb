require './manager/team_manager'
require './manager/game_team_manager'
require './manager/game_manager'

class StatTracker

  # attr_reader
  # def self.from_csv(locations)
  #   StatTracker.new(locations)
  # end

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games])
    require "pry";binding.pry
  end

  def highest_total_score
    #        game object               tack on total_score
    @game_manager.highest_scoring_game.total_score
  end

<<<<<<< HEAD
  def lowest_total_score
    #        game object               tack on total_score
    @game_manager.lowest_scoring_game.total_score
  end

  def percentage_home_wins
    @game_manager.calculate_percentage_home_wins
  end

  def percentage_visitor_wins
    @game_manager.calculate_percentage_away_wins
  end

  def percentage_ties
    @game_manager.calculate_percentage_ties
  end

  def count_of_games_by_season
    @game_manager.number_of_season_games
  end

  def average_goals_per_game
    @game_manager.average_goals_per_match
  end

=======
>>>>>>> main

  # def self.from_csv(locations)
  #   # require "pry";binding.pry
  #   # data = locations.map do |key, path|
  #     CSV.foreach(path, :headers => true,
  #     header_converters: :symbol) do |row|
  #       # require "pry";binding.pry
  #       if key == :games
  #         GameManager.new(row)
  #         # require "pry"; binding.pry
  #       elsif key == :teams
  #         TeamManager.new(row)
  #       else
  #         GameTeamManager.new(row)
  #       end
  #     end
  #   # end
  #   data
  #   require "pry";binding.pry
  # end

  # def initialize(teams, games, game_teams)
  #   @teams = teams
  #   @games = games
  #   @game_teams = @game_teams
  #   @seasons = seasons
  # end

  # def self.from_csv(locations)
  #   # require "pry";binding.pry
  #   locations.each do |key, path|
  #     CSV.foreach(path, :headers => true,
  #     header_converters: :symbol) do |row|
  #       if key == :games
  #         GameManager.new(row)
  #         # require "pry"; binding.pry
  #       elsif key == :teams
  #         TeamManager.new(row)
  #       else
  #         GameTeamManager.new(row)
  #       end
  #     end
  #   end
  # end

end
