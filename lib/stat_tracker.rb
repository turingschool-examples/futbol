require "csv"
class StatTracker
  attr_reader :teams,
              :games,
              :game_teams

  def initialize(content)
    @teams = content[:teams]
    @games = content[:games]
    @game_teams = content[:game_teams]
  end

  def self.from_csv(locations)
    # convert each CSV into an array of associated instance objects, ie. teams_arry holds an array of Team objects
    teams_arry = CSV.readlines(locations[:teams], headers: true, header_converters: :symbol).map { |team| Team.new(team) }
    games_arry = CSV.readlines(locations[:games], headers: true, header_converters: :symbol).map { |game| Game.new(game) }
    game_teams_arry = CSV.readlines(locations[:game_teams], headers: true, header_converters: :symbol).map { |game_team| GameTeam.new(game_team)}
    # combine all arrays to be stored in a Hash so we can easily call each array
    contents = {
      teams: teams_arry,
      games: games_arry,
      game_teams: game_teams_arry
    }
    # pass contents hash on to StatTracker to initiate the class.
    StatTracker.new(contents)
  end

  # original from_csv left for reference
  # def self.from_csv(locations)
  #   content = {}
  #   content[:teams] = CSV.readlines(locations[:teams], headers: true, header_converters: :symbol),
  #   content[:games] = CSV.readlines(locations[:games], headers: true, header_converters: :symbol),
  #   content[:game_teams] = CSV.readlines(locations[:game_teams], headers: true, header_converters: :symbol)
  #   StatTracker.new(content)
  ## in pry you can then do stat_tracker[:team_id] and it will print stuff
  # end
end