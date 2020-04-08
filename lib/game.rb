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
    (sum / @@all.length.to_f).round(2)
  end

  def self.games_per(header)
    group_by_header = @@all.group_by { |game| game.send(header) }
    group_by_header.values.map{ |games| games.length}
  end

  def self.goals_per(header)
    group_by_header = @@all.group_by { |game| game.send(header) }
    group_by_header.values.map do |games|
      games.sum { |game| (game.away_goals + game.home_goals)}
    end
  end

  def self.average_goals_per(header)
    goals_per(header).each_with_index.map do |goals, index|
      (goals.to_f/games_per(header)[index].to_f).round(2)
    end
  end

  def self.average_goals_by_season
    seasons = @@all.map { |game| game.season}.uniq
    Hash[seasons.zip(Game.average_goals_per(:season))]
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
