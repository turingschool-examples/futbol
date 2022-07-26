require 'csv'

class StatTracker
 attr_reader :data

  def initialize(filepath)
    @data = CSV.read(filepath, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    locations.map {|key, filepath| [key, StatTracker.new(filepath)]}.to_h
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
