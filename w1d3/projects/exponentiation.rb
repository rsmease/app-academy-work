# Exponentiation
#
# Write two versions of exponent that use two different recursions:
#
# # this is math, not Ruby methods.
#
# # recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)
#
# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
# Note that for recursion 2, you will need to square the results of exp(b, n / 2) and (exp(b, (n - 1) / 2). Remember that you don't need to do anything special to square a number, just calculate the value and multiply it by itself. So don't cheat and use exponentiation in your solution.
#
# Suggestion: Break the methods down into parts.
#
# Suggestion 2: Try walking through your code with Simple Examples.
#
# If the n == 256, about how many nested recursive steps will we run in the first case?
#
# How deep will we need to recurse for the second? Keep in mind that the first reduces the exponent by one for each recursion, while the second reduces it by half.
#
# In addition to testing your methods by running the code, try the following exercise:
#
# On paper, write out the value of each variable for every line in the code:
#

# Make sure you can trace from the very beginning to the very end in these examples.
#
# How many examples do you need to walk through to be confident that it works?

def recursion1(base, power)
  #base case
  return nil if power < 0
  return 1 if power == 0

  #inductive steps
  base * recursion1(base, power - 1)
end

def recursion2(base, power)
  #base case
  return nil if power < 0
  return 1 if power == 0
  return base if power == 1
  #inductive steps
  if power.even?
    next_recursion_even = recursion2(base, power / 2)
    next_recursion_even * next_recursion_even
  else
    next_recursion_odd = recursion2(base, (power - 1) / 2)
    base * next_recursion_odd * next_recursion_odd
  end
end
