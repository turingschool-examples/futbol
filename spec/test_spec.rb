require 'spec_helper'
require 'test.rb'
require "rspec"

describe Class do
  it 'exists' do
    class = Class.new("test")
    expect(class).to be_an_instance_of(Class)
  end

  it 'attributes' do
    class = Class.new("test")
    expect(class.name).to eq('test')
  end
end
