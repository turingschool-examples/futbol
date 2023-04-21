require_relative "./stat_tracker"
require_relative "./stat_helper"
class GameTeams

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
              :powerplayopp,
              :powerplaygoals,
              :faceoffwinperc,
              :giveaways,
              :takeaways

  def initialize(row)
    @game_id =        row[:game_id]
    @team_id =        row[:team_id]
    @hoa =            row[:hoa]
    @result =         row[:result]
    @settled_in =     row[:settled_in]
    @head_coach =     row[:head_coach]
    @goals =          row[:goals].to_i
    @shots =          row[:shots].to_i
    @tackles =        row[:tackles].to_i
    @pim =            row[:pim].to_i
    @powerplayopp =   row[:powerplayopportunities].to_i
    @powerplaygoals = row[:powerplaygoals].to_i
    @faceoffwinperc = row[:faceoffwinpercentage].to_f
    @giveaways =      row[:giveaways].to_i
    @takeaways =      row[:takeaways].to_i
  end

  def percentage_home_wins
    home_wins = 0
    @game_teams.find_all do |row|
      home_wins += 1 if (row[:hoa]) == "home" && row[:result] == "WIN" ||
      (row[:hoa]) =="away" && row[:result] == "LOSS"
    end
    (home_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @game_teams.find_all do |row|
      visitor_wins += 1 if (row[:hoa]) == "away" && row[:result] == "WIN" ||
      (row[:hoa]) =="home" && row[:result] == "LOSS"
    end
    (visitor_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    no_lose = 0
    @game_teams.find_all do |row|
      no lose += 1 if (row[:hoa]) == "home" && row[:result] == "TIE" ||
      (row[:hoa]) =="away" && row[:result] == "TIE"
    end
    (no_lose.to_f / @game_teams.count. to_f).round(2)
  end
end