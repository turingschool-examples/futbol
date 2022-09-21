require_relative "id.rb"
require 'pry'
include Id
class Team
  attr_reader :team_data, :game_teams_data, :games_data

  def initialize(teams_data, game_teams_data, games_data)
    @teams_data = teams_data
    @game_teams_data = game_teams_data
    @games_data = games_data
  end
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
    end
    total_games = (win_count + loss_count)
    (win_count.to_f / total_games.to_f).round(2)
  end

  def most_goals_scored(team)
    score_array = []
    @games_data.map do |row|
      if row[:away_team_id] == team
        score_array << row[:away_goals]
      elsif row[:home_team_id] == team
        score_array << row[:home_goals]
      end
    end
    score_array.sort!
    score_array.pop.to_i
  end

  def fewest_goals_scored(team)
    score_array = []
    @games_data.map do |row|
      if row[:away_team_id] == team
        score_array << row[:away_goals]
      elsif row[:home_team_id] == team
        score_array << row[:home_goals]
      end
    end
    score_array.sort!
    score_array.shift.to_i
  end

  def favorite_opponent(team)
    win_loss_hashes
    min_win_rate = 100
    min_win_rate_team = nil
    team_wins.each do |key, value|
      next unless key != team

      total_games = value + team_losses[key]
      win_rate = value.to_f / total_games
      if win_rate < min_win_rate
        min_win_rate = win_rate
        min_win_rate_team = key
      end
    end
    team_name_from_id_average(min_win_rate_team.split)
  end

  def rival(team)
    max_win_rate = 0
    max_win_rate_team = nil
    team_wins.each do |key, value|
      next unless key != team

      total_games = value + team_losses[key]
      win_rate = value.to_f / total_games
      if win_rate > max_win_rate
        max_win_rate = win_rate
        max_win_rate_team = key
      end
    end
    team_name_from_id_average(max_win_rate_team.split)
  end
  def win_loss_hashes(team)
    team_wins = Hash.new(0)
    team_losses = Hash.new(0)
    @games_data.map do |row|
      if row[:away_team_id] == team
        if row[:away_goals] >= row[:home_goals]
          team_losses[row[:home_team_id]] += 1
          if !team_wins.include?(row[:home_team_id])
            team_wins[row[:home_team_id]] += 0
          end
        else
          team_wins[row[:home_team_id]] += 1
        end
      elsif row[:home_team_id] == team
        if row[:home_goals] >= row[:away_goals]
          team_losses[row[:away_team_id]] += 1
          if !team_wins.include?(row[:home_team_id])
            team_wins[row[:home_team_id]] += 0
          end
        else
          team_wins[row[:away_team_id]] += 1
        end
      end
    end
    team_wins
    team_losses
  end
end