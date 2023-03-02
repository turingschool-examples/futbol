require 'spec_helper'

RSpec.describe League do
  subject(:league) { League.new(:futbol, DATA) }

  describe '#initialize' do
    it 'exists' do
      expect(league).to be_a(League)
    end
  end

  describe '#name' do
    it 'has a name' do
      expect(league.name).to eq(:futbol)
    end
  end

  describe '#teams' do
    it 'has a list of teams' do
      actual = league.teams.all? do |team|
        team.is_a?(Team)
      end

      expect(actual).to eq(true)
    end
  end

  describe '#seasons' do
    it 'has a list of seasons' do
      actual = league.seasons.all? do |season|
        season.is_a?(Season)
      end

      expect(actual).to eq(true)
    end
  end
end
