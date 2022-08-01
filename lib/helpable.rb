module Helpable

  def team_isolator(team_id) #game_teams helper, returns all of a team's games
    @game_teams.find_all do |game|
      team_id == game.team_id
    end
  end

  def win_isolator(team_id) #game_teams helper, returns all of a team's wins in an array
    @game_teams.find_all do |game|
      team_id == game.team_id && game.result == "WIN"
    end
  end

  def season_grouper #games helper, returns a hash with the season as the key and array of all games for the season as the value
    @games.group_by do |game|
      game.season
    end
  end

  def get_teamgames_by_single_season(team_id, season) #games helper, returns array of all of a team's games for one season
    games_by_season = []
    @games.each do |game|
      if (game.home_team_id == team_id || game.away_team_id == team_id) && game.season == season
        games_by_season << game
      end
    end
    games_by_season
  end

  def all_team_games(team_id) #games helper, returns all of a team's games in an array
    all_games = []
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        all_games << game
      end
    end
    all_games
  end

  def team_season_grouper(team_id) #helper, groups all of a team's games by season in a hash: the key is the season and the values are the team's games for that season
    all_games = all_team_games(team_id)
    all_games.group_by do |game|
      game.season
    end
  end

  def games_by_season(season_id) #helper method
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
          game_id_list << game.game_id
        end
    end
    return game_id_list
  end


  def minimum(average) #helper method
    average.min { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

  def maximum(average) #helper method
    average.max { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

  def team_id_to_name
    @teams.map { |team| [team.team_id, team.team_name] }.to_h
  end

  def get_ratio(season_id)
    goals = Hash.new(0)
    shots = Hash.new(0)
    ratio = Hash.new(0)
    game_id_list= games_by_season(season_id)
      @game_teams.each do |game_team|
        game_id = game_team.game_id
        current_team_id = game_team.team_id

        if game_id_list.include?game_id

          goals[current_team_id] += game_team.goals.to_f
          shots[current_team_id] += game_team.shots.to_f
          ratio[current_team_id] = goals[current_team_id]/shots[current_team_id]

        end
    end
    return ratio
  end

  def number_of_tackles(team_id, game_id)
    tackles = 0
    @game_teams.each do |game_team|
      if team_id == game_team.team_id && game_id == game_team.game_id
        tackles += game_team.tackles.to_i
      end
    end
    tackles
  end

end