require './spec_helper.rb'
require './lib/stat_tracker.rb'
require './runner.rb'

RSpec.describe StatTracker do
  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end



  xit 'exists' do
    expect(stat_tracker).to be_instance_of(StatTracker)
  end

  ##Game Statistics Methods

  xit 'can display the highest total score' do
    #game_teams_dummy
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  xit 'it can display lowest total score' do
    #game_teams_dummy
    expect(stat_tracker.lowest_total_score).to eq(1)
  end

  xit 'it can display total wins by home team as percentage' do
    #game_teams_dummy
    expect(stat_tracker.percentage_home_wins).to eq(0.50)
  end

  xit 'can find the percentage of games that a visitor has won' do
    #game_teams_dummy
    expect(stat_tracker.percentage_visitor_wins).to eq(0.17)
  end

  xit 'can find the percentage of games that resulted in a tie' do
    #game_teams_dummy
    expect(stat_tracker.percentage_ties).to eq(0.33)
  end

  xit 'can sort the number of games attributed to each season' do
    #games_dummy
    expected = {
      "20122013" => 6,
      "20132014" => 5
    }

    expect(stat_tracker.count_of_games_by_season).to eq(expected)
  end

  xit 'can calculate average goals per game across seasons' do
    #games_dummy
    expect(stat_tracker.average_goals_per_game).to eq(3.56)
  end

  xit 'can organize average goals per game by season' do
    #games_dummy
    expected = {
      "20122013" => 3.33,
      "20132014" => 4.20
    }
    expect(stat_tracker.average_goals_by_season).to eq(expected)
  end
  ##League Stats Methods

  xit 'count the total number of teams' do
    #teams_dummy
    expect(stat_tracker.count_of_teams).to eq(10)
  end

  xit 'can calculate the best offense' do
    #games_dummy & #teams_dummy
    # Name of the team with the highest average
    # number of goals scored per game across all seasons.
    expect(stat_tracker.best_offense).to eq("FC Dallas")
  end

  xit 'can calculate the worst offense' do
    #games_dummy & #teams_dummy
    # Name of the team with the worst average
    # number of goals scored per game across all seasons.
    expect(stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  xit 'can calculate the highest scoring visitor' do
      #games_dummy & #teams_dummy
    expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  xit 'can calculate the highest scoring home_team' do
    #games_dummy & #teams_dummy
    expect(stat_tracker.highest_scoring_home_team).to eq("Sky Blue FC")
  end

  xit 'can calculate the lowewst scoring visitor' do
    #games_dummy & #teams_dummy
    expect(stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  xit 'can calculate the lowest scoring home team' do
    #games_dummy & #teams_dummy
    expect(stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

  ##Season Statistics

  xit 'can name the coach with the best win percentage' do
    #coach in games_teams_dummy, season in games_dummy
    expect(stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    expect(stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
  end

  xit 'can name the coach with the worst win percentage' do
    #coach in games_teams_dummy, season in games_dummy
    expect(stat_tracker.worst_coach("20132014")).to eq("John Tortorella")
    expect(stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
  end

  xit 'can calculate the most accurate team' do

    expect(stat_tracker.most_accurate_team("20122013")).to eq("LA Galaxy")
  end

  xit 'can calculate the least accurate team'do

    expect(stat_tracker.least_accurate_team("20122013")).to eq("Seatle Sounders")
  end

  xit 'can find the team with the most tackles' do

    expect(stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
  end

  xit 'can find the team with the least tackles' do

    expect(stat_tracker.fewest_tackles("20122013")).to eq("Houston Dynamo")
  end

  ## TEAM Statistics
  xit 'can provide team info' do
    expected = {
      "team_id" => "1",
      "franchise_id" => "23",
      "team_name" => "Atlanta United",
      "abbreviation" => "ATL",
      "link" => "/api/v1/teams/1"
    }

    expect(stat_tracker.team_info("1")).to eq(expected)
  end

  xit 'can calculate the season with the best win percent' do

    expect(stat_tracker.best_season("3")).to eq("20122013")
  end

  xit 'can calculate the season with the worst win percent' do

    expect(stat_tracker.worst_season("24")).to eq("20122013")
  end

  xit 'can calcuate the average win percentage' do

    expect(stat_tracker.average_win_percentage("6")).to eq(0.75)
  end

  xit 'can report the highest goals in a single game' do

    expect(stat_tracker.most_goals_scored("6")). to eq(3)
  end

  xit 'can report the fewest goals scored in a game' do

    expect(stat_tracker.fewest_goals_scored("19")). to eq(0)
  end

  xit 'can show which opponent cant beat bae' do

    expect(stat_tracker.favorite_opponent("6")).to eq("Houstoun Dynamo")
  end

  xit 'can show a teams rival' do

    expect(stat_tracker.rival("3")).to eq("FC Dallas")
  end
end
