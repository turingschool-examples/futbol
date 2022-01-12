require './spec/spec_helper'
require './lib/stat_tracker'
require './lib/game.rb'
require './lib/league.rb'
require './lib/team.rb'
require './lib/season.rb'
require 'csv'

RSpec.describe 'Season Stats' do
  before(:each) do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol

    @season = Season.new(@games, @teams, @game_teams)

  end

  it 'win percentage by coach' do
    expect(@season.win_percentage_by_coach("20172018").class).to be Hash
    expect(@season.win_percentage_by_coach("20172018").keys).to include "Mike Sullivan"
  end

  it 'games in season' do
    expect(@season.games_in_season("20172018").class).to be Array
    expect(@season.games_in_season("20172018").first.class).to be CSV::Row
  end


  it 'total goals per season works' do
    expected = {
      "15"  => 9.0,
      "5"   => 10.0,
      "30"  => 7.0,
      "52"  => 12.0
    }
    expect(@season.total_goals_per_season("20172018")).to eq expected
  end

  it 'total shots per season works' do
    expected = {
      "15"  => 25.0,
      "5"   => 25.0,
      "30"  => 30.0,
      "52"  => 41.0
    }
    expect(@season.total_shots_per_season("20172018")).to eq expected
  end

  it 'gives a hash of games in season by datatype' do
    expect(@season.games_in_season_by_datatype("20172018", :team_id).class).to be Hash
    expect(@season.games_in_season_by_datatype("20172018", :team_id).keys).to include "30"
  end

  it 'tackles per season' do
    expect(@season.tackles_per_season("20172018").class).to be Hash
    expect(@season.tackles_per_season("20172018").keys).to include "30"
  end
end
