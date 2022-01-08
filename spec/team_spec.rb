require './spec/spec_helper'
require './lib/stat_tracker'
require './lib/game.rb'
require './lib/league.rb'
require './lib/team.rb'
require './lib/season.rb'
require 'csv'

RSpec.describe Team do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol

    @team = Team.new(@games, @teams, @game_teams)
  end

  it 'gives a hash of team info' do
    expected = {
      "Team ID" => "1",
      "Franchise ID" => "23",
      "Team Name" => "Atlanta United",
      "Abbreviation" => "ATL",
      "Link" => '/api/v1/teams/1',
    }

    expect(@team.team_info("1")).to eq(expected)
  end

  it 'finds the season that a game belongs to' do
    expect(@team.season_finder("2012020225")).to eq "20122013"
    expect(@team.season_finder("2013020177")).to eq "20132014"
    expect(@team.season_finder("2017030163")).to eq "20172018"
  end

  it 'finds the games played by a team in a season' do
    expect(@team.games_played_in_season("24", "20132014").count).to eq 1
    expect(@team.games_played_in_season("24", "20122013").count).to eq 2
  end

  it 'finds a teams average wins for a season' do
    expect(@team.avg_wins_by_season("24", "20132014")).to eq 1
    expect(@team.avg_wins_by_season("24", "20122013")).to eq 0.75
  end

  it 'finds all the seasons a team has played in' do
    expect(@team.all_seasons_played('24')).to eq ["20132014", "20122013"]
  end

  it 'finds the best season' do
    expect(@team.best_season("24")).to eq "20132014"
    expect(@team.best_season("28")).to eq "20152016"
    expect(@team.best_season("29")).to eq "20132014"
    expect(@team.best_season("30")).to eq "20122013"
  end

  it 'finds the worst season' do
    expect(@team.worst_season("24")).to eq "20122013"
    expect(@team.worst_season("28")).to eq "20122013"
    expect(@team.worst_season("29")).to eq "20122013"
    expect(@team.worst_season("30")).to eq "20172018"
  end

  it 'finds all games played' do
    expect(@team.all_games_played("24").count).to be 3
    expect(@team.all_games_played("24").class).to be Array
  end

  it 'calculates average win percentage of all games' do
    expect(@team.average_win_percentage("24")).to eq 66.67
    expect(@team.average_win_percentage("28")).to eq 50
    expect(@team.average_win_percentage("29")).to eq 0
    expect(@team.average_win_percentage("30")).to eq 16.67
  end

  it 'gives highest number of goals in a single game' do
    expect(@team.most_goals_scored("24")).to eq 3
    expect(@team.most_goals_scored("18")).to eq 0
    expect(@team.most_goals_scored("29")).to eq 2
    expect(@team.most_goals_scored("30")).to eq 4
  end

  it 'gives lowest number of goals in a single game' do
    expect(@team.fewest_goals_scored("24")).to eq 3
    expect(@team.fewest_goals_scored("18")).to eq 0
    expect(@team.fewest_goals_scored("15")).to eq 1
    expect(@team.fewest_goals_scored("30")).to eq 0
  end

  it 'finds all the games against one opponent' do
    expect(@team.all_games_against("15", "5").count).to be 4
    expect(@team.all_games_against("30", "52").count).to be 5
    expect(@team.all_games_against("52", "30").count).to be 5
    expect(@team.all_games_against("30", "52").class).to be Array
  end

  it 'finds an opponents rate of wins against the team' do
    expect(@team.win_against_rate("15", "5")).to eq 0.5
    expect(@team.win_against_rate("30", "52")).to eq 0.8
    expect(@team.win_against_rate("52", "30")).to eq 0.2
    expect(@team.win_against_rate("30", "26")).to eq 0
  end

  it 'finds all of a teams opponents' do
    expect(@team.all_opponents("1")).to eq ["2"]
    expect(@team.all_opponents("30")).to eq ["26", "52"]
    expect(@team.all_opponents("24")).to eq ["4", "28", "29"]
  end

  it 'finds its name' do
    expect(@team.find_name("2")).to eq "Seattle Sounders FC"
    expect(@team.find_name("13")).to eq "Houston Dash"
    expect(@team.find_name("25")).to eq "Chicago Red Stars"
    expect(@team.find_name("53")).to eq "Columbus Crew SC"
  end

  it 'builds an opponent rundown' do
    expected = {
      "Orlando City SC"=>0.2,
    }
    expect(@team.opponent_rundown("52")).to eq expected

    expected = {
      "Portland Thorns FC"=>0.8,
      "FC Cincinnati"=>0
    }
    expect(@team.opponent_rundown("30")).to eq expected

    expected = {
      "Chicago Fire"=>0,
      "Los Angeles FC"=>0,
      "Orlando Pride"=>0
    }
    expect(@team.opponent_rundown("24")).to eq expected
  end

  it 'names a favorite opponent' do
    expect(@team.favorite_opponent("24")).to eq("Chicago Fire").or(eq("Orlando Pride"))
    expect(@team.favorite_opponent("30")).to eq "FC Cincinnati"
    expect(@team.favorite_opponent("52")).to eq "Orlando City SC"
  end

  it 'names a rival' do
    expect(@team.rival("24")).to eq("Los Angeles FC").or(eq("Chicago Fire")).or(eq("Orlando Pride"))
    expect(@team.rival("30")).to eq "Portland Thorns FC"
    expect(@team.rival("52")).to eq "Orlando City SC"
  end
end
