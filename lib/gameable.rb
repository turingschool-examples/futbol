module Gameable

  #helper used 2 times
    def win_percent_by_season(team_id)
      # :wins / :games_played * 100
      win_percent_by_season = divide_hash_values(:wins, :games_played, games_and_wins_by_season(team_id))
      win_percent_by_season.transform_values { |v| (v * 100).to_i}
    end

  #Helper used once, but its child is being used 4 times
    def games_and_wins_by_season(team_id)
        #{ season => {:wins => x, :games_played => y}}
      hash_of_hashes(games_played_by(team_id), :season, :wins, :games_played, :win?, 1, team_id)
    end

  #MODULE! used four times
    def games_played_by(team_id)
      #return all games that team played in
        all.find_all do |game|
        game.away_team_id == team_id || game.home_team_id == team_id
      end
    end

  #MODULE! helper used once (but child method is used 4 more times)
    def games_goals_by(hoa_team)
      #{away_team_id => {goals => x, games_played => y}}
      if hoa_team == :away_team
        hash_of_hashes(all, :away_team_id, :goals, :games_played, :away_goals, 1)
      elsif hoa_team == :home_team
        hash_of_hashes(all, :home_team_id, :goals, :games_played, :home_goals, 1)
      end
    end
    
end
