class Game
  @@all_games = []
  def self.from_csv(file_path)
      csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
      @@all_games = csv.map do |row|
        #require 'pry'; binding.pry
        game = Game.new(row)
        #require 'pry'; binding.pry
      end
  end

  def self.highest_total_score
    highest_score = @@all_games.max_by do |game|
      #require 'pry'; binding.pry
      (game.away_goals + game.home_goals)
    end
    sum = (highest_score.away_goals + highest_score.home_goals)
  end

  def self.lowest_total_score
    lowest_score = @@all_games.min_by do |game|
      #require 'pry'; binding.pry
      (game.away_goals + game.home_goals)
    end
    sum = (lowest_score.away_goals + lowest_score.home_goals)
  end

  def self.percentage_home_wins
    number_of_games = @@all_games.length
  home_wins =  @@all_games.select do |game|
      game.home_goals > game.away_goals
    end
    number_of_homewins = home_wins.length
    percent_home_wins = (number_of_homewins.to_f / number_of_games.to_f).round(2)
  end

  def self.percentage_visitor_wins
    number_of_games = @@all_games.length
  visitor_wins =  @@all_games.select do |game|
      game.home_goals < game.away_goals
    end
    number_of_visitor = visitor_wins.length
    percent_visitor_wins = (number_of_visitor.to_f / number_of_games.to_f).round(2)
  end

  def self.percentage_ties
    number_of_games = @@all_games.length
  ties =  @@all_games.select do |game|
      game.home_goals == game.away_goals
    end
    number_of_ties = ties.length
    percent_ties = (number_of_ties.to_f / number_of_games.to_f).round(2)
  end

  def self.all_games
    @@all_games
  end

  attr_reader :game_id, :season, :type, :date_time,
              :away_team_id, :home_team_id, :away_goals,
              :home_goals, :venue, :venue_link

  def initialize(info)
    @game_id = info[:game_id].to_i
    @season = info[:season]
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id].to_i
    @home_team_id = info[:home_team_id].to_i
    @away_goals = info[:away_goals].to_i
    @home_goals = info[:home_goals].to_i
    @venue = info[:venue]
    @venue_link = info[:venue_link]
  end

end
