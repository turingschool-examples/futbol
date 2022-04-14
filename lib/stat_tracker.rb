require 'CSV'
class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(data1, data2, data3)
    @teams = data2
    @games = data1
    @game_teams = data3
  end

  def self.from_csv(locations)
    data = []
    locations.values.each do |location|
      contents = CSV.read "#{location}", headers: true, header_converters: :symbol
      data << contents
      end
      StatTracker.new(data[0], data[1], data[2])
  end

  def highest_total_score
    sum = []
    @games.each do |row|
      i = row[:away_goals].to_i + row[:home_goals].to_i
      sum << i
    end
    sum.max
  end

  def lowest_total_score
    sum = []
    @games.each do |row|
      i = row[:away_goals].to_i + row[:home_goals].to_i
      sum << i
    end
    sum.min
  end































































  #SAI



































































































  #COLIN
  def average_goals_per_game
    goals = []
    @games.each do |row|
      i = row[:away_goals].to_f + row[:home_goals].to_f
      goals << i
    end
    (goals.sum / goals.count).round(2)
  end

  def average_goals_by_season
    average_by_season = {}
    season_hash = @games.group_by { |row| row[:season].itself }
    # season_hash.except(:away_goals, :home_goals)
    season_hash.each do |season, games|
      counter = 0
      game = 0
      games.each do |key|
        counter += (key[:away_goals].to_i + key[:home_goals].to_i)
        game += 1
      end
        average_by_season.merge!(season => (counter.to_f/game.to_f))
        require 'pry'; binding.pry
        # if data == :away_goals || :home_goals
        #   average_by_season.merge!(season => key)
        #
        # end

    end
  end

































































































  #THIAGO



































































































  #STEPHEN



































































































end
