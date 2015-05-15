require "/Users/sharon/Dropbox/Code/recurse/convert.rb"
require "test/unit"

class TestConversion < Test::Unit::TestCase
    def test_point_slope()
        input = "y - 1 = 2(x - 2)"
        result = run_conversion(input)

        assert_equal(input, result[POINT_SLOPE_FORM])
        assert_equal("y = 2x - 3", result[SLOPE_INTERCEPT_FORM])
        assert_equal("2x - y = 3", result[STANDARD_FORM])
    end

    def test_slope_intercept()
        input = "y = 3x + 2"
        result = run_conversion(input)

        assert_equal("y - 5 = 3(x - 1)", result[POINT_SLOPE_FORM])
        assert_equal(input, result[SLOPE_INTERCEPT_FORM])
        assert_equal("3x - y = -2", result[STANDARD_FORM])
    end

    def test_standard()
        input = "5x + 2y = 3"
        result = run_conversion(input)

        assert_equal("y + 7/2 = (-5/2)(x - 2)", result[POINT_SLOPE_FORM])
        assert_equal("y = (-5/2)x + 3/2", result[SLOPE_INTERCEPT_FORM])
        assert_equal(input, result[STANDARD_FORM])
    end
end
