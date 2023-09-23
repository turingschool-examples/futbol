class Team
  def initialize(game_team_data, game_data, team_data)
    @game_team_data = game_team_data
    @game_data = game_data
    @team_data = team_data
  end

  # this method does not work because @team_data is not importing franchise_id for any teams
  def team_info(team_id)
    team_info = @team_data.find do |team|
      team[:team_id] == team_id
    end
    key_map = {
      team_id: "team_id", 
      team_name: "team_name", 
      franchise_id: "franchise_id",
      abbreviation: "abbreviation",
      link: "link"
    }
    team_info.transform_keys! { |k| key_map[k] }
  end

  def teams_total_wins(team_id)
    total_wins = Hash.new(0)
    @game_team_data.each do |row|
      if row[:team_id] == team_id && row[:result] == "WIN"
        total_wins[team_id] += 1
      end
    end
    total_wins
  end
  # Team Total Games could perhaps be a module??
  def teams_total_games(team_id)
    total_ties_loss = Hash.new(0)
    @game_team_data.each do |row|
      if row[:team_id] == team_id
        total_ties_loss[team_id] += 1
      end
    end
    total_ties_loss
  end

  def average_win_percentage(team_id)
    team_avg = Hash.new(0)
    teams_total_wins(team_id).each do |team, wins|
      total_games = teams_total_games(team_id)[team]
      percent = (wins / total_games.to_f).round(2)
      team_avg[team] = percent
    end
    team_avg[team_id]
  end

  ### The below block of code works iti is a total of 14 lines of logic, so we 
  ### divide it into three seperate six logic line blocks (18 lines) and add 
  ### all the space to it so really it's double??? Now you gotta see who calls
  ### who and idk if having three methods or one comprehensive makes more sense.
  ### Choose either or and lemme know. 


  # def average_win_percentage(team_id)
  #   total_wins = Hash.new(0)
  #   @game_team_data.each do |row|
  #     if row[:team_id] == team_id && row[:result] == "WIN"
  #       total_wins[team_id] += 1
  #     elsif row[:team_id] == team_id
  #       total_ties_loss[team_id] += 1
  #     end
  #     total_ties_loss = Hash.new(0)
  #   end
  #   overall_hash = Hash.new(0)
  #   total_wins.each do |team, wins|
  #     total_games = wins + total_ties_loss[team]
  #     percent = (wins / total_games.to_f).round(2)
  #     overall_hash[team] = percent
  #   end
  #   overall_hash[team_id]
  # end
end