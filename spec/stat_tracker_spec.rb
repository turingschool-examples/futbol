require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './runner'
require_relative 'stat_tracker_spec'

RSpec.describe StatTracker do
  before(:each) do

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do

    it 'exists' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
    end


  # Game Statistics Tests

  describe '#highest_total_score' do
    it 'returns an integer' do
      expect(@stat_tracker.highest_total_score).to be_an_instance_of Integer
    end

    it 'returns highest total of winning and losing team score by game' do
      expect(@stat_tracker.highest_total_score).to eq 11
    end
  end

  describe '#lowest_total_score' do
    it 'returns an integer' do
      expect(@stat_tracker.lowest_total_score).to be_an_instance_of Integer
    end

    it 'returns lowest total of winning and losing team score by game' do
      expect(@stat_tracker.lowest_total_score).to eq 0
    end
  end

  describe '#total_games_count' do
    it 'returns the total number of games' do
      expect(@stat_tracker.total_games_count).to be_an_instance_of Float

      expect(@stat_tracker.total_games_count).to eq 7441.0
    end
  end

  describe '#home_wins_count' do
    it 'counts the number of times home team outscored away team' do
      expect(@stat_tracker.home_wins_count).to be_an_instance_of Float

      expect(@stat_tracker.home_wins_count).to eq 3237.0
    end
  end

  describe '#percentage_home_wins' do
    it 'returns a float' do
      expect(@stat_tracker.percentage_home_wins).to be_an_instance_of Float
    end

    it 'percentage of games won by the home team' do
      expect(@stat_tracker.percentage_home_wins).to eq 43.50
    end
  end

  describe '#visitor_wins_count' do
    it 'counts the numbers of times away team outscored home team' do
      expect(@stat_tracker.visitor_wins_count).to be_an_instance_of Float

      expect(@stat_tracker.visitor_wins_count).to eq 2687.0
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns a float' do
      expect(@stat_tracker.percentage_visitor_wins).to be_an_instance_of Float

      expect(@stat_tracker.percentage_visitor_wins).to eq 36.11
    end
  end

  describe '#tied_games_count' do
    it 'returns a float' do
      expect(@stat_tracker.tied_games_count).to be_an_instance_of Float

      expect(@stat_tracker.tied_games_count).to eq 1517.0
    end
  end

  describe '#percentage_ties' do
    it 'returns the percentage of game where the scores were equal' do
      expect(@stat_tracker.percentage_ties).to be_an_instance_of Float

      expect(@stat_tracker.percentage_ties).to eq 20.39
    end
  end

  describe '#total_goals' do
    it 'counts the total number of away_goals and home_goals' do
      expect(@stat_tracker.total_goals).to be_an_instance_of Float

      expect(@stat_tracker.total_goals).to eq 31413.0
    end
  end

  describe '#average_goals_per_game' do
    it 'divides the total number of goals by the total number of games' do
      expect(@stat_tracker.average_goals_per_game).to be_an_instance_of Float

      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end
  end

  describe '#count_of_games_by_season' do
    it 'returns array with season id as key and count as value' do
      @stat_tracker.count_of_games_by_season
      expect(@stat_tracker.count_of_games_by_season).to be_an_instance_of Hash
    end

    it 'has helper get_season_ids' do
      expect(@stat_tracker.get_season_ids).to be_an_instance_of Array

      expect(@stat_tracker.get_season_ids).to include("20132014")
      expect(@stat_tracker.get_season_ids).to include("20162017")
      expect(@stat_tracker.get_season_ids).to include("20172018")
    end
  end

  describe '#average_goals_by_season' do
    it 'returns hash with season id as key and float of average number of goals per game as value' do
      expect(@stat_tracker.average_goals_by_season).to be_an_instance_of Hash
    end

    it 'has season numbers as keys' do
      expect(@stat_tracker.average_goals_by_season.keys.include?("20122013")).to be_truthy

      expect(@stat_tracker.average_goals_by_season.keys.include?("20162017")).to be_truthy

      expect(@stat_tracker.average_goals_by_season.keys.include?("20172018")).to be_truthy

      first_season_goals = @stat_tracker.average_goals_by_season.values[0]

      expect(first_season_goals).to eq(first_season_goals.round(2))
    end
  end
end

    
  # Season Statistics Test
    
  describe '#winningest_coach' do

    it 'returns a string' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("coach name")
    end
    #
    it 'gives name of Coach with best win percentage of season' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("coach name")
    end
  end

  describe '#worst_coach' do

    it 'returns a string' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("coach name")
    end

    it 'gives name of Coach with the worst win percentage for the season' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("coach name")
    end
  end

  describe '#most_accurate_team' do
    it 'returns a string' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("team name")
    end

    it 'gives name of team with the best ratio of shots to goals for the season' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("team name")
    end
  end

  describe '#least_accurate_team' do
    it 'returns a string' do
      expect(@stat_tracker.least_accurate_team("20122013")).to be_a(String)
    end

    it 'gives name of team with the worst ratio of shots to goals for the season' do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq("team name")
    end
  end

  describe '#most_tackles' do
    it 'returns a string' do
      expect(@stat_tracker.most_tackles("20122013")).to be_a(String)
    end

    it 'gives name of team with the most tackles in the season' do
      expect(@stat_tracker.most_tackles("20122013")).to eq("team name")
    end
  end

  describe '#fewest_tackles' do
    it 'returns a string' do
      expect(@stat_tracker.fewest_tackles("20122013")).to be_a(String)
    end

    it 'gives name of team with the fewest tackles in the season' do
      expect(@stat_tracker.fewest_tackles("20122013")).to eq("team name")
    end
  end
