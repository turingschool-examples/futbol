class Game

  @@all = []

  def self.all
   @@all
  end

  attr_reader :id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(game_info)
    @id = game_info[:game_id].to_i
    @season = game_info[:season].to_i
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
    @venue_link = game_info[:venue_link]
    @@all << self
  end

  # def create_stat_hash(array)
  #
  # end

  def total_score
    @away_goals + @home_goals
  end

  def score_difference
    (@home_goals - @away_goals).abs
  end
  def winner
    return @home_team_id if @home_goals > @away_goals
    return @away_team_id if @away_goals > @home_goals
    return nil
  end

  def highest_score
    Game.all.max_by {|game| game.total_score}
  end

  def lowest_score
    Game.all.min_by {|game| game.total_score}
  end

  def biggest_blow_out
    Game.all.max_by {|game| game.score_difference}
  end

  def percent_home_wins
    home_wins = Game.all.find_all do |game|
      game.home_goals > game.away_goals
    end
    return ((home_wins.length.to_f/Game.all.length) * 100).round(2)
  end

  def percent_away_wins
    away_wins = Game.all.find_all do |game|
      game.away_goals > game.home_goals
    end
    return ((away_wins.length.to_f/Game.all.length) * 100).round(2)
  end

  def percent_ties
      ties = Game.all.find_all do |game|
        game.winner == nil
      end
      return ((ties.length.to_f/Game.all.length) * 100).round(2)
  end

  def average_goals_per_game
    total_goals = Games.all.map {|game| game.total_score}
    return ((total_goals.sum.to_f / Game.all.length) * 100.round(2))
  end

end
