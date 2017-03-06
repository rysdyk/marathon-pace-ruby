
require 'minitest/autorun'
require './marathon_analysis.rb'

class MileTest < MiniTest::Test

  def test_mile_time
    assert_equal "09:09", average_mile("4:00")
    assert_equal "09:09", average_mile("4:00:00")
  end
end
