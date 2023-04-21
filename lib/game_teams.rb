require_relative 'stat_tracker'
class GameTeams

attr_reader :game_id, 
            :team_id, 
            :HoA, 
            :result, 
            :settled_in,
            :head_coach,
            :goals,
            :shots, 
            :tackles, 
            :pim,
            :powerPlayOpportunities,
            :powerPlayGoals,
            :faceOffWinPercentage,
            :giveaways,
            :takeaways

  def initialize(row)
    @game_id =        row[:game_id]
    @team_id =        row[:team_id]
    @hoa =            row[:HoA]
    @result =         row[:result]
    @settled_in =     row[:settled_in]
    @head_coach =     row[:head_coach]
    @goals =          row[:goals]
    @tackles =        row[:tackles]
    @pim =            row[:pim]
    @powerplayopp =   row[:powerPlayOpportunities]
    @powerplaygoals = row[:powerPlayGoals]
    @faceoffwinperc = row[:faceOffWinPercentage]
    @giveaways =      row[:giveaways]
    @takeaways =      row[:takeaways]
  end

  def percentage_home_wins
    home_wins = 0
    @game_teams.find_all do |row|
      home_wins += 1 if (row[:HoA]) == "home" && row[:result] == "WIN" ||
      (row[:HoA]) =="away" && row[:result] == "LOSS"
    end
    (home_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @game_teams.find_all do |row|
      visitor_wins += 1 if (row[:HoA]) == "away" && row[:result] == "WIN" ||
      (row[:HoA]) =="home" && row[:result] == "LOSS"
    end
    (visitor_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    no_lose = 0
    @game_teams.find_all do |row|
      no lose += 1 if (row[:HoA]) == "home" && row[:result] == "TIE" ||
      (row[:HoA]) =="away" && row[:result] == "TIE"
    end
    (no_lose.to_f / @game_teams.count. to_f).round(2)
  end
end