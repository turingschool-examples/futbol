module LeagueStats
  def count_of_teams
    team_ids = @teams.map(&:team_id)
    team_ids.uniq.count
  end

  def best_offense
    avg = return_average_goals_per_game(team_names_data, data_away + data_home)
    team_names_data[avg.key(avg.values.max)]
  end

  def worst_offense
    avg = return_average_goals_per_game(team_names_data, data_away + data_home)
    team_names_data[avg.key(avg.values.min)]
  end

  def highest_scoring_visitor
    avg = return_average_goals_per_game(team_names_data, data_away)
    team_names_data[avg.key(avg.values.max)]
  end

  def highest_scoring_home_team
    avg = return_average_goals_per_game(team_names_data, data_home)
    team_names_data[avg.key(avg.values.max)]
  end

  def lowest_scoring_visitor
    avg = return_average_goals_per_game(team_names_data, data_away)
    team_names_data[avg.key(avg.values.min)]
  end

  def lowest_scoring_home_team
    avg = return_average_goals_per_game(team_names_data, data_home)
    team_names_data[avg.key(avg.values.min)]
  end

  def return_average_goals_per_game(teamdata, scoredata)
    avghash ={}
    teamdata.keys.each do |team|
      goals = 0
      scoredata.each do |score|
        if score[0] == team
          goals += score[1]
        end
      end
      avghash[team] = (goals.to_f / (scoredata.flatten.count(team))).round(4)
    end
    avghash
  end

  def data_home
    @games.map {|game| [game.home_team_id, game.home_goals]}
  end

  def data_away
    @games.map {|game| [game.away_team_id, game.away_goals]}
  end

  def team_names_data
    @teams.map{|team| [team.team_id,team.team_name]}.to_h
  end
end
