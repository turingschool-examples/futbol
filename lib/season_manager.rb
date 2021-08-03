require_relative './season'

class SeasonManager
  attr_reader :seasons_hash

  def initialize(seasons, games, game_teams)
    @seasons_hash = {}
    create_seasons(seasons, games, game_teams)
  end

  def create_seasons(seasons, games, game_teams)
    fill_season_ids(seasons)
    @seasons_hash.each do |season_id, season|
      games.each do |game|
        if game.season == season_id
          @seasons_hash[season_id].add_game(game.game_id, game, game_teams[game.game_id][:home], game_teams[game.game_id][:away])
        end
      end
    end
  end

  def fill_season_ids(seasons)
    seasons.each do |season|
      @seasons_hash[season] ||= Season.new
    end
  end

  def games_and_wins
    {total_games: 0, total_wins: 0}
  end

  def add_coach_data(coach_wins, game_data)
    if game_data[:away].result == 'WIN'
      coach_wins[game_data[:away].head_coach][:total_wins] += 1
    elsif game_data[:away].result == 'LOSS'
      coach_wins[game_data[:home].head_coach][:total_wins] += 1
    end
    coach_wins[game_data[:home].head_coach][:total_games] += 1
    coach_wins[game_data[:away].head_coach][:total_games] += 1
  end

  def winningest_coach(season_id)
    coach_wins = @seasons_hash[season_id].coach_wins

    coach_wins.max_by do |coach_name, coach_data|
      coach_data[:total_wins].fdiv(coach_data[:total_games])
    end.first
  end

  def worst_coach(season)
    coach_wins = @seasons_hash[season].coach_wins

    coach_wins.min_by do |coach, coach_data|
      coach_data[:total_wins].fdiv(coach_data[:total_games])
    end.first
  end

  def most_accurate_team(season)
    accuracy = @seasons_hash[season].accuracy

    most_accurate_team = accuracy.min_by do |team_id, goals_data|
      goals_data[:total_shots].fdiv(goals_data[:total_goals])
    end.first

    most_accurate_team
  end

  def least_accurate_team(season)
    accuracy = @seasons_hash[season].accuracy

    least = accuracy.max_by do |team_id, goals_data|
      goals_data[:total_shots].fdiv(goals_data[:total_goals])
    end.first

    least
  end

  def create_teams_tackle_data(most_tackles, game_data, hoa)
    most_tackles[game_data[hoa].team_id] = game_data[hoa].tackles.to_i
  end

  def add_tackle_data(most_tackles, game_data)
      most_tackles[game_data[:home].team_id] += game_data[:home].tackles.to_i
      most_tackles[game_data[:away].team_id] += game_data[:away].tackles.to_i
  end


  def most_tackles(season)
    tackles_by_team = @seasons_hash[season].tackles_by_team

    most = tackles_by_team.max_by do |team_id, tackles|
      tackles
    end[0]

    most
  end

  def fewest_tackles(season)
    tackles_by_team = @seasons_hash[season].tackles_by_team

    least = tackles_by_team.min_by do |team_id, tackles|
      tackles
    end[0]

    least
  end

  def best_season(team_id)
    season_data = {}
    @seasons_hash.each do |season_id, season|
      season_data[season_id] = season.games_and_wins_by_team(team_id)
    end

    season_data.max_by do |season_id, season_data|
      season_data[:total_wins].fdiv(season_data[:total_games])
    end.first
  end

  def worst_season(team_id)
    season_data = {}
    @seasons_hash.each do |season_id, season|
      season_data[season_id] = season.games_and_wins_by_team(team_id)
    end

    season_data.min_by do |season_id, season_data|
      season_data[:total_wins].fdiv(season_data[:total_games])
    end.first
  end
end
