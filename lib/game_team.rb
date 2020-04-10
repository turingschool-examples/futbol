class GameTeam
#
  @@all = nil

  def self.all
    @@all
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

  def self.coaches_in_season(season_id)
    search_term = season_id.to_s[0..3]
    game_teams_in_season = @@all.find_all do |gt|
      gt.game_id.to_s[0..3] == search_term
    end
    game_teams_in_season.map {|gameteam| gameteam.head_coach}.uniq
  end

  def self.results_by_coach(season_id)
    search_term = season_id.to_s[0..3]
    results_by_coach_by_season = {}
    coaches_in_season(season_id).each do |coach|
      @@all.find_all do |gt|
        if gt.game_id.to_s[0..3] == search_term
          if coach == gt.head_coach &&    results_by_coach_by_season[coach] == nil
            results_by_coach_by_season[coach] = [gt.result]
          elsif coach == gt.head_coach &&   results_by_coach_by_season[coach] != nil
            results_by_coach_by_season[coach] << gt.result
          end
        end
      end
    end
    results_by_coach_by_season
  end

  def self.total_games_coached(season_id)
    total_games_coached_by_season = {}
    coaches_in_season(season_id).each do |coach|
      total_games_coached_by_season[coach] = results_by_coach(season_id)[coach].count
    end
    total_games_coached_by_season
  end

  def self.wins_by_coach(season_id)
    wins_by_coach_by_season = {}
    coaches_in_season(season_id).each do |coach|
      results_by_coach(season_id)[coach].each do |result|
        if result == "WIN" && wins_by_coach_by_season[coach] == nil
          wins_by_coach_by_season[coach] = 1
        elsif result == "WIN" && wins_by_coach_by_season[coach] != nil
          wins_by_coach_by_season[coach] += 1
        end
      end
    end
    wins_by_coach_by_season
  end

  def self.winningest_coach(season_id)
    coaches_in_season(season_id).max_by {|coach| ((wins_by_coach(season_id)[coach].to_f / total_games_coached(season_id)[coach].to_f) * 100).round(2)}
  end


  def self.worst_coach(season_id)
    coaches_in_season(season_id).min_by {|coach| ((wins_by_coach(season_id)[coach].to_f / total_games_coached(season_id)[coach].to_f) * 100).round(2)}
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
