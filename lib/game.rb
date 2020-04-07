require "csv"

class Game
  @@all = nil

  def self.all
    @@all
  end

  def self.from_csv(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map { |row| Game.new(row) }
  end

  def self.average_goals_per_game
    sum = @@all.sum { |game| game.away_goals + game.home_goals}.to_f
    sum / @@all.length.to_f
  end

  # def self.total_goals_by(header_value)
  #   header = header_value.keys[0]
  #   value = header_value.values[0]
  #   range = @@all.find_all { |game| game.send(header) == value }
  #   total_goals = range.sum { |game| game.away_goals + game.home_goals }
  # end
  #
  def self.goals_by_season
    total_goals_by_season = Hash.new { |hash, key| hash[key] =  0}
    @@all.each do |game|
      total_goals_by_season[game.season] += game.away_goals + game.home_goals
    end
    total_goals_by_season
    binding.pry
  end
  #
  # def self.games_by_season
  #   total_games_by_season = Hash.new { |hash, key| hash[key] =  0}
  #   @@all.each do |game|
  #     total_games_by_season[game.season] += 1
  #   end
  #   total_games_by_season
  # end
  def self.games_per_season
    games_by_season = @@all.group_by { |game| game.season }
    games_per_season = games_by_season.values.map{ |games| games.length}
  end

  def self.total_goals_per_season

  end

  def self.average_goals_by_season
    seasons = @@all.map { |game| game.season}.uniq

    Game
  end



  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(game_stats)
    @game_id = game_stats[:game_id].to_i
    @season = game_stats[:season].to_i
    @type = game_stats[:type]
    @date_time = game_stats[:date_time]
    @away_team_id = game_stats[:away_team_id].to_i
    @home_team_id = game_stats[:home_team_id].to_i
    @away_goals = game_stats[:away_goals].to_i
    @home_goals = game_stats[:home_goals].to_i
    @venue = game_stats[:venue]
    @venue_link = game_stats[:venue_link]
  end

end
