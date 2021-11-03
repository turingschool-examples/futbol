class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id,
              :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(row)
    # take all the headers and turn them to instance variables/ attr readers
    # and call the keys as strings on the row hash argument
    # determine what TYPE each instance variable is. ids are probably INT
    # headers are values and rows hold the keys
    @game_id = row['game_id'].to_i
    @season = row['season'].to_i
    @type = row['type']
    @date_time = row['date_time']
    @away_team_id = row['away_team_id'].to_i
    @home_team_id = row['home_team_id'].to_i
    @away_goals = row['away_goals'].to_i
    @home_goals = row['home_goals'].to_i
    @venue = row['venue']
    @venue_link = row['venue_link']
  end

  def self.lowest_total_score(games)
    game = games.min_by { |game| game.total_score }
    game.total_score
  end

  def self.highest_total_score(games)
    game = games.max_by { |game| game.total_score }
    game.total_score
  end

  def total_score
    home_goals + away_goals
  end

  def won?
    home_goals > away_goals
  end

  def count_of_games_by_season end

  def count_of_teams; end
end
