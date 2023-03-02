require 'spec_helper'

RSpec.describe Season do
  let(:season_1) { Season.new(DATA, []) }
  let(:season_2) { Season.new(DATA, []) }

  describe '#initialize' do
    it 'exists' do
      expect(season_1).to be_a(Season)
      expect(season_2).to be_a(Season)
    end
  end

  describe '#year' do
    it 'has a year' do
      expect(season_1.year).to eq('20122013')
    end
  end

  describe '#type' do
    it 'has a type' do
      expect(season_1.type).to eq('Postseason')
    end
  end

  describe '#teams' do
    it 'has a list of teams' do
      actual = season_1.teams.all? do |team|
        team.is_a?(Team)
      end

      expect(actual).to eq(true)
    end
  end

  describe '#games' do
    it 'has a list of games' do
      actual = season_1.games.all? do |game|
        game.is_a?(Game)
      end

      expect(actual).to eq(true)
    end
  end
end
