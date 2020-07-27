module SeasonStats

  def most_accurate_team1(season)
    array = []
    @game_teams_manager.game_teams_array.each{ |game|
      if @all_games2.include?(game.game_id)
        array << game
      end
    }
    hash = array.group_by{ |game| game.team_id}
    hash1 = array.group_by{ |game| game.team_id}
    @all_goals = hash1.each{ |k,v| hash1[k] = v.map{ |game|
      game.goals.to_i
    }.sum
  }
    all_shots = hash.each{ |k,v| hash[k] = v.map{ |game|
      game.shots.to_i
    }.sum
  }
    all_shots.each{ |k,v| @all_goals.each{ |k1,v1|
      if k == k1
        @all_goals[k] = (v1.to_f/v.to_f)
      end
    }
      @all_goals
  }
  end

end
