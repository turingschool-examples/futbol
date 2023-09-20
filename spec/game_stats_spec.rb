require 'pry'
require 'simplecov'
require 'spec_helper'

SimpleCov.start

describe GameStats do
  describe '#initiallize' do
    it 'is created as an instance of the GameStats class' do
      expect(GameStats).to be_a Module
    end
  end
end