#
# Convert a linear equation between three common forms.
#
# Given an input equation in Point-Slope form, Slope-Intercept form, or
# Standard form, echo the input and display the equation in the other two
# forms.
#
# Point-Slope form
#   (y - y1) = m(x - x1)
#
# Slope-Intercept form
#   y = mx + b
#
# Standard form
#   ax + by = c
#
# To maintain regexes, test them here: http://rubular.com/
#

POINT_SLOPE_FORM = 0
SLOPE_INTERCEPT_FORM = 1
STANDARD_FORM = 2

def identify(equation)
  # Slope-intercept form always starts with "y =" and nothing else.
  if (equation[0] == 'y' && equation[2] == '=')

    SLOPE_INTERCEPT_FORM

  # Point-Slope form has a y term and a constant term before the equal sign.
  # It does not have an x term on the left side of the equation.
  elsif (equation.index('y') < equation.index('=') &&
    equation.index('x') > equation.index('='))

    POINT_SLOPE_FORM

  # Standard form has an x term and a y term before the equal sign.
  # It does not have a constant term on the left side of the equation.
  elsif (equation.index('x') < equation.index('=') &&
    equation.index('y') < equation.index('='))

    STANDARD_FORM

  else
    -1
  end
end

def parse_value(string)
  # Remove any parentheses.
  if (string[0] == '(' && string[-1] == ')')
    string = string[1..-2]
  end

  sign = string[0] == '-' ? -1 : 1

  # Remove + or - and any whitespace.
  if (string[0] == '+' || string[0] == '-')
    number = string[1] == ' ' ? string[2..-1] : string[1..-1]
  else
    number = string
  end

  # Parse the string as a Rational.
  value = number.to_r

  # Reduce the Rational to an integer if possible.
  reduced_value = value.denominator == 1 ? value.numerator : value

  sign * reduced_value
end

