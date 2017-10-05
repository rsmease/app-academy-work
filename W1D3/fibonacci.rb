# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.
#
# You shouldn't have to pass any arrays between methods; you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.

def fibonacci(num)
  #base case
  return nil if num < 1
  return [1] if num == 1
  return [1, 1] if num == 2

  #inductive steps
  fibo = fibonacci(num - 1)
  fibo + [fibo[-1] + fibo[-2]]
end
