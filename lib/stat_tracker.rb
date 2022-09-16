require 'csv'
require 'pry'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # game class
  def highest_total_score
    @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    wins = 0
    @games_data.each do |row|
      wins += 1 if row[:away_goals].to_i < row[:home_goals].to_i
    end
    (wins.to_f / games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins = 0
    @games_data.each do |row|
      wins += 1 if row[:away_goals].to_i > row[:home_goals].to_i
    end
    (wins.to_f / games_data.count).round(2)
  end

  def percentage_ties
    ties = 0
    @games_data.each do |row|
      ties += 1 if row[:away_goals].to_i == row[:home_goals].to_i
    end
    (ties.to_f / games_data.count).round(2)
  end
  # end of game class

  # league statistics

  # team class

  def team_info(index)
    team_info_hash = {}
    @teams_data.map do |row|
      next unless row[:team_id] == index

      team_info_hash[:team_id.to_s] = row[:team_id]
      team_info_hash[:franchise_id.to_s] = row[:franchiseid]
      team_info_hash[:team_name.to_s] = row[:teamname]
      team_info_hash[:abbreviation.to_s] = row[:abbreviation]
      team_info_hash[:link.to_s] = row[:link]
    end
    team_info_hash
  end
  # def best_season(team)
  #   @games_data.map do |row|
  #     if row[:team_id] == team
  #       if row[:result] == WIN
  #         row[:seasonid] += 1
  #       end
  #     end
  #   end

  # end
  # def worst_season
  # end
  def average_win_percentage(team)
    win_count = 0
    loss_count = 0
    total_games = 0
    @games_data.map do |row|
      if row[:away_team_id] == team
        if row[:away_goals] > row[:home_goals]
          win_count += 1
        else
          loss_count += 1
        end
      elsif row[:home_team_id] == team
        if row[:home_goals] > row[:away_goals]
          win_count += 1
        else
          loss_count += 1
        end
      end
      total_games = (win_count + loss_count)
      win_count / total_games
    end
    def most_goals_scored
      @games_data.map do |row|
      end
    end

    def fewest_goals_scored; end

    def favorite_opponent; end

    def rival
    end
    # end of team class
  end
end
