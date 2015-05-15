require "/Users/sharon/Dropbox/Code/recurse/convert.rb"
require "test/unit"

class TestStandard < Test::Unit::TestCase
    def test_basic()
        equation = "5x + 2y = 3"

        # Identity tests: verify that we can correctly identify a
        # well-formed equation as being in Standard form.
        assert_equal(STANDARD_FORM, identify(equation))

        # Parsing tests: verify that we can correctly extract a, b, and c
        # from any well-formed equation in Standard form.
        a, b, c = parse_standard(equation)
        assert_equal(5, a)
        assert_equal(2, b)
        assert_equal(3, c)

        # Conversion tests: verify that we can convert any equation from
        # Standard to Point-Slope form.
        assert_equal("y + 7/2 = (-5/2)(x - 2)", standard_to_point_slope(equation))

        # More conversion tests: verify that we can convert any equation from
        # Standard form to Slope-Intercept form.
        assert_equal("y = (-5/2)x + 3/2", standard_to_slope_intercept(equation))
    end

    def test_negative_b()
        equation = "5x - 2y = 3"

        assert_equal(STANDARD_FORM, identify(equation))

        a, b, c = parse_standard(equation)
        assert_equal(5, a)
        assert_equal(-2, b)
        assert_equal(3, c)

        assert_equal("y - 7/2 = (5/2)(x - 2)", standard_to_point_slope(equation))

        assert_equal("y = (5/2)x - 3/2", standard_to_slope_intercept(equation))
    end

    def test_negative_c()
        equation = "5x + 2y = -3"

        assert_equal(STANDARD_FORM, identify(equation))

        a, b, c = parse_standard(equation)
        assert_equal(5, a)
        assert_equal(2, b)
        assert_equal(-3, c)

        assert_equal("y + 13/2 = (-5/2)(x - 2)", standard_to_point_slope(equation))

        assert_equal("y = (-5/2)x - 3/2", standard_to_slope_intercept(equation))
    end

    def test_negative_b_c()
        equation = "5x - 2y = -3"

        assert_equal(STANDARD_FORM, identify(equation))

        a, b, c = parse_standard(equation)
        assert_equal(5, a)
        assert_equal(-2, b)
        assert_equal(-3, c)

        assert_equal("y - 13/2 = (5/2)(x - 2)", standard_to_point_slope(equation))

        assert_equal("y = (5/2)x + 3/2", standard_to_slope_intercept(equation))
    end
end
