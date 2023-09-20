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
    stat_tracker.game_teams.each do |game|
      @key = game[:game_id].to_i
      @value_array = []
      @value2 = game[:hoa]
      @value1 = game[:goals].to_f
      @value_array << @value1
      @value_array << @value2
      if hash.values.first == nil
        hash[@key] = @value_array
      elsif hash.values.flatten.first < @value1
        hash[@key] = @value_array
      else
        hash
      end
    end
    @home_win = 0
    @total_games = 0
    hash.values.each do |winner|
      if winner[1] == "home"
        @home_win += 1.0
        @total_games += 1.0
      else
        @total_games += 1.0
      end
    end
    @home_win / @total_games
  end
end
