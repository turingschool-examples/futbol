require 'csv'

class Game

  @@all = []

  def self.create_games(csv_file_path)
    csv = CSV.read(csv_file_path, headers: true, header_converters: :symbol)

    all_games = csv.map do |row|
      Game.new(row)
    end

    @@all = all_games
  end

  def self.all
    @@all
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

  def initialize(game_parameter)
    @game_id  = game_parameter[:game_id].to_i
    @season = game_parameter[:season].to_i
    @type = game_parameter[:type]
    @date_time = game_parameter[:date_time]
    @away_team_id = game_parameter[:away_team_id].to_i
    @home_team_id = game_parameter[:home_team_id].to_i
    @away_goals = game_parameter[:away_goals].to_i
    @home_goals = game_parameter[:home_goals].to_i
    @venue = game_parameter[:venue]
    @venue_link = game_parameter[:venue_link]
  end

  def highest_total_score
    @@all.map { |game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @@all.map { |game| game.away_goals + game.home_goals}.min
  end

  def biggest_blowout
    @@all.map { |game| (game.away_goals - game.home_goals).abs}.max
  end
end
