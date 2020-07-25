module Modable

  def fav_opp(id)
    freq = @teams1.inject(Hash.new(0)) do |h,v| h[v] += 1; h
    end
    numbs = @teams1.min_by do |v| freq[v]
    end
    @teams_array.select do |team| team.team_id == numbs
    end[0].team_name
  end

  def fav_opp2(id)
    @teams1 = []
    @array1 = @all_games.select do |rows|
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

  def rival1(id)
    @teams2 = []
    self.best_season(id)
    @all_games.each do |game|
      if game.away_team_id == "#{id}"
        @teams2 << game.home_team_id
      elsif game.home_team_id == "#{id}"
        @teams2 << game.away_team_id
      end
    end
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


  def goals(id)
    @away = @all_games.map do |rows| rows.away_goals
    end
    @home = @all_games.map do |rows| rows.home_goals
    end
  end

  def season_games(id)
    @all_games = @games_array.select do |row| row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    @away_wins = @all_games.select do |row| row.away_team_id == "#{id}" && row.away_goals > row.home_goals
    end
    @home_wins = @all_games.select do |row| row.home_team_id == "#{id}" && row.away_goals < row.home_goals
    end
    @seasons = (@away_wins + @home_wins).map{ |x| x.season}
  end

  def winningest_coach1(season)
    array = []
    @game_teams_manager.game_teams_array.each do |game|
      if @all_games.include?(game.game_id)
        array << game
      end
    end
    hash = array.group_by do |game| game.head_coach
    end
    games_played = hash.each do |k,v| hash[k] = v.length
    end

    games_won = array.select do |game| game.result == "WIN"
    end
    games_won_hash = games_won.group_by do |game| game.head_coach
    end
    numb_games_won = games_won_hash.each do |k,v| games_won_hash[k] = v.length
    end
    numbers = []
    @result = {}
    numb_games_won.each do |k,v| games_played.each do |k1,v1|
       if k == k1
          @result[k] = (v.to_f/v1.to_f).round(4)
       end
     end
   end
  end

  def worst_coach1(season)
    array = []
    @game_teams_manager.game_teams_array.each do |game|
      if @all_games1.include?(game.game_id)
        array << game
      end
    end
    hash = array.group_by do |game| game.head_coach
    end
    games_played = hash.each do |k,v| hash[k] = v.length
    end
    array
    games_lost = array.select do |game| game.result == "LOSS" || game.result == "TIE"
    end
    games_lost_hash = games_lost.group_by do |game| game.head_coach
    end
    numb_games_lost = games_lost_hash.each do |k,v| games_lost_hash[k] = v.length
    end
    numbers = []
    @result = {}
    numb_games_lost.each do |k,v| games_played.each do |k1,v1|
       if k == k1
          @result[k] = (v.to_f/v1.to_f).round(4)
       end
     end
   end
  end

  def most_accurate_team1(season)
    array = []
    @game_teams_manager.game_teams_array.each do |game|
      if @all_games2.include?(game.game_id)
        array << game
      end
    end
    hash = array.group_by do |game|
      game.team_id
    end
    hash1 = array.group_by do |game|
      game.team_id
    end
    @all_goals = hash1.each do |k,v| hash1[k] = v.map do |game| game.goals.to_i
    end.sum
  end
    all_shots = hash.each do |k,v| hash[k] = v.map do |game| game.shots.to_i
    end.sum
  end
    all_shots.each do |k,v| @all_goals.each do |k1,v1|
      if k == k1
        @all_goals[k] = (v1.to_f/v.to_f)
      end
    end
      @all_goals
  end
end

  def most_accurate_team2(season)
    @team_manager.teams_array.map do |team|
      if team.team_id == @numb2
        team.team_name
      end
    end.compact.join
  end

  def most_tackles1(season)
    array = []
    @game_teams_manager.game_teams_array.each do |game|
      if @all_games.include?(game.game_id)
        array << game
      end
    end
    hash = array.group_by do |game|
      game.team_id
    end
    @all_tackles = hash.each do |k,v| hash[k] = v.map do |game|
      game.tackles.to_i
        end.sum
      end
    end
  end
