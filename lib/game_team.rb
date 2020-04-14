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

  def self.winningest_coach
  end

  def self.worst_coach
  end

#Michelle Start
  def self.games_ids_by_season(season_id)
    game_id_first = season_id.to_s[0..3].to_i
    all_games_by_id = all.find_all { |game| game.season_id == game_id_first }
    all_games_by_id.map { |game| game.game_id }
  end

  def self.games_by_season_id(season_id)
      games_by_id = []
      all.each do |game|
        if games_ids_by_season(season_id).any? { |id| id == game.game_id }
          games_by_id << game
        end
      end
      games_by_id
  end

  def self.games_by_team_name(season_id)
    games_by_id = games_by_season_id(season_id).group_by { |game| game.team_id }
  end

  def self.tackles_by_team(season_id)
      tackles_by_team = {}
      games_by_team_name(season_id).each do |key, value|
        total_tackles = value.sum { |value| value.tackles}
        tackles_by_team[key] = total_tackles
      end
      tackles_by_team
  end

    def self.most_tackles(season_id)
      most_tackles = tackles_by_team(season_id).max_by { |key, value| value}
      most_tackles.first
    end

    def self.fewest_tackles(season_id)
      fewest_tackles = tackles_by_team(season_id).max_by { |key, value| -value}
      fewest_tackles.first
    end
    #Michelle end


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
                :takeaways,
                :season_id

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
    @season_id = @game_id.to_s[0..3].to_i
  end
end
