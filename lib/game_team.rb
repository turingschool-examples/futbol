class GameTeam
#
  @@all = nil

  def self.all
    @@all
  end

  def self.find_by(id)
    @@all.find_all{|game| game.game_id == id}
  end

  def self.from_csv(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map { |row| GameTeam.new(row) }
  end

  def self.home_games
    (@@all.find_all {|gt| gt.hoa == "home" }).count
  end

  def self.percentage_home_wins
    home_wins = (@@all.find_all {|gt| gt.hoa == "home" && gt.result == "WIN" }).count.to_f
    ((home_wins / self.home_games) * 100).round(2)
  end

  def self.percentage_visitor_wins
    visitor_wins = (@@all.find_all {|gt| gt.hoa == "home" && gt.result == "LOSS" }).count.to_f
    ((visitor_wins / self.home_games) * 100).round(2)
  end

  def self.percentage_ties
    games_count = @@all.count.to_f
    ties_count = (@@all.find_all { |gt| gt.result == "TIE"}).count.to_f
    ((ties_count / games_count) * 100).round(2)
  end

  def self.winningest_coach
  end

  def self.worst_coach
  end

  def self.game_team_shots_goals_count(arr_games)
    season = arr_games.first.game_id
    self.find_by(season)
  end

  def self.get_goal_shots_by_game_team(game_teams)
    #passes in an array of games
    results = {}
    #each game, iterating through and adding the team_id as the key and
    #getting the shots and goals count
    game_teams.each do |game_team|
      results[game_team.team_id] ||= {"shots"=>0,"goals"=>0}
      results[game_team.team_id]["shots"] += game_team.shots
      results[game_team.team_id]["goals"] += game_team.goals
    end
    results
  end

  def self.least_accurate_team(season)
   seasonal_hash = gets_team_shots_goals_count(season)
   seasonal_hash.map do |key,value|
     value["average"] = (value["shots"]/ value["goals"].to_f).round(2)
   end
   team_hash_with_highest_average = seasonal_hash.min_by do |key,value|
     value["average"]
   end
   team_hash_with_highest_average[0]
 end

 def self.most_accurate_team(season)
    seasonal_hash = gets_team_shots_goals_count(season)
    seasonal_hash.map do |key,value|
      value["average"] = (value["shots"]/ value["goals"].to_f).round(2)
    end
    team_hash_with_highest_average = seasonal_hash.max_by do |key,value|
      value["average"]
    end
    team_hash_with_highest_average[0]
  end

  def self.gets_team_shots_goals_count(season)
    #passes in desired season, grabs the *games* for the season
    season_games = Game.grouped_by_season(season)
    matches = []
    #gets the game_teams associated with the season
    season_games.each do |game|
      matches.concat(GameTeam.find_by(game.game_id))
    end
    #takes the game_teams and runs them through the below method
    stats_by_team = get_goal_shots_by_game_team(matches)
  end

  def self.best_offense
    #grouped by team_id with keys being the team_id and values is an array of games
    grouped_team = @@all.group_by{|game| game.team_id}
    #loop through the values (games) and set them equal to the average of goals
    team_averaged_goals = grouped_team.map do |ids, games|
      goals_per_game = games.map {|game| game.goals}
      games = (goals_per_game.sum / goals_per_game.length)
    end
    total_goals_per_team= Hash[grouped_team.keys.zip(team_averaged_goals)]
    total_goals_per_team.key(total_goals_per_team.values.max)
  end

  def self.worst_offense
    #grouped by team_id with keys being the team_id and values is an array of games
    grouped_team = @@all.group_by{|game| game.team_id}
    #loop through the values (games) and set them equal to the average of goals
    team_averaged_goals = grouped_team.map do |ids, games|
      goals_per_game = games.map {|game| game.goals}
      games = (goals_per_game.sum / goals_per_game.length)
    end
    total_goals_per_team= Hash[grouped_team.keys.zip(team_averaged_goals)]
    total_goals_per_team.key(total_goals_per_team.values.min)
  end
    attr_reader :game_id,
                :team_id,
                :hoa,
                :result,
                :settled_in,
                :head_coach,
                :goals,
                :shots,
                :tackles,
                :pim,
                :power_play_opportunities,
                :power_play_goals,
                :face_off_win_percentage,
                :giveaways,
                :takeaways

  def initialize(details)
    @game_id = details[:game_id].to_i
    @team_id = details[:team_id].to_i
    @hoa = details[:hoa]
    @result = details[:result]
    @settled_in = details[:settled_in]
    @head_coach = details[:head_coach]
    @goals = details[:goals].to_i
    @shots = details[:shots].to_i
    @tackles = details[:tackles].to_i
    @pim = details[:pim].to_i
    @power_play_opportunities = details[:powerplayopportunities].to_i
    @power_play_goals = details[:powerplaygoals].to_i
    @face_off_win_percentage = details[:faceoffwinpercentage].to_f.round(2)
    @giveaways = details[:giveaways].to_i
    @takeaways = details[:takeaways].to_i
  end
end
