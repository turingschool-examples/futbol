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
    coach_wins = {} # define a method for lines 46-61
    @seasons_hash[season_id].games.each do |game_id, game_data|
      if coach_wins[game_data[:home].head_coach].nil? && coach_wins[game_data[:away].head_coach].nil?
        coach_wins[game_data[:home].head_coach] = games_and_wins
        coach_wins[game_data[:away].head_coach] = games_and_wins
        add_coach_data(coach_wins, game_data)
      elsif coach_wins[game_data[:home].head_coach].nil?
        coach_wins[game_data[:home].head_coach] = games_and_wins
        add_coach_data(coach_wins, game_data)
      elsif coach_wins[game_data[:away].head_coach].nil?
        coach_wins[game_data[:away].head_coach] = games_and_wins
        add_coach_data(coach_wins, game_data)
      else
        add_coach_data(coach_wins, game_data)
      end
    end
    coach_wins.max_by do |coach_name, coach_data|
      coach_data[:total_wins].fdiv(coach_data[:total_games])
    end.first
  end

  def worst_coach(season)
    coach_wins = {}
    @seasons_hash[season].games.each do |game_id, game_data|
      if coach_wins[game_data[:home].head_coach].nil? && coach_wins[game_data[:away].head_coach].nil?
        coach_wins[game_data[:home].head_coach] = games_and_wins
        coach_wins[game_data[:away].head_coach] = games_and_wins
        add_coach_data(coach_wins, game_data)
      elsif coach_wins[game_data[:home].head_coach].nil?
        coach_wins[game_data[:home].head_coach] = games_and_wins
        add_coach_data(coach_wins, game_data)
      elsif coach_wins[game_data[:away].head_coach].nil?
        coach_wins[game_data[:away].head_coach] = games_and_wins
        add_coach_data(coach_wins, game_data)
      else
        add_coach_data(coach_wins, game_data)
      end
    end
    coach_wins.min_by do |coach, coach_data|
      coach_data[:total_wins].fdiv(coach_data[:total_games])
    end.first
  end

  def most_accurate_team(season)
    most_accurate = @seasons_hash[season].most_accurate_team

    most_accurate_team = most_accurate.min_by do |team_id, goals_data|
      goals_data[:total_shots].fdiv(goals_data[:total_goals])
    end.first

    most_accurate_team
  end

  def least_accurate_team(season)
    least_accurate = @seasons_hash[season].least_accurate_team

    least = least_accurate.max_by do |team_id, goals_data|
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
    most_tackles = {}
    @seasons_hash[season].games.each do |game_id, game_data|
      if most_tackles[game_data[:home].team_id].nil? && most_tackles[game_data[:away].team_id].nil?
        create_teams_tackle_data(most_tackles, game_data, :home)
        create_teams_tackle_data(most_tackles, game_data, :away)
        add_tackle_data(most_tackles, game_data)
      elsif most_tackles[game_data[:home].team_id].nil?
        create_teams_tackle_data(most_tackles, game_data, :home)
        add_tackle_data(most_tackles, game_data)
      elsif most_tackles[game_data[:away].team_id].nil?
        create_teams_tackle_data(most_tackles, game_data, :away)
        add_tackle_data(most_tackles, game_data)
      else
        add_tackle_data(most_tackles, game_data)
      end
    end
    most = most_tackles.max_by do |team_id, tackles|
      tackles
    end[0]
    most
  end

  def fewest_tackles(season)
    fewest_tackles = {}
    @seasons_hash[season].games.each do |game_id, game_data|
      if fewest_tackles[game_data[:home].team_id].nil? && fewest_tackles[game_data[:away].team_id].nil?
        create_teams_tackle_data(fewest_tackles, game_data, :home)
        create_teams_tackle_data(fewest_tackles, game_data, :away)
        add_tackle_data(fewest_tackles, game_data)
      elsif fewest_tackles[game_data[:home].team_id].nil?
        create_teams_tackle_data(fewest_tackles, game_data, :home)
        add_tackle_data(fewest_tackles, game_data)
      elsif fewest_tackles[game_data[:away].team_id].nil?
        create_teams_tackle_data(fewest_tackles, game_data, :away)
        add_tackle_data(fewest_tackles, game_data)
      else
        add_tackle_data(fewest_tackles, game_data)
      end
    end
    least = fewest_tackles.min_by do |team_id, tackles|
      tackles
    end[0]
    least
  end

  def process_away_win(season_data, game_data, season_id)
    if game_data[:game].away_goals > game_data[:game].home_goals
      season_data[season_id][:total_wins] += 1
      season_data[season_id][:total_games] += 1
    else
      season_data[season_id][:total_games] += 1
    end
  end

  def process_home_win(season_data, game_data, season_id)
    if game_data[:game].away_goals < game_data[:game].home_goals
      season_data[season_id][:total_wins] += 1
      season_data[season_id][:total_games] += 1
    else
      season_data[season_id][:total_games] += 1
    end
  end

  def best_season(team_id)
    season_data = {}
    @seasons_hash.each do |season_id, season|
      season_data[season_id] = games_and_wins
      season.games.each do |game_id, game_data|
        home_team_id = game_data[:game].home_team_id
        away_team_id = game_data[:game].away_team_id
        if away_team_id == team_id
          process_away_win(season_data, game_data, season_id)
        elsif home_team_id == team_id
          process_home_win(season_data, game_data, season_id)
        else
        end
      end
    end
    season_data.max_by do |season_id, season_data|
      season_data[:total_wins].fdiv(season_data[:total_games])
    end.first
  end

  def worst_season(team_id)
    season_data = {}
    @seasons_hash.each do |season_id, season|
      season_data[season_id] = games_and_wins
      season.games.each do |game_id, game_data|
        home_team_id = game_data[:game].home_team_id
        away_team_id = game_data[:game].away_team_id
        if away_team_id == team_id
          process_away_win(season_data, game_data, season_id)
        elsif home_team_id == team_id
          process_home_win(season_data, game_data, season_id)
        else
        end
      end
    end
    season_data.min_by do |season_id, season_data|
      season_data[:total_wins].fdiv(season_data[:total_games])
    end.first
  end
end
