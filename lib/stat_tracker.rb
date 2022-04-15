require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'


class StatTracker

attr_reader :games, :team, :game_teams

  def initialize(locations)
    @games = read_and_create_games(locations[:games])
    @teams = read_and_create_teams(locations[:teams])
    @game_teams = read_and_create_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  def read_and_create_games(games_csv)
    games_array = []
    CSV.foreach(games_csv, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def read_and_create_teams(teams_csv)
    teams_array = []
    CSV.foreach(teams_csv, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def read_and_create_game_teams(game_teams_csv)
    game_teams_array = []
    CSV.foreach(game_teams_csv, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end

  ## GAME STATISTICS

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end



  ## SEASON STATISTICS : All methods return Strings

  def count_coaches
# So this is actually count_of_games_by_season
    total_coaches = @game_teams.group_by { |coach| coach.head_coach[0..].to_str }.transform_values { |values| values.count }
  end



  def winningest_coach
# Name of the Coach with the best win percentage for the season
# Wins of coach / Total instances of each coach
  total_coaches = @game_teams.group_by { |coach| coach.head_coach[0..].to_str }.transform_values { |values| values.count }#.sort_by(&:first)
  # => [["Claude Julien", 9],
  #     ["Dan Bylsma", 4],
  #     ["Joel Quenneville", 1],
  #     ["John Tortorella", 5],
  #     ["Mike Babcock", 1]]
  winning_coaches = []
  win_loss_hash = @game_teams.group_by { |win_loss| win_loss.result[0..].to_s}
    win_loss_hash.each do |k, v|
      if k == "WIN"
        v.each do |coach|
          winning_coaches << coach.head_coach
        end
      end
    end
    coach_by_percent = Hash.new
    winners_hash = winning_coaches.group_by { |coach| coach[0..]}.transform_values { |v| v.count}
    # require 'pry'; binding.pry
    winners_hash.each do |k, v|
      coach_by_percent[k] = v / total_coaches[k] * 100
    end
    winner =  coach_by_percent.find { |k, v| v == coach_by_percent.values.max }
    winner.first
  end

  def worst_coach
# Name of the Coach with the worst win percentage for the season

  end

  def most_accurate_team
    # Name of the Team with the best ratio of shots to goals for the season

  end

  def least_accurate_team
    # Name of the Team with the worst ratio of shots to goals for the season

  end

  def most_tackles
    # Name of the Team with the most tackles in the season

  end

  def fewest_tackles
    # Name of the Team with the fewest tackles in the season

  end

end
