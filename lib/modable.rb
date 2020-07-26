module Modable

  def fav_opp(id)
    freq = @teams1.inject(Hash.new(0)){ |h,v| h[v] += 1; h}
    numbs = @teams1.min_by{ |v| freq[v]}
    @teams_array.select{ |team| team.team_id == numbs}[0].team_name
  end

  def fav_opp2(id)
    @teams1 = []
    @array1 = @all_games.each do |rows|
      if rows.home_team_id == "#{id}"
        if rows.away_goals > rows.home_goals
          @teams1 << rows.away_team_id
        end
      elsif rows.away_team_id == "#{id}"
        if rows.away_goals == rows.home_goals
          @teams1 << rows.home_team_id
        end
      end
    end
    self.fav_opp(id)
  end

  def rival2(id)
    @teams1 = []
    @all_games.each do |game|
      if game.away_team_id == "#{id}"
        if game.away_goals < game.home_goals
          @teams1 << game.home_team_id
        end
      elsif game.home_team_id == "#{id}"
        if game.away_goals > game.home_goals
          @teams1 << game.away_team_id
        end
      end
    end
  end

  def season_games(id)
    @all_games = @games_array.select{ |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"}
    @away_wins = @all_games.select{ |row|
      row.away_team_id == "#{id}" && row.away_goals > row.home_goals}
    @home_wins = @all_games.select{ |row|
      row.home_team_id == "#{id}" && row.away_goals < row.home_goals}
    @seasons = (@away_wins + @home_wins).map{ |game| game.season}
  end

  def winningest_coach1(season)
    array = []
    @game_teams_manager.game_teams_array.each{ |game|
      if @all_games.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.head_coach}
    games_played = hash.each{ |k,v| hash[k] = v.length}
    games_won = array.select{ |game| game.result == "WIN"}
    games_won_hash = games_won.group_by{ |game| game.head_coach}
    numb_games_won = games_won_hash.each{ |k,v| games_won_hash[k] = v.length}
    @result = {}
    numb_games_won.each{ |k,v| games_played.each{ |k1,v1|
       if k == k1
          @result[k] = (v.to_f/v1.to_f).round(4)
       end
     }
   }
   @result.max_by(&:last).first
  end

  def worst_coach1(season)
    array = []
    @game_teams_manager.game_teams_array.each{ |game|
      if @all_games1.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.head_coach}
    games_played = hash.each{ |k,v| hash[k] = v.length}
    array
    games_lost = array.select{ |game|
      game.result == "LOSS" || game.result == "TIE"}
    games_lost_hash = games_lost.group_by{ |game| game.head_coach}
    numb_games_lost = games_lost_hash.each{ |k,v|
      games_lost_hash[k] = v.length}
    numbers = []
    @result = {}
    numb_games_lost.each{ |k,v| games_played.each{ |k1,v1|
       if k == k1
          @result[k] = (v.to_f/v1.to_f).round(4)
       end
     }
   }
   @result.sort_by{ |key, value| value}[-1].first
  end

  def most_accurate_team2(season)
    @team_manager.teams_array.map{ |team|
      if team.team_id == @numb2
        team.team_name
      end
    }.compact.join
  end

  def most_tackles1(season)
    array = []
    @game_teams_manager.game_teams_array.each{ |game|
      if @all_games.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.team_id}
    @all_tackles = hash.each{ |k,v| hash[k] = v.map{ |game|
      game.tackles.to_i}.sum
    }
      @numb2 = @all_tackles.sort_by{ |key, value| value}[-1].first
      self.most_accurate_team2(season)
    end
  end