def parse_point_slope(equation)
  # Search the equation for an integer or fraction that looks like m.
  m_string_fraction = equation.scan(/\(-?\d+\/\d+\)\(x/)
  m_string_integer = equation.scan(/-?\d+\(x/)

  # If there's a fraction, use it. Otherwise, use the integer. Either way,
  # extract the value and discard the opening parenthesis and the x.
  m = m_string_fraction != [] ?
    parse_value(m_string_fraction[0][0..-3]) :
    parse_value(m_string_integer[0][0..-3])

  # Search the equation for an integer or fraction that looks like y1.
  y1_string_fraction = equation.scan(/y\s[-+]\s\d+\/\d+/)
  y1_string_integer = equation.scan(/y\s[-+]\s\d+/)

  # If there's a fraction, use it. Otherwise, use the integer. Either way,
  # extract the value and discard the y and the preceding space.
  y1 = y1_string_fraction != [] ?
    parse_value(y1_string_fraction[0][2..-1]) :
    parse_value(y1_string_integer[0][2..-1])

  # Search the equation for an integer or fraction that looks like x1.
  x1_string_fraction = equation.scan(/x\s[-+]\s\d+\/\d+/)
  x1_string_integer = equation.scan(/x\s[-+]\s\d+/)

  # If there's a fraction, use it. Otherwise, use the integer. Either way,
  # extract the value and discard the x and the preceding space.
  x1 = x1_string_fraction != [] ?
    parse_value(x1_string_fraction[0][2..-1]) :
    parse_value(x1_string_integer[0][2..-1])

  # Flip the signs for x1 and y1 because of how the negative signs in
  # Point-Slope form are parsed: (y - y1) = m(x - x1)
  [m, -x1, -y1]
end

def point_slope_to_slope_intercept(equation)
  m, x1, y1 = parse_point_slope(equation)

  # Isolate y on the left side of the equation.
  c = m * -x1 + y1

  # Enclose m in parentheses if it's a fraction.
  m_term = m.to_s
  if (m.class == Rational)
    m_term = "(" + m_term + ")"
  end

  # Consolidate any negative signs for c.
  if (c > 0)
    c_term = " + #{c}"
  elsif (c < 0)
    c_term = " - #{-c}"
  else
    c_term = ""
  end

  "y = " + m_term + "x" + c_term
end

def point_slope_to_standard(equation)
  m, x1, y1 = parse_point_slope(equation)
  a = -m
  b = 1

  # Move constants to the right side of the equation.
  c = m * -x1 + y1

  # Multiply by the least common multiple to eliminate fractions.
  # Multiply by -1 if necessary to ensure that a > 0.
  lcm = a.denominator.lcm(c.denominator)
  sign = a < 0 ? -1 : 1
  a = sign * (lcm * a).numerator
  b = sign * (lcm * b).numerator
  c = sign * (lcm * c).numerator

  if (b < 0)
    y_term = b == -1 ? "- y" : "- #{-b}y"
  else
    y_term = b == 1 ? "+ y" : "+ #{b}y"
  end

  "#{a}x #{y_term} = #{c}"
end

def parse_slope_intercept(equation)
  # Search the equation for an integer or fraction that looks like m.
  m_string_fraction = equation.scan(/\(-?\d+\/\d+\)x/)
  m_string_integer = equation.scan(/-?\d+x/)

  # If there's a fraction, use it. Otherwise, use the integer. Either way,
  # extract the value and discard the x.
  m = m_string_fraction != [] ?
    parse_value(m_string_fraction[0][0..-2]) :
    parse_value(m_string_integer[0][0..-2])

  # Search the equation for an integer or fraction that looks like b.
  b_string_fraction = equation.scan(/[-+]\s\d+\/\d+\z/)
  b_string_integer = equation.scan(/[-+]\s\d+\z/)
  b = b_string_fraction != [] ?
    parse_value(b_string_fraction[0]) :
    parse_value(b_string_integer[0])

  [m, b]
end

def slope_intercept_to_point_slope(equation)
  m, b = parse_slope_intercept(equation)

  x1 = m.denominator
  y1 = m * x1 + b
  y1 = y1.numerator if y1.denominator == 1

  y_term = y1 < 0 ? "y + #{-y1}" : "y - #{y1}"
  m_term = m.denominator != 1 ? "(#{m})" : "#{m}"
  x_term = x1 < 0 ? "x + #{-x1}" : "x - #{x1}"

  "#{y_term} = #{m_term}(#{x_term})"
end

def slope_intercept_to_standard(equation)
  point_slope_to_standard(slope_intercept_to_point_slope(equation))
end

def parse_standard(equation)
  # Parsing Standard form is simple because a, b, and c are guaranteed to be
  # integers and a is guaranteed to be positive.

  # Extract the value and discard the x.
  a = parse_value(equation.scan(/[-]?\d+[x]/)[0][0..-2])

  # Extract the value and discard the y.
  b = parse_value(equation.scan(/[-+]\s\d+[y]/)[0][0..-2])

  # Extract the value and discard the equal sign.
  c = parse_value(equation.scan(/[=]\s[-]?\d+/)[0][2..-1])

  [a, b, c]
end

def standard_to_point_slope(equation)
  slope_intercept_to_point_slope(standard_to_slope_intercept(equation))
end

def standard_to_slope_intercept(equation)
  a, b, c = parse_standard(equation)

  # Subtract x from both signs.
  # Divide both sides by y's coefficient.
  m = Rational(-a, b)
  b = Rational(c, b)

  m = m.to_i if m.denominator == 1
  b = b.to_i if b.denominator == 1

  if (b < 0)
    b_sign = '-'
    b *= -1
  else
    b_sign = '+'
  end

  "y = (#{m})x #{b_sign} #{b}"
end

def run_conversion(equation)
  type = identify(equation)

  case type

    when POINT_SLOPE_FORM
      point_slope = equation
      slope_intercept = point_slope_to_slope_intercept(equation)
      standard = point_slope_to_standard(equation)

    when SLOPE_INTERCEPT_FORM
      point_slope = slope_intercept_to_point_slope(equation)
      slope_intercept = equation
      standard = slope_intercept_to_standard(equation)

    when STANDARD_FORM
      point_slope = standard_to_point_slope(equation)
      slope_intercept = standard_to_slope_intercept(equation)
      standard = equation

  end

  {
    POINT_SLOPE_FORM => point_slope,
    SLOPE_INTERCEPT_FORM => slope_intercept,
    STANDARD_FORM => standard
  }
end
