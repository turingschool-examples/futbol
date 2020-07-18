require 'csv'

class StatTracker

  attr_reader :data
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end

  def games_coached(season_id)
    coaches = []
    season = CSV.read(@data[:games], headers: true, header_converters: :symbol).find_all {|row| row[:season] == season_id}
    games = CSV.read(@data[:game_teams], headers: true, header_converters: :symbol)
    season.each do |season|
      games.each do |game|
        if season[:game_id] == game[:game_id]
          coaches << game[:head_coach]
        end
      end
    end
    games_coached = Hash.new(0)
    coaches.each {|coach| games_coached[coach] += 1}
    games_coached
  end


end
