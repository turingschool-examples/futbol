require "csv"
class StatTracker
  attr_reader :teams, :games, :game_teams 
  def initialize(content)
    @teams = CSV.readlines(content[:teams], headers: true, header_converters: :symbol)
    @games = CSV.readlines(content[:games], headers: true, header_converters: :symbol)
    @game_teams = CSV.readlines(content[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    # content = {}
    # content[:teams] = CSV.readlines(locations[:teams], headers: true, header_converters: :symbol),
    # content[:games] = CSV.readlines(locations[:games], headers: true, header_converters: :symbol),
    # content[:game_teams] = CSV.readlines(locations[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(locations)
  end
##in pry you can then do stat_tracker[:team_id] and it will print stuff

  def highest_total_score
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @game_teams.each do |game|
      #instead of [:game_id], game.game_id
      key = game[:game_id].to_i
      #instead of [:goals], game.goals
      value = game[:goals].to_i
      hash[key] << value
    end
    sums = hash.values.map do |pair|
      pair.sum
    end
    sums.max
  end

  def lowest_total_score
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @game_teams.each do |game|
      key = game[:game_id].to_i
      value = game[:goals].to_i
      hash[key] << value
    end
    sum = hash.values.map do |pair|
      pair.sum
    end
    sum.min
  end

  def percentage_home_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    #stat_tracker.game_teams.each do |game|
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game[:game_id].to_i
      @value_array = []
      @value1 = game[:result]
      @value2 = game[:hoa]
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
    x.round(2)
  end

  def percentage_visitor_wins
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    #stat_tracker.game_teams.each do |game|
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game[:game_id].to_i
      @value_array = []
      @value1 = game[:result]
      @value2 = game[:hoa]
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
    x.round(2)
  end

  def percentage_ties
    hash = Hash.new{ |hash, key| hash[key] = [] }
    @total_games = 0
    #stat_tracker.game_teams.each do |game|
    @game_teams.each do |game|
      @total_games += 0.50
      @key = game[:game_id].to_i
      @value_array = []
      @value1 = game[:result]
      @value2 = game[:hoa]
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
    x.round(2)
  end
end
