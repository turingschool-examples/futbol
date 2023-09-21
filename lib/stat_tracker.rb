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

  def highest_total_score
    max = @games.map {|game| game.home_goals + game.away_goals }.max
  end

  def lowest_total_score
    min = @games.map {|game| game.home_goals + game.away_goals }.min
  end

  def percentage_home_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game.game_id
      @value_array = []
      @value1 = game.result
      @value2 = game.hoa
      @value_array << @value1
      @value_array << @value2
      hash[@key] = @value_array
    end
    @home_win = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "WIN" && hashy[1] == "home"
        @home_win += 1.00
      end
    end
    x = @home_win / @total_games
    (x * 100).round(2)
  end

  def percentage_visitor_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game.game_id
      @value_array = []
      @value1 = game.result
      @value2 = game.hoa
      @value_array << @value1
      @value_array << @value2
      hash[@key] = @value_array
    end
    @visitor_win = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "LOSS" && hashy[1] == "home"
        @visitor_win += 1.00
      end
    end
    x = @visitor_win / @total_games
    (x * 100).round(2)
  end

  def percentage_ties
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game.game_id
      @value_array = []
      @value1 = game.result
      @value2 = game.hoa
      @value_array << @value1
      @value_array << @value2
      hash[@key] = @value_array
    end
    @tie = 0.00
    hash.values.each do |hashy|
      if hashy[0] == "TIE" && hashy[1] == "home"
        @tie += 1.00
      end
    end
    x = @tie / @total_games
    (x * 100).round(2)
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