end

  # League Statistics Test

  describe '#count of teams' do
    it 'returns total number of teams' do
      expect(@stat_tracker.count_of_teams).to eq(10)
    end

    it 'returns an integer' do
      expect(@stat_tracker.count_of_teams).to be_instance_of(Integer)
    end
  end

  describe '#best_offense' do
    it 'returns team with most avg goals per game for all seasons' do
      expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end

    it 'returns a string' do
      expect(@stat_tracker.best_offense).to be_instance_of(String)
    end
  end

  describe '#games_by_team' do
    it 'returns number of games per team by team_id' do
      expect(@stat_tracker.games_by_team(3).length).to eq(5)
    end
  end

  describe '#total_goals_by_team' do
    it 'returns number of total goals by team_id' do
      expect(@stat_tracker.total_goals_by_team(3)).to eq(8)
    end
  end

  describe '#average_goals_per_game_by_team' do
    it 'returns number of average goals per game by team_id' do
      expect(@stat_tracker.average_goals_per_game_by_team(3)).to eq(1.6)
    end
  end

  describe '#worst_offense' do
    it 'returns team with least avg goals per game for all seasons' do
      expect(@stat_tracker.worst_offense).to eq("Houston Dynamo")
    end

    it 'returns a string' do
      expect(@stat_tracker.worst_offense).to be_instance_of(String)
    end
  end

  describe '#games_away' do
    it 'returns all away games by team_id' do
      expect(@stat_tracker.games_away(3).length).to eq(3)
    end
  end

  describe '#average_away_score' do
    it 'returns average score per away game by team_id' do
      expect(@stat_tracker.average_away_score(3)).to eq(1.7)
    end
  end

  describe '#highest_scoring_visitor' do
    it 'returns team with highest avg score for away games' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end

    it 'returns a string' do
      expect(@stat_tracker.highest_scoring_visitor).to be_instance_of(String)
    end
  end

  describe '#highest_scoring_home_team' do
    it 'returns team with highest avg score for home games' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
    end

    it 'returns a string' do
      expect(@stat_tracker.highest_scoring_home_team).to be_instance_of(String)
    end
  end

  describe '#games_home' do
    it 'returns all home games by team_id' do
      expect(@stat_tracker.games_home(3).length).to eq(2)
    end
  end

  describe '#average_home_score' do
    it 'returns average score per home game by team_id' do
      expect(@stat_tracker.average_home_score(3)).to eq(1.5)
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns team with lowest avg score for away games' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("Houston Dynamo")
    end

    it 'returns a string' do
      expect(@stat_tracker.lowest_scoring_visitor).to be_instance_of(String)
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'returns team with lowest avg score for home games' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Houston Dynamo")
    end

    it 'returns a string' do
      expect(@stat_tracker.lowest_scoring_home_team).to be_instance_of(String)

    end
  describe '#team_info' do
    it 'returns team_id, franchise_id, team_name, abbr., and link' do
      expected = {
        "team_id" => "27",
        "franchise_id" => "28",
        "team_name" => "San Jose Earthquakes",
        "abbreviation" => "SJ",
        "link" => "/api/v1/teams/27"
      }
      expect(@stat_tracker.team_info("27")).to eq(expected)
    end
  end

  describe '#best_season' do
    it 'returns the season with the highest win percentage for a team' do
      expect(@stat_tracker.best_season("3")).to eq("20142015")
    end
  end

  describe '#worst_season' do
    it 'returns the season with the lowest win percentage for a team' do
      expect(@stat_tracker.worst_season("3")).to eq("20172018")
    end
  end

  describe '#average_win_percentage' do
    it 'returns the average win percentage of all games for a team' do
      expect(@stat_tracker.average_win_percentage("3")).to eq(0.43)
    end
  end

  describe '#most_goals_scored' do
    it 'returns the highest nuber of goals a particular team has scored in a single game' do
      expect(@stat_tracker.most_goals_scored("3")).to eq(6)
    end
  end

  describe '#fewest_goals_scored' do
    it 'returns the lowest numer of goals a particular team has scored in a single game' do
      expect(@stat_tracker.fewest_goals_scored("3")).to eq(0)
    end
  end

  describe '#favorite_opponent' do
    it 'returns the name of the opponent that has the lowest win percentage against the given team' do
      expect(@stat_tracker.favorite_opponent("3")).to eq("Montreal Impact")
    end
  end

  describe '#rival' do
    it 'returns the name of the opponent that has the highest win percentage against the given team' do
      expect(@stat_tracker.rival("3")).to eq("San Jose Earthquakes")
  end
end
