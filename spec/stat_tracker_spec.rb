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

  xdescribe '#instance of stat_tracker' do
    it 'exists' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
    end
  end

# Game Statistics Tests

  xdescribe '#highest_total_score' do
    it 'returns an integer' do
      expect(@stat_tracker.highest_total_score).to be_an_instance_of Integer
    end

    it 'returns highest total of winning and losing team score by game' do
      expect(@stat_tracker.highest_total_score).to eq 11
    end
  end

  xdescribe '#lowest_total_score' do
    it 'returns an integer' do
      expect(@stat_tracker.lowest_total_score).to be_an_instance_of Integer
    end

    it 'returns lowest total of winning and losing team score by game' do
      expect(@stat_tracker.lowest_total_score).to eq 0
    end
  end

  xdescribe '#total_games_count' do
    it 'returns the total number of games' do
      expect(@stat_tracker.total_games_count).to be_an_instance_of Float

      expect(@stat_tracker.total_games_count).to eq 7441.0
    end
  end

  xdescribe '#home_wins_count' do
    it 'counts the number of times home team outscored away team' do
      expect(@stat_tracker.home_wins_count).to be_an_instance_of Float

      expect(@stat_tracker.home_wins_count).to eq 3237.0
    end
  end

  xdescribe '#percentage_home_wins' do
    it 'returns a float' do
      expect(@stat_tracker.percentage_home_wins).to be_an_instance_of Float
    end

    it 'percentage of games won by the home team' do
      expect(@stat_tracker.percentage_home_wins).to eq 43.50
    end
  end

  xdescribe '#visitor_wins_count' do
    it 'counts the numbers of times away team outscored home team' do
      expect(@stat_tracker.visitor_wins_count).to be_an_instance_of Float

      expect(@stat_tracker.visitor_wins_count).to eq 2687.0
    end
  end

  xdescribe '#percentage_visitor_wins' do
    it 'returns a float' do
      expect(@stat_tracker.percentage_visitor_wins).to be_an_instance_of Float

      expect(@stat_tracker.percentage_visitor_wins).to eq 36.11
    end
  end

  xdescribe '#tied_games_count' do
    it 'returns a float' do
      expect(@stat_tracker.tied_games_count).to be_an_instance_of Float

      expect(@stat_tracker.tied_games_count).to eq 1517.0
    end
  end

  xdescribe '#percentage_ties' do
    it 'returns the percentage of game where the scores were equal' do
      expect(@stat_tracker.percentage_ties).to be_an_instance_of Float

      expect(@stat_tracker.percentage_ties).to eq 20.39
    end
  end

  xdescribe '#total_goals' do
    it 'counts the total number of away_goals and home_goals' do
      expect(@stat_tracker.total_goals).to be_an_instance_of Float

      expect(@stat_tracker.total_goals).to eq 31413.0
    end
  end

  xdescribe '#average_goals_per_game' do
    it 'divides the total number of goals by the total number of games' do
      expect(@stat_tracker.average_goals_per_game).to be_an_instance_of Float

      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end
  end

  xdescribe '#count_of_games_by_season' do
    it 'returns array with season id as key and count as value' do
      @stat_tracker.count_of_games_by_season
      expect(@stat_tracker.count_of_games_by_season).to be_an_instance_of Hash
    end

    it 'has helper get_season_ids' do
      # require "pry"; binding.pry
      expect(@stat_tracker.get_season_ids).to be_an_instance_of Array

      expect(@stat_tracker.get_season_ids).to include("20132014")
      expect(@stat_tracker.get_season_ids).to include("20162017")
      expect(@stat_tracker.get_season_ids).to include("20172018")
    end
  end

  xdescribe '#average_goals_by_season' do
    it 'returns hash with sesaon id as key and float of average number of goals per game as value' do
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

# League Statistics Tests


# Season Statistics Tests


# Team Statistics Tests
