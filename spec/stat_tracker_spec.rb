require './spec/spec_helper'
require './lib/game.rb'
require './lib/league.rb'
require './lib/team.rb'
require './lib/season.rb'
require 'csv'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end

  it 'exists' do
    stat_tracker = StatTracker.new(@locations)
    expect(stat_tracker).to be_instance_of StatTracker
  end

  it 'loads from csv' do
    stat_tracker = StatTracker.from_csv(@locations)
    expect(stat_tracker).to be_instance_of StatTracker
    expect(stat_tracker.games.class).to be CSV::Table
    expect(stat_tracker.teams.class).to be CSV::Table
    expect(stat_tracker.game_teams.class).to be CSV::Table
  end
end

RSpec.describe 'Game Stats' do
  before(:each) do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end
##########Game Stats#############
  it 'reports highest total score' do
    expect(@stat_tracker.highest_total_score).to be 7
  end

  it 'reports lowest total score' do
    expect(@stat_tracker.lowest_total_score).to be 2
  end

  it 'reports percentage home wins' do
    expect(@stat_tracker.percentage_home_wins).to eq(0.61)
  end

  it 'reports percentage visitor wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.22)
  end

  it 'can find the percentage of games that ended in a tie' do
    expect(@stat_tracker.percentage_ties).to eq(0.17)
  end

  it 'can count games by season' do
    expect(@stat_tracker.count_of_games_by_season).to be_a(Hash)
    expect(@stat_tracker.count_of_games_by_season).to include('20172018' => 9)
  end

  it 'reports average goals per game' do
    expect(@stat_tracker.average_goals_per_game).to be 4.39
  end

  it 'reports average goals per game by season' do
    expected = {
      '20122013' => 5.2,
      '20132014' => 4,
      '20152016' => 3,
      '20172018' => 4.22
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end
end
#### League Stats #############
RSpec.describe 'League Stats' do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'can count total teams in data' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it 'can return the best offense in data' do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it 'can return the worst offense in data' do
    expect(@stat_tracker.worst_offense).to eq("Seattle Sounders FC")
  end

  it 'finds the highest scoring visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq("Atlanta United").or(eq("FC Cincinnati")).or(eq("Sporting Kansas City")).or(eq("Los Angeles FC")).or(eq("Real Salt Lake"))
  end

  it 'finds the highest scoring home team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Portland Timbers").or(eq("FC Dallas"))
  end

  it 'finds the lowest scoring visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "Minnesota United FC"
  end

  it 'finds the lowest scoring home team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Seattle Sounders FC"
  end
end

###########season stats tests##################
RSpec.describe 'Season Stats' do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'reports winningest coach' do
    expect(@stat_tracker.winningest_coach("20172018")).to eq("Paul Maurice")
  end

  it 'reports worst coach' do
    expect(@stat_tracker.worst_coach("20172018")).to eq("Bruce Boudreau")
  end

  it 'reports most accurate team re: goals / shots' do
    expect(@stat_tracker.most_accurate_team("20172018")).to eq("Sporting Kansas City")
  end

  it 'reports least accurate team re: goals / shots' do
    expect(@stat_tracker.least_accurate_team("20172018")).to eq("Orlando City SC")
  end

  it 'reports most tackles per season' do
    expect(@stat_tracker.most_tackles("20172018")).to eq("Portland Thorns FC")
  end

  it 'reports fewest tackles per season' do
    expect(@stat_tracker.fewest_tackles("20172018")).to eq("Orlando City SC")
  end
end
##################team stats#############################

RSpec.describe 'Team Stats' do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'gives a hash of team info' do
    expected = {
      "team_id" => "1",
      "franchise_id" => "23",
      "team_name" => "Atlanta United",
      "abbreviation" => "ATL",
      "link" => '/api/v1/teams/1',
    }
    expect(@stat_tracker.team_info("1")).to eq(expected)
  end

  it 'finds the best season' do
    expect(@stat_tracker.best_season("24")).to eq "20132014"
    expect(@stat_tracker.best_season("28")).to eq "20152016"
    expect(@stat_tracker.best_season("29")).to eq "20122013"
    expect(@stat_tracker.best_season("30")).to eq "20172018"
  end

  it 'finds the worst season' do
    expect(@stat_tracker.worst_season("24")).to eq "20122013"
    expect(@stat_tracker.worst_season("28")).to eq "20122013"
    expect(@stat_tracker.worst_season("29")).to eq "20122013"
    expect(@stat_tracker.worst_season("30")).to eq "20122013"
  end

  it 'calculates average win percentage of all games' do
    expect(@stat_tracker.average_win_percentage("24")).to eq 0.67
    expect(@stat_tracker.average_win_percentage("28")).to eq 0.50
    expect(@stat_tracker.average_win_percentage("29")).to eq 0.0
    expect(@stat_tracker.average_win_percentage("30")).to eq 0.17
  end

  it 'gives highest number of goals in a single game' do
    expect(@stat_tracker.most_goals_scored("24")).to eq 3
    expect(@stat_tracker.most_goals_scored("18")).to eq 0
    expect(@stat_tracker.most_goals_scored("29")).to eq 2
    expect(@stat_tracker.most_goals_scored("30")).to eq 4
  end

  it 'gives lowest number of goals in a single game' do
    expect(@stat_tracker.fewest_goals_scored("24")).to eq 3
    expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
    expect(@stat_tracker.fewest_goals_scored("15")).to eq 1
    expect(@stat_tracker.fewest_goals_scored("30")).to eq 0
  end

  it 'names a favorite opponent' do
    expect(@stat_tracker.favorite_opponent("24")).to eq("Chicago Fire").or(eq("Orlando Pride"))
    expect(@stat_tracker.favorite_opponent("30")).to eq "FC Cincinnati"
    expect(@stat_tracker.favorite_opponent("52")).to eq "Orlando City SC"
  end

  it 'names a rival' do
    expect(@stat_tracker.rival("24")).to eq("Los Angeles FC").or(eq("Chicago Fire")).or(eq("Orlando Pride"))
    expect(@stat_tracker.rival("30")).to eq "Portland Thorns FC"
    expect(@stat_tracker.rival("52")).to eq "Orlando City SC"
  end
end
