require 'helper'

class TestPeatioClient < MiniTest::Unit::TestCase

  def test_initialize_without_keys
    assert_raises ArgumentError do
      PeatioClient.new
    end
  end

end
