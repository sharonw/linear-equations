require "/Users/sharon/Dropbox/Code/recurse/convert.rb"
require "test/unit"

class TestPointSlope < Test::Unit::TestCase
    def test_basic()
        equation = "y - 1 = 2(x - 2)"

        # Identity tests: verify that we can correctly identify a
        # well-formed equation as being in Point-Slope form.
        assert_equal(POINT_SLOPE_FORM, identify(equation))

        # Parsing tests: verify that we can correctly extract m, x1, and y1
        # from any well-formed equation in Point-Slope form.
        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(2, x1)
        assert_equal(1, y1)

        # Conversion tests: verify that we can convert any equation from
        # Point-Slope form to Slope-Intercept form.
        assert_equal("y = 2x - 3", point_slope_to_slope_intercept(equation))

        # More conversion tests: verify that we can convert any equation from
        # Point-Slope form to Standard form.
        assert_equal("2x - y = 3", point_slope_to_standard(equation))
    end

    def test_negative_slope()
        equation = "y - 1 = -2(x - 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(-2, m)
        assert_equal(2, x1)
        assert_equal(1, y1)

        assert_equal("y = -2x + 5", point_slope_to_slope_intercept(equation))

        assert_equal("2x + y = 5", point_slope_to_standard(equation))
    end

    def test_negative_y1()
        equation = "y + 1 = 2(x - 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(2, x1)
        assert_equal(-1, y1)

        assert_equal("y = 2x - 5", point_slope_to_slope_intercept(equation))

        assert_equal("2x - y = 5", point_slope_to_standard(equation))
    end

    def test_negative_x1()
        equation = "y - 1 = 2(x + 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(-2, x1)
        assert_equal(1, y1)

        assert_equal("y = 2x + 5", point_slope_to_slope_intercept(equation))

        assert_equal("2x - y = -5", point_slope_to_standard(equation))
    end

    def test_negative_y1_x1()
        equation = "y + 1 = 2(x + 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(-2, x1)
        assert_equal(-1, y1)

        assert_equal("y = 2x + 3", point_slope_to_slope_intercept(equation))

        assert_equal("2x - y = -3", point_slope_to_standard(equation))
    end

    def test_negative_slope_y1_x1()
        equation = "y + 1 = -2(x + 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(-2, m)
        assert_equal(-2, x1)
        assert_equal(-1, y1)

        assert_equal("y = -2x - 5", point_slope_to_slope_intercept(equation))

        assert_equal("2x + y = -5", point_slope_to_standard(equation))
    end

    def test_fractional_slope()
        equation = "y - 1 = (2/3)(x - 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(Rational(2, 3), m)
        assert_equal(2, x1)
        assert_equal(1, y1)

        assert_equal("y = (2/3)x - 1/3", point_slope_to_slope_intercept(equation))

        assert_equal("2x - 3y = 1", point_slope_to_standard(equation))
    end

    def test_fractional_y1()
        equation = "y - 1/2 = 2(x - 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(2, x1)
        assert_equal(Rational(1, 2), y1)

        assert_equal("y = 2x - 7/2", point_slope_to_slope_intercept(equation))

        assert_equal("4x - 2y = 7", point_slope_to_standard(equation))
    end

    def test_fractional_x1()
        equation = "y - 1 = 2(x - 2/3)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(Rational(2, 3), x1)
        assert_equal(1, y1)

        assert_equal("y = 2x - 1/3", point_slope_to_slope_intercept(equation))

        assert_equal("6x - 3y = 1", point_slope_to_standard(equation))
    end

    def test_fractional_y1_x1()
        equation = "y - 1/2 = 2(x - 2/3)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(Rational(2, 3), x1)
        assert_equal(Rational(1, 2), y1)

        assert_equal("y = 2x - 5/6", point_slope_to_slope_intercept(equation))

        assert_equal("12x - 6y = 5", point_slope_to_standard(equation))
    end

    def test_negative_fractional_slope()
        equation = "y - 1 = (-2/3)(x - 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(Rational(-2, 3), m)
        assert_equal(2, x1)
        assert_equal(1, y1)

        assert_equal("y = (-2/3)x + 7/3", point_slope_to_slope_intercept(equation))

        assert_equal("2x + 3y = 7", point_slope_to_standard(equation))
    end

    def test_negative_fractional_y1()
        equation = "y + 1/2 = 2(x - 2)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(2, x1)
        assert_equal(Rational(-1, 2), y1)

        assert_equal("y = 2x - 9/2", point_slope_to_slope_intercept(equation))

        assert_equal("4x - 2y = 9", point_slope_to_standard(equation))
    end

    def test_negative_fractional_x1()
        equation = "y - 1 = 2(x + 2/3)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(Rational(-2, 3), x1)
        assert_equal(1, y1)

        assert_equal("y = 2x + 7/3", point_slope_to_slope_intercept(equation))

        assert_equal("6x - 3y = -7", point_slope_to_standard(equation))
    end

    def test_negative_fractional_y1_x1()
        equation = "y + 1/2 = 2(x + 2/3)"

        assert_equal(POINT_SLOPE_FORM, identify(equation))

        m, x1, y1 = parse_point_slope(equation)
        assert_equal(2, m)
        assert_equal(Rational(-2, 3), x1)
        assert_equal(Rational(-1, 2), y1)

        assert_equal("y = 2x + 5/6", point_slope_to_slope_intercept(equation))

        assert_equal("12x - 6y = -5", point_slope_to_standard(equation))
    end
end
