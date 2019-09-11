module SeasonableHelper

    def regular_season_win_percentage_helper(season) #ALL Teams. Hash. Key = Team_id, Value = win percentage
    end

    def postseason_win_percentage_helper(season) #ALL Teams. Hash. Key = Team_id, Value = win percentage
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
