class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
    StatTracker.new(data_files)
  end

  def game_collection
    GameCollection.new(@games)
  end

  def team_collection
    TeamCollection.new(@teams)
  end

  def game_team_collection
    GameTeamCollection.new(@game_teams)
  end

  def highest_total_score
    total = game_collection.all.max_by do |game|
      game.away_goals + game.home_goals
    end

    total.home_goals + total.away_goals
  end

  def lowest_total_score
    total = game_collection.all.min_by do |game|
      game.away_goals + game.home_goals
    end

    total.home_goals + total.away_goals
  end

  def winningest_coach(season_id)
    coaches_stats = Hash.new(0)

      game_team_collection.all.each do |game_team|
        if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
          if game_team.result == "LOSS"
            coaches_stats[game_team.head_coach] -= 1
          elsif game_team.result == "WIN"
            coaches_stats[game_team.head_coach] += 1
          elsif game_team.result == "TIE"
            next
          end
      end
    end
    best_coach = coaches_stats.max_by do |coach, wins|
      wins
    end
    best_coach[0]
  end

  def worst_coach(season_id)
    coaches_stats = Hash.new(0)

      game_team_collection.all.each do |game_team|
        if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
          if game_team.result == "LOSS"
            coaches_stats[game_team.head_coach] -= 1
          elsif game_team.result == "WIN"
            coaches_stats[game_team.head_coach] += 1
          elsif game_team.result == "TIE"
            next
          end
      end
    end
    worst_coach = coaches_stats.min_by do |coach, wins|
      wins
    end
    worst_coach[0]
  end

  def most_accurate_team(season_id)
    goals_for_season_by_team = Hash.new(0)
    game_team_collection.all.each do |game_team|
      if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
        goals_for_season_by_team[game_team.team_id] += game_team.goals
      end
    end

    shots_for_season_by_team = Hash.new(0)
    game_team_collection.all.each do |game_team|
      if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
        shots_for_season_by_team[game_team.team_id] += game_team.shots
      end
    end

    ratio_of_g_to_s_for_season_by_team = Hash.new(0)
    goals_for_season_by_team.each do |g_team_id, goals|
      shots_for_season_by_team.each do |s_team_id, shots|
        if s_team_id == g_team_id
          ratio_of_g_to_s_for_season_by_team[s_team_id] = goals.to_f / shots.to_f
        end
      end
    end

    best_team = ratio_of_g_to_s_for_season_by_team.max_by do |team_id, ratio|
      ratio
    end

    team_name_based_off_of_team_id(best_team[0])
  end

  def least_accurate_team(season_id)
    goals_for_season_by_team = Hash.new(0)
    game_team_collection.all.each do |game_team|
      if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
        goals_for_season_by_team[game_team.team_id] += game_team.goals
      end
    end

    shots_for_season_by_team = Hash.new(0)
    game_team_collection.all.each do |game_team|
      if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
        shots_for_season_by_team[game_team.team_id] += game_team.shots
      end
    end

    ratio_of_g_to_s_for_season_by_team = Hash.new(0)
    goals_for_season_by_team.each do |g_team_id, goals|
      shots_for_season_by_team.each do |s_team_id, shots|
        if s_team_id == g_team_id
          ratio_of_g_to_s_for_season_by_team[s_team_id] = goals.to_f / shots.to_f
        end
      end
    end

    worst_team = ratio_of_g_to_s_for_season_by_team.min_by do |team_id, ratio|
      ratio
    end

    team_name_based_off_of_team_id(worst_team[0])
  end

  def team_name_based_off_of_team_id(team_id)
    CSV.foreach(@teams, headers: true, header_converters: :symbol) do |team|
      if team_id == team[:team_id].to_i
        return team[:teamname]
      end
    end
  end

  def most_tackles(season_id)
    tackles_for_season_by_team = Hash.new(0)
    game_team_collection.all.each do |game_team|
      if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
        tackles_for_season_by_team[game_team.team_id] += game_team.tackles
      end
    end

    best_team = tackles_for_season_by_team.max_by do |team_id, tackles|
      tackles
    end

    team_name_based_off_of_team_id(best_team[0])
  end

  def fewest_tackles(season_id)
    tackles_for_season_by_team = Hash.new(0)
    game_team_collection.all.each do |game_team|
      if season_id.to_s.include?(game_team.game_id.to_s.split(//).join[0..3])
        tackles_for_season_by_team[game_team.team_id] += game_team.tackles
      end
    end

    worst_team = tackles_for_season_by_team.min_by do |team_id, tackles|
      tackles
    end

    team_name_based_off_of_team_id(worst_team[0])
  end
end
