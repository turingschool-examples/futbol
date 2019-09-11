require 'pry'
module Seasonable

  # Name of the team with the biggest decrease between regular season and postseason win percentage.	Return: String
  # BB
  def biggest_bust(season)
    teams_difference = Hash.new
    self.games.each_value do |game|
      teams_difference[game.home_team_id] += 0
      teams_difference[game.away_team_id] += 0
    end

    teams_difference.each do |team_id, percent|
      teams_difference[team_id] = season_type_win_percentage_helper(team_id, season, type = "Regular Season")
    end

    binding.pry


    # Make a hash to hold the difference values.
    # The key is a team id and the value is the difference between regular_season win percent and postseason win percent
    # teams_difference = Hash.new(0)
    # self.games.each_value do |game|
    #   teams_difference[game.home_team_id] += 0
    #   teams_difference[game.away_team_id] += 0
    # end
    #
    #   regular_season_win_percentages =  regular_season_win_percentage_helper(season)
    #   postseason_win_percentages =  postseason_win_percentage_helper(season)
    #
    # regular_season_win_percentages.each do |team_id, reg_season_win_percentage|
    #     postseason_win_percentages.each do |team_id_2, post_season_win_percentage|
    #       teams_difference.each do |team_id_3, season_win_percentage_difference|
    #       if team_id_3 == team_id && team_id_3 == team_id_2 && team_id_2 == team_id
    #           teams_difference[team_id_3] = (reg_season_win_percentage - post_season_win_percentage)
    #           # teams_difference[team_id_3] = ( post_season_win_percentage - reg_season_win_percentage)
    #       end
    #     end
    #   end
    # end
    # team_with_biggest_difference = teams_difference.max_by do |team_id, difference|
    #   difference
    # end
    # binding.pry
    # team_name_finder_helper(team_with_biggest_difference[0])
    # end of biggest bust method
  end

  # Name of the team with the biggest increase between regular season and postseason win percentage.	Return: String
  # BB
  def biggest_surprise(season)
    # code goes here!
  end

  # Name of the Coach with the best win percentage for the season. Return:	String
  # JP (complete)
  def winningest_coach(season)
    coach_win_percentage_hash = coach_win_percentage_helper(season)
    best_win_percentage = 0.0
    best_coach = ""

    coach_win_percentage_hash.each do |coach, win_percentage|
      if win_percentage > best_win_percentage
        best_win_percentage = win_percentage
        best_coach = coach
      end
    end
    best_coach
  end

  # Name of the Coach with the worst win percentage for the season. Return:	String
  # JP (complete)
  def worst_coach(season)
    coach_win_percentage_hash = coach_win_percentage_helper(season)
    worst_win_percentage = 2.0
    worst_coach = ""

    coach_win_percentage_hash.each do |coach, win_percentage|
      if win_percentage < worst_win_percentage
        worst_win_percentage = win_percentage
        worst_coach = coach
      end
    end
    worst_coach
  end

  # Name of the Team with the best ratio of shots to goals for the season. Return:	String
  # AM
  def most_accurate_team(season)
    # code goes here!
  end

  # Name of the Team with the worst ratio of shots to goals for the season. Return:	String
  # AM
  def least_accurate_team(season)
    # code goes here!
  end

  # Name of the Team with the most tackles in the season. Return:	String
  # JP
  def most_tackles(season)
    # code goes here!
  end

  # Name of the Team with the fewest tackles in the season. Return:	String
  # JP
  def fewest_tackles(season)
    # code goes here!
  end

  ### Helper Methods ###

  def regular_season_win_percentage_helper(season) #ALL Teams. Hash. Key = Team_id, Value = win percentage that season

    # team hash generator creates a new hash with the team ids as keys and values as 0
    number_of_regular_season_games_won = Hash.new(0)
    number_of_regular_season_games_played = Hash.new(0)
    percent_of_regular_season_games_won = Hash.new(0)
    self.games.each_value do |game|
      number_of_regular_season_games_won[game.home_team_id] += 0
      number_of_regular_season_games_won[game.away_team_id] += 0
      number_of_regular_season_games_played[game.home_team_id] += 0
      number_of_regular_season_games_played[game.away_team_id] += 0
      percent_of_regular_season_games_won[game.home_team_id] += 0
      percent_of_regular_season_games_won[game.away_team_id] += 0
    end

    # return the number of games won for each team to the number_of_regular_season_games_won hash
    seasons_winning_regular_season_games = []
    number_of_regular_season_games_won.each do |team_id, games_won|
      games_for_team_helper(team_id).each do |game|
        if game.season == season && game.type == "Regular Season" && ((team_id == game.home_team_id && game.home_goals > game.away_goals) || (team_id == game.away_team_id && game.away_goals > game.home_goals))
          seasons_winning_regular_season_games << game
          number_of_regular_season_games_won[team_id] = seasons_winning_regular_season_games.length
        end
      end
    end

    # return the number of games played for each team to the number_of_regular_season_games_played hash
    seasons_regular_season_games_played = []
    number_of_regular_season_games_played.each do |team_id, games_won|
      games_for_team_helper(team_id).each do |game|
        seasons_regular_season_games_played << game if game.season == season && game.type == "Regular Season"
        number_of_regular_season_games_played[team_id] = seasons_regular_season_games_played.length
      end
    end

    percent_of_regular_season_games_won.map do |k3, v3|
      number_of_regular_season_games_won.each do |k, v|
        number_of_regular_season_games_played.each do |k2, v2|
          if k == k2 && k == k3 && k2 == k3
            percent_of_regular_season_games_won[k3] = v.to_f / v2
          end
        end
      end
    end
    percent_of_regular_season_games_won
  end

  def postseason_win_percentage_helper(season) #ALL Teams. Hash. Key = Team_id, Value = win percentage

        # team hash generator creates a new hash with the team ids as keys and values as 0
        number_of_postseason_games_won = Hash.new(0)
        number_of_postseason_games_played = Hash.new(0)
        percent_of_postseason_games_won = Hash.new(0)
        self.games.each_value do |game|
          number_of_postseason_games_won[game.home_team_id] += 0
          number_of_postseason_games_won[game.away_team_id] += 0
          number_of_postseason_games_played[game.home_team_id] += 0
          number_of_postseason_games_played[game.away_team_id] += 0
          percent_of_postseason_games_won[game.home_team_id] += 0
          percent_of_postseason_games_won[game.away_team_id] += 0
        end

        # return the number of games won for each team to the number_of_postseason_games_won hash
        seasons_winning_postseason_games = []
        number_of_postseason_games_won.each do |team_id, games_won|
          games_for_team_helper(team_id).each do |game|
            if game.season == season && game.type == "Postseason" && ((team_id == game.home_team_id && game.home_goals > game.away_goals) || (team_id == game.away_team_id && game.away_goals > game.home_goals))
              seasons_winning_postseason_games << game
              number_of_postseason_games_won[team_id] = seasons_winning_postseason_games.length
            end
          end
        end

        # return the number of games played for each team to the number_of_postseason_games_played hash
        seasons_postseason_games_played = []
        number_of_postseason_games_played.each do |team_id, games_won|
          games_for_team_helper(team_id).each do |game|
            seasons_postseason_games_played << game if game.season == season && game.type == "Postseason"
            number_of_postseason_games_played[team_id] = seasons_postseason_games_played.length
          end
        end

        percent_of_postseason_games_won.map do |k3, v3|
          number_of_postseason_games_won.each do |k, v|
            number_of_postseason_games_played.each do |k2, v2|
              if k == k2 && k == k3 && k2 == k3
                percent_of_postseason_games_won[k3] = (v.to_f / v2)
              end
            end
          end
        end
      percent_of_postseason_games_won
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
          elsif game_obj.result == "LOSS" || game_obj.result == "TIE"
            win_game_hash[:games] += 1
          end
        end
      end
    end

    win_percentage = nil
    coach_win_game_hash.each do |coach, win_games|
      win_percentage = ((win_games[:wins]).to_f / (win_games[:games]).to_f).round(2)
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
  end

end
