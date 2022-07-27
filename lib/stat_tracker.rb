require 'csv'

class StatTracker
 attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end

  def winningest_coach
    coaches_and_results = @data[:result].zip @data[:head_coach]
    wins = Hash.new(0)
    losses = Hash.new(0)
    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      losses[coach] += 1 if result == "LOSS"
    end
    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / (losses[coach] + num_wins)
    end

    win_percentage.max_by{|coach, percentage| percentage}.first
  end

  def worst_coach
    coaches_and_results = @data[:result].zip @data[:head_coach]
    wins = Hash.new(0)
    losses = Hash.new(0)
    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      losses[coach] += 1 if result == "LOSS"
    end
    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / (losses[coach] + num_wins)
    end

    win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  


end
