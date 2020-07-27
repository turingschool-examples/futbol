module GameManagerHelper

  def rival(id)
    teams = []
    self.best_season(id)
    @all_games.each{ |game|
      if game.away_team_id == "#{id}"
        teams << game.home_team_id
      elsif game.home_team_id == "#{id}"
        teams << game.away_team_id
      end
    }
    teams
    games_played_against = teams.inject(Hash.new(0)){ |h,v| h[v] += 1; h}
    teams1 = []
    @all_games.each{ |game|
      if game.away_team_id == "#{id}"
        if game.away_goals < game.home_goals
          teams1 << game.home_team_id
        end
      elsif game.home_team_id == "#{id}"
        if game.away_goals > game.home_goals
          teams1 << game.away_team_id
        end
      end
    }
      teams1
      games_won_against = teams1.inject(Hash.new(0)){ |h,v| h[v] += 1; h}
      hash1 = games_won_against.merge(games_played_against){
      |k, a_value, b_value| a_value .to_f / b_value.to_f}
      hash1.delete("14")
      team_final = hash1.max_by{|k,v| v}[0]
  end

  def favorite_opponent(id)
   self.best_season(id)
   teams = []
   @all_games.select{ |rows|
     if rows.home_team_id == "#{id}"
       if rows.away_goals > rows.home_goals
         teams << rows.away_team_id
       end
     elsif rows.away_team_id == "#{id}"
       if rows.away_goals == rows.home_goals
         teams << rows.home_team_id
       end
     end
   }
   freq = teams.inject(Hash.new(0)){ |h,v| h[v] += 1; h}
   @numbs = teams.min_by{ |v| freq[v]}
 end

end
