require "/Users/sharon/Dropbox/Code/recurse/convert.rb"
require "test/unit"

class TestParseValue < Test::Unit::TestCase
    def test_positive_without_number()
        assert_equal(1, parse_value("+"))
    end

    def test_negative_without_number()
        assert_equal(-1, parse_value("-"))
    end

    def test_positive_integer_space()
        assert_equal(2, parse_value("+ 2"))
    end

    def test_negative_integer_space()
        assert_equal(-2, parse_value("- 2"))
    end

    def test_negative_integer_no_space()
        assert_equal(-2, parse_value("-2"))
    end

    def test_positive_fraction()
        assert_equal(Rational(1, 2), parse_value("1/2"))
    end

    def test_negative_fraction()
        assert_equal(Rational(-1, 2), parse_value("-1/2"))
    end

    def test_positive_fraction_space()
        assert_equal(Rational(1, 2), parse_value("+ 1/2"))
    end

    def test_negative_fraction_space()
        assert_equal(Rational(-1, 2), parse_value("- 1/2"))
    end

    def test_parentheses_positive()
        assert_equal(Rational(1, 2), parse_value("(1/2)"))
    end

    def test_parentheses_negative()
        assert_equal(Rational(-1, 2), parse_value("(-1/2)"))
    end
end
