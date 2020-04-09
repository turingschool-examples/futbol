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

  def all_coaches
    coaches = @@all.map {|gt| gt.head_coach }.uniq
  end

  def results_by_coach
    results_by_coach = {}
    all_coaches.each do |coach|
      @@all.find_all do |gt|
        if coach == gt.head_coach && results_by_coach[coach] == nil
            results_by_coach[coach] = [gt.result]
        elsif coach == gt.head_coach && results_by_coach[coach] != nil
            results_by_coach[coach] << gt.result
        end
      end
    end
  end

  def wins_by_coach
    wins_by_coach = {}
    all_coaches.each do |coach|
      wins_by_coach[coach] = results_by_coach[coach].count
    end
    wins_by_coach
  end

  def self.winningest_coach
    # # total # of games coached
    # # total # of games won by coach
    # wins_by_coach = {}
    # coaches = @@all.map {|gt| gt.head_coach }.uniq
    # coaches.each do |coach|
    #   @@all.find_all do |gt|
    #     if coach == gt.head_coach
    #       if wins_by_coach[coach] == nil
    #         wins_by_coach[coach] = [gt.result]
    #       elsif wins_by_coach[coach] != nil
    #         wins_by_coach[coach] << gt.result
    #       end
    #     end
    #   end
    # end
  end

  def self.worst_coach
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
