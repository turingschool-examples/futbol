# require './spec/spec_helper'
require_relative './spec_helper'
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

    @game = Game.new(@games, @teams, @game_teams)
  end

  it 'finds all tie games' do
    expect(@game.tie.class).to be Array
    expect(@game.tie.count).to be 3
  end

  # it 'sum_of_games_in_season' do
  #   expect(@game.sum_of_games_in_season("20122013")).to be 5
  #   expect(@game.sum_of_games_in_season("20132014")).to be 3
  #   expect(@game.sum_of_games_in_season("20152016")).to be 1
  #   expect(@game.sum_of_games_in_season("20172018")).to be 9
  # end
end
