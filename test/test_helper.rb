require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
Dir["./lib/*"].each{|file| require file}
SimpleCov.start
