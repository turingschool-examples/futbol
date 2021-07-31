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

  def add_data(coach_wins, game_data)
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
end
