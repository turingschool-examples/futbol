require_relative 'gatherable'

module Calculateable
  include Gatherable

  def team_average_goals(goals_hash)
    average_goals = {}
    goals_hash.each do |team, tot_score|
      average_goals[team] = (tot_score.to_f / games_by_team[team]).round(2)
    end

    average_goals
  end

  def team_win_percentage(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / games_by_team[team])
    end

    average_wins
  end

  def team_postseason_win_percent(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / postseason_games_by_team[team])
    end

    average_wins
  end

  def team_home_average_wins(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / home_games_by_team[team])
    end

    average_wins
  end

  def team_away_average_wins(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / away_games_by_team[team])
    end

    average_wins
  end

  def team_total_seasons(team_id)
    @team_season_collection.collection[team_id].size
  end

  def team_season_keys(team_id)
    { team_id => @team_season_collection.collection[team_id].keys }
  end

  def combine_game_data
    @game_teams.collection.each do |game|
      team_game = @games.collection[game[1].game_id]
      if game[1].team_id == team_game.home_team_id
        team_game.home_coach = game[1].head_coach
        team_game.home_shots = game[1].shots
        team_game.home_tackles = game[1].tackles
      elsif game[1].team_id == team_game.away_team_id
        team_game.away_coach = game[1].head_coach
        team_game.away_shots = game[1].shots
        team_game.away_tackles = game[1].tackles
      end
    end
  end

  def create_season
    @games.collection.reduce(Hash.new({})) do |hash, game|
      require 'pry'; binding.pry
      h_team_id = game[1].home_team_id
      a_team_id = game[1].away_team_id
      season = game[1].season
      hash = { h_team_id => { season => [] } } if hash.empty?
      hash = { h_team_id => { season => [] } } if hash[h_team_id].nil?
      hash = { h_team_id => { season => [] } } if hash[h_team_id][season].nil?
      require 'pry'; binding.pry
      hash[h_team_id] = { season => (hash[h_team_id][season] += [game[1]]) }
      # season_hash[team_id] = { row[:season] => (season_hash[team_id][row[:season]] += [collection_type.new(row)]) }
      require 'pry'; binding.pry
      hash
    end
  end

  def win_percentage_difference(regular, post)
    post.max_by do |team|
      require 'pry'; binding.pry
      next if team[1][:win_percentage].nil?

      require 'pry'; binding.pry
      (team[1][:win_percentage] - regular[team[0]][:win_percentage]).abs.round(2)
      require 'pry'; binding.pry
    end
  end
end
