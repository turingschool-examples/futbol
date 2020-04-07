require 'CSV'
class Game
  @@all = []
  attr_reader :game_id, :season,
              :type, :date_time,
              :away_team_id, :home_team_id,
              :away_goals, :home_goals,
              :venue, :venue_link

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol )
    @@all = csv.map{|row| Game.new(row)}
  end

  def self.all
    @@all
  end

  def self.all_scores
    @@all.map { |game| game.away_goals + game.home_goals }
  end

  def self.highest_total_score
    all_scores.max
  end

  def self.lowest_total_score
    all_scores.min
  end

  def self.percentage_home_wins
    home_wins = @@all.find_all { |game| game.home_goals > game.away_goals}.count
    ( home_wins.to_f / @@all.length.to_f ).round(1) * 100
  end

  def self.percentage_visitor_wins
    visitor_wins = @@all.find_all { |game| game.home_goals < game.away_goals}.count
    ( visitor_wins.to_f / @@all.length.to_f ).round(1) * 100
  end

  def self.percentage_ties
    ties = @@all.find_all { |game| game.home_goals == game.away_goals}.count
    ( ties.to_f / @@all.length.to_f ).round(1) * 100
  end

  def self.count_of_games_by_season
    games_by_season = @@all.group_by { |game| game.season }
    games_by_season.transform_values { |games| games.length }
  end

  def initialize(game_details)
    @game_id = game_details[:game_id].to_i
    @season = game_details[:season]
    @type = game_details[:type]
    @date_time = game_details[:date_time]
    @away_team_id = game_details[:away_team_id].to_i
    @home_team_id = game_details[:home_team_id].to_i
    @away_goals = game_details[:away_goals].to_i
    @home_goals = game_details[:home_goals].to_i
    @venue = game_details[:venue]
    @venue_link = game_details[:venue_link]
  end

end
