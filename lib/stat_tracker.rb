require 'CSV'
require 'spec_helper'



class StatTracker

  def initialize
   @games = Game.create_games
  end

  def self.from_csv(locations_hash)
    locations_hash.values.each do |filepath|
      CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
        # if row[:game_id] && row[:shots] (games_teams)
          game_id = row[:game_id]
          team_id = row[:team_id]
          home_or_away = row[:hoa]
          result = row[:result]
          settled_in = row[:settled_in]
          head_coach = row[:head_coach]
          goals = row[:goals]
          shots = row[:shots]
          tackles = row[:tackles]
          pim = row[:pim]
          power_play_opportunities = row[:powerplayopportunities]
          power_play_goals = row[:powerplaygoals]
          face_off_win_percentage = row[:faceoffwinpercentage]
          giveaways = row[:giveaways]
          takeaways = row[:takeaways]
        # elsif row[:game_id] && row[:venue_link] (games)
          game_id =row[:game_id]
          season = row[:seaon]
          game_type = row[:type]
          game_date_time = row[:date_time]
          away_team_id = row[:away_team_id]
          home_team_id = row[:home_team_id]
          away_goals = row[:away_goals]
          home_goals = row[:home_goals]
          venue = row[:venue]
          venue_link = row[:venue_link]
        # else (teams)
          team_id = row[:team_id]
          franchise_id = row[:franchiseid]
          team_name = row[:teamname]
          abbreviation = row[:abbreviation]
          stadium = row[:stadium]
          link = row[:link]
        end
      end
    end
  end

def create_games

end

def create_teams

end

def create_game_teams

end

def highest_total_points_in_game
# add away_goals and home_goals together


# return integer


end