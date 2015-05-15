require "/Users/sharon/Dropbox/Code/recurse/convert.rb"
require "test/unit"

class TestSlopeIntercept < Test::Unit::TestCase
    def test_basic()
        equation = "y = 3x + 2"

        # Identity tests: verify that we can correctly identify a
        # well-formed equation as being in Point-Slope form.
        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        # Parsing tests: verify that we can correctly extract m and b
        # from any well-formed equation in Slope-Intercept form.
        m, b = parse_slope_intercept(equation)
        assert_equal(3, m)
        assert_equal(2, b)

        # Conversion tests: verify that we can convert any equation from
        # Slope-Intercept to Point-Slope form.
        assert_equal("y - 5 = 3(x - 1)", slope_intercept_to_point_slope(equation))

        # More conversion tests: verify that we can convert any equation from
        # Slope-Intercept form to Standard form.
        assert_equal("3x - y = -2", slope_intercept_to_standard(equation))
    end

    def test_negative_slope()
        equation = "y = -3x + 2"

        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        m, b = parse_slope_intercept(equation)
        assert_equal(-3, m)
        assert_equal(2, b)

        assert_equal("y + 1 = -3(x - 1)", slope_intercept_to_point_slope(equation))

        assert_equal("3x + y = 2", slope_intercept_to_standard(equation))
    end

    def test_fractional_slope()
        equation = "y = (3/2)x + 2"

        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        m, b = parse_slope_intercept(equation)
        assert_equal(Rational(3, 2), m)
        assert_equal(2, b)

        assert_equal("y - 5 = (3/2)(x - 2)", slope_intercept_to_point_slope(equation))

        assert_equal("3x - 2y = -4", slope_intercept_to_standard(equation))
    end

    def test_negative_fractional_slope()
        equation = "y = (-3/2)x + 2"

        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        m, b = parse_slope_intercept(equation)
        assert_equal(Rational(-3, 2), m)
        assert_equal(2, b)

        assert_equal("y + 1 = (-3/2)(x - 2)", slope_intercept_to_point_slope(equation))

        assert_equal("3x + 2y = 4", slope_intercept_to_standard(equation))
    end

    def test_negative_intercept()
        equation = "y = 3x - 2"

        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        m, b = parse_slope_intercept(equation)
        assert_equal(3, m)
        assert_equal(-2, b)

        assert_equal("y - 1 = 3(x - 1)", slope_intercept_to_point_slope(equation))

        assert_equal("3x - y = 2", slope_intercept_to_standard(equation))
    end

    def test_fractional_intercept()
        equation = "y = 3x + 2/3"

        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        m, b = parse_slope_intercept(equation)
        assert_equal(3, m)
        assert_equal(Rational(2, 3), b)

        assert_equal("y - 11/3 = 3(x - 1)", slope_intercept_to_point_slope(equation))

        assert_equal("9x - 3y = -2", slope_intercept_to_standard(equation))
    end

    def test_negative_fractional_intercept()
        equation = "y = 3x - 2/3"

        assert_equal(SLOPE_INTERCEPT_FORM, identify(equation))

        m, b = parse_slope_intercept(equation)
        assert_equal(3, m)
        assert_equal(Rational(-2, 3), b)

        assert_equal("y - 7/3 = 3(x - 1)", slope_intercept_to_point_slope(equation))

        assert_equal("9x - 3y = 2", slope_intercept_to_standard(equation))
    end
end
