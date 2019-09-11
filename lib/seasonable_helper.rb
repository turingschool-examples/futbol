module SeasonableHelper

    def season_type_win_percentage_helper(team_id, season, type)
        total_wins = games_for_team_helper(team_id).find_all do |game|
          if (game.season == season) && (game.type == type)
            if (game.away_team_id == team_id) && (game.away_goals > game.home_goals)
              true
            elsif (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
              true
            else
              false
            end

          end
        end.length.to_f

      if total_wins > 0

        teams_total_games = 0
        self.games.each_value do |game|
          if (game.season == season) && (game.type == type)
            teams_total_games += 1 if game.away_team_id == team_id
            teams_total_games += 1 if game.home_team_id == team_id
          end
        end

        (total_wins / teams_total_games)

      else
        0.00
      end
    end

    def season_type_goals_scored_helper(team_id, season, type)
      teams_total_goals_scored = 0
      self.games.each_value do |game|
        if (game.season == season) && (game.type == type)
          teams_total_goals_scored += game.away_goals if game.away_team_id == team_id
          teams_total_goals_scored += game.home_goals if game.home_team_id == team_id
        end
      end

      teams_total_goals_scored
    end

    def season_type_goals_against_helper(team_id, season, type)
      teams_total_goals_against = 0
      self.games.each_value do |game|
        if (game.season == season) && (game.type == type)
          teams_total_goals_against += game.home_goals if game.away_team_id == team_id
          teams_total_goals_against += game.away_goals if game.home_team_id == team_id
        end
      end

      teams_total_goals_against
    end

    def season_type_games_total_helper(team_id, season, type)
      teams_total_games = 0
        self.games.each_value do |game|
          if (game.season == season) && (game.type == type)
            teams_total_games += 1 if (game.away_team_id == team_id) || (game.home_team_id == team_id)
          end
        end

      teams_total_games
    end

    def season_type_average_goals_scored_helper(team_id, season, type)
      if season_type_goals_scored_helper(team_id, season, type) > 0
        (season_type_goals_scored_helper(team_id, season, type) /
        season_type_games_total_helper(team_id, season, type).to_f).round(2)
      else
          0.00
      end
    end

    def season_type_average_goals_against_helper(team_id, season, type)
      if season_type_goals_scored_helper(team_id, season, type) > 0
        (season_type_goals_against_helper(team_id, season, type) /
        season_type_games_total_helper(team_id, season, type).to_f).round(2)
      else
          0.00
      end
    end

    def coach_win_percentage_helper(season) #ALL Coaches. Hash. Key = coach name, Value = win percentage
      coach_array = coach_array_helper
      coach_win_game_hash = Hash.new(0)
      coach_win_percentage_hash = Hash.new(0)
      until coach_array == []
        coach_win_game_hash[coach_array.shift] = { :wins => 0,
                                                  :games => 0}
      end

      self.game_teams.each do |game_obj|
        coach_win_game_hash.each do |coach, win_game_hash|
          if coach == game_obj.head_coach && season_converter(season) == game_obj.game_id.to_s[0..3].to_i
            if game_obj.result == "WIN"
              win_game_hash[:wins] += 1
              win_game_hash[:games] += 1
            elsif game_obj.result == "LOSS" #|| game_obj.result == "TIE"
              win_game_hash[:games] += 1
            elsif game_obj.result == "TIE"
              win_game_hash[:games] += 1
            end
          end
        end
      end

      win_percentage = nil
      coach_win_game_hash.each do |coach, win_games|
        win_percentage = ((win_games[:wins]) / (win_games[:games]).to_f).round(2)
        coach_win_percentage_hash[coach] = win_percentage
      end

      coach_win_percentage_hash.delete_if do |coach, win_percentage|
        win_percentage.nan?
      end

      coach_win_percentage_hash
    end

    def coach_array_helper #All uniq coaches in an array
      coach_array = []
      self.game_teams.each do |game_obj|
        coach_array << game_obj.head_coach
      end
      coach_array.uniq!.sort!
    end

    def season_converter(season)
      #convert full season to first 4 characters
      shortened_season = season[0..3]
      shortened_season.to_i
    end

    def shots_helper(season) #ALL Teams. Hash. Key = Team_id, Value = shots
    end

    def goals_helper(season) #ALL Teams. Hash. Key = Team_id, Value = goals
    end

    def tackles_helper(season) #ALL Teams. Hash. Key = Team_id, Value = tackles
      total_tackles = Hash.new(0)
      game_season = season_converter(season)
      self.game_teams.each do |game_obj|
        if game_season == game_obj.game_id.to_s[0..3].to_i
          if total_tackles.has_key?(game_obj.team_id) == false
            total_tackles[game_obj.team_id] = 0
          end

          total_tackles.each do |team, tackle|
            if team == game_obj.team_id
              total_tackles[team] += game_obj.tackles
            end
          end
        end
      end
      total_tackles
    end

end
