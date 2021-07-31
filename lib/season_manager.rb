require './lib/season'
require 'pry'
class SeasonManager

  attr_reader :seasons_hash

  def initialize(seasons, games, game_teams)
    @seasons_hash = {}
    create_seasons(seasons, games, game_teams)
  end

  def create_seasons(seasons, games, game_teams)
    fill_season_ids(seasons)
    @seasons_hash.each do |season_id, season|
      games.each do |game_id, game|
        # edge case for nil vals here?
        if game.season == season_id
          @seasons_hash[season_id].add_game(game_id, game, game_teams[game_id][:home], game_teams[game_id][:away])
        end
      end
    end
  end

  def fill_season_ids(seasons)
    seasons.each do |season|
      @seasons_hash[season] ||= Season.new
    end
  end

  def create_coach(coach_wins, game_data, hoa)
    coach_wins[game_data[hoa].head_coach] = {total_games: 0, total_wins: 0}
  end

  def add_coach_data(coach_wins, game_data)
    if game_data[:away].result == 'WIN'
      coach_wins[game_data[:home].head_coach][:total_games] += 1
      coach_wins[game_data[:away].head_coach][:total_games] += 1
      coach_wins[game_data[:away].head_coach][:total_wins] += 1
    else
      coach_wins[game_data[:away].head_coach][:total_games] += 1
      coach_wins[game_data[:home].head_coach][:total_games] += 1
      coach_wins[game_data[:home].head_coach][:total_wins] += 1
    end
  end

  def winningest_coach(season)
    coach_wins = {}
    @seasons_hash[season].games.each do |game_id, game_data|
      # if game_data[:home].result == 'WIN'
      if coach_wins[game_data[:home].head_coach].nil? && coach_wins[game_data[:away].head_coach].nil?
        create_coach(coach_wins, game_data, :home)
        create_coach(coach_wins, game_data, :away)
        add_data(coach_wins, game_data)
      elsif coach_wins[game_data[:home].head_coach].nil?
        create_coach(coach_wins, game_data, :home)
        add_data(coach_wins, game_data)
      elsif coach_wins[game_data[:away].head_coach].nil?
        create_coach(coach_wins, game_data, :away)
        add_data(coach_wins, game_data)
      else
        add_data(coach_wins, game_data)
      end
    end
    coach_wins.max_by do |coach, coach_data|
      coach_data[:total_wins] / coach_data[:total_games]
    end[0]
  end

  def worst_coach(season)
    coach_wins = {}
    @seasons_hash[season].games.each do |game_id, game_data|
      # if game_data[:home].result == 'WIN'
      if coach_wins[game_data[:home].head_coach].nil? && coach_wins[game_data[:away].head_coach].nil?
        create_coach(coach_wins, game_data, :home)
        create_coach(coach_wins, game_data, :away)
        add_data(coach_wins, game_data)
      elsif coach_wins[game_data[:home].head_coach].nil?
        create_coach(coach_wins, game_data, :home)
        add_data(coach_wins, game_data)
      elsif coach_wins[game_data[:away].head_coach].nil?
        create_coach(coach_wins, game_data, :away)
        add_data(coach_wins, game_data)
      else
        add_data(coach_wins, game_data)
      end
    end
    coach_wins.min_by do |coach, coach_data|
      coach_data[:total_wins] / coach_data[:total_games]
    end[0]
  end

  def most_accurate_team(season, teams_by_id)
    most_accurate = {}
    @seasons_hash[season].games.each do |game_id, game_data|
      if most_accurate[game_data[:home].team_id].nil? && most_accurate[game_data[:away].team_id].nil?
        create_team_id(most_accurate, game_data, :home)
        create_team_id(most_accurate, game_data, :away)
        add_goals_data(most_accurate, game_data)
      elsif most_accurate[game_data[:home].team_id].nil?
        create_team_id(most_accurate, game_data, :home)
        add_goals_data(most_accurate, game_data)
      elsif most_accurate[game_data[:away].team_id].nil?
        create_team_id(most_accurate, game_data, :away)
        add_goals_data(most_accurate, game_data)
      else
        add_goals_data(most_accurate, game_data)
      end
    end
    most = most_accurate.max_by do |team_id, goals_data|
      goals_data[:total_shots] / goals_data[:total_goals]
    end[0]

    teams_by_id[most]

  end

  def add_goals_data(most_accurate, game_data)
    most_accurate[game_data[:home].team_id][:total_goals] += game_data[:home].goals.to_i
    most_accurate[game_data[:away].team_id][:total_goals] += game_data[:away].goals.to_i
    most_accurate[game_data[:home].team_id][:total_shots] += game_data[:home].shots.to_i
    most_accurate[game_data[:away].team_id][:total_shots] += game_data[:away].shots.to_i
  end

  def create_team_id(most_accurate, game_data, hoa)
    most_accurate[game_data[hoa].team_id] = {total_goals: 0, total_shots: 0}
  end

end
