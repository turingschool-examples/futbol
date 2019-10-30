require 'csv'
require_relative 'game_teams'

class GameTeamsCollection
  attr_reader :game_teams_path, :game_teams_collection_instances

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_collection_instances = all_game_teams
  end

  def all_game_teams
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       GameTeams.new(row)
    end
  end

  def winningest_team_id
    team_game_count = Hash.new(0)
    @game_teams_collection_instances.each do |game|
      if game.result == "WIN"
       team_game_count[game.team_id] += 1
      end
    end
    team_game_count.max_by {|key, value| value}.first.to_s
  end

  def game_stat_maker(team_id)
    team_data = {
      away_wins: 0,
      away_losses: 0,
      home_wins: 0,
      home_losses: 0
    }
    @game_teams_collection_instances.each do |game|
      if game.team_id == team_id
        if game.result == "WIN" && game.hoa == "away"
          team_data[:away_wins] += 1
        elsif game.result == "LOSS" && game.hoa == "away"
          team_data[:away_losses] += 1
        elsif game.result == "WIN" && game.hoa == "home"
          team_data[:home_wins] += 1
        elsif game.result == "LOSS" && game.hoa == "home"
          team_data[:home_losses] += 1
        end
      end
    end
    team_data

  end

  def team_id_maker
    @team_list = []
    @game_teams_collection_instances.map do |game|
      @team_list << game.team_id
    end
    @team_list = @team_list.uniq
  end

  def team_stat_maker
    @team_accumulator = {}
    team_id_maker.each do |team_id|
      @team_accumulator[team_id] = game_stat_maker(team_id)
    end
    @team_accumulator
  end

  def worst_fans
    worst_fans_teams = []
    team_stat_maker
    @team_accumulator.map do |team|
      if team[1][:away_wins] > team[1][:home_wins]
        worst_fans_teams<< team[0]
      end
    end
    worst_fans_teams
  end

  def most_goals_scored(value)
    most_goals = @game_teams_collection_instances.find_all do |team|
      team.team_id == value
    end
    most_goals.max_by { |team| team.goals }.goals
  end
end
