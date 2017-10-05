#
# To make_better_change, we only take one coin at a time and never rule out denominations that we've already used. This allows each coin to be available each time we get a new remainder. By iterating over the denominations and continuing to search for the best change, we assure that we test for 'non-greedy' uses of each denomination.
#
# Discuss the following game plan and then work together to implement your new method:
#
# Iterate over each coin.
# Grab only one of that one coin and recursively call make_better_change on the remainder using coins less than or equal to the current coin.
# Add the the single coin to the change returned by the recursive call. This will be a possible solution, but maybe not the best one.
# Keep track of the best solution and return it at the end.

# N.B. Don't generate every possible permutation of coins and then compare them. Remember that a permutation is not the same thing as a combination - we will need to check every combination of coins that add up to our target, we just don't want to check the same combination in different orders.

# If you get stuck you can start by writing a solution that calculates and compares all of the permutations without storing them in an array. Then go back and refactor your solution so that it only calculates and compares all of the different combinations.
# #
# Make sure you and your partner understand each line before moving on.

def make_better_change(remainder, currency = [25, 10, 5, 1])
  #base case
  return remainder if currency.include?(remainder)

  #inductive step
  combinations = []
  currency.each do |coin|
    if coin <= remainder
      current + make_better_change(remainder - coin, currency)
    end
  end
  combinations
end
