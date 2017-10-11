#BIG0 Notation
#Big-O uses math to determine the 'quality' of an algorithm base on its runtime
#Factors that impact algorithm runtime:
  #Number of steps involved in the completion of the algorithm
  #Input size
#Model of computation allows us to abstract away the minor differences that are present in hardware or operator specific measurements
  #e.g. we abstract away the time that it takes a computer to perform a /, which is significantly slower than +
#The number of steps in a loop is just the number of steps in each loop, regardless of the specific calls within that loop
#Asymptotic analysis concerns itself with the ultimate performance of the algorithm as the input approaches infinity
  #We do not consider the constants, because these will not impact the function as input approaches infinity
  #Asymptotic analysis considers the 'dominant' term (the input term that has the largest impact on run time—e.g. 3N in '3N + 1')
    #We describe the dominant term's behavior as 'crushing'
    #Asymptotic analysis will determine the slope of each performance
    #With something like '2**X + X*X', the '2**X' is the dominant term because it has a much larger impact on the behavior of the line
#When we talk about Big O, we talk about the worst case runtime of the algorithm
  #Big-O is the asymptotic worst-case runtime
#Most commong Big-0s from fastest to slowest
  #O(1)-constant, runtime is equivalent to a single call
  #O(logn)-logarithmic, runtime slows to N as input approaches infinity
    #We know we're dealing with a logarithmic when the input gets divided constantly (e.g. binary search)
  #O(n)-linear, iterating over a list
  #O(n*logn)-loglinear/superlinear-merge sort, quick sort, etc (some n combinaed with some logn)
  #O(n*n)-quadradtic-e.g. nested loops like in bubble sort
  #O(n*k)-polynomial-where k is greater than 2
    #Nested arrays that are multinested or looped multiple times
  #O(k**n)-exponential, like subsets
  #O(n!)-factorial, like factorial
#O(g) is the set of functions that do not dominate g
  #Everything in the set would include all of the constants and functions that cannot dominate g
  #If an algorithm is O(n**2) it's also O(n!) because O(n!) is very slow
  #Something O(2n**2) is also O(n**2) (we wouldn't say this because we don't want to look at constants--we only want the asymptotic version)
    #This rule is about simplicity of the O(n) description
    #When an algorithm has two parts, one part O(n**2) and one part O(n**3), we say that the algoritm of O(n**3) because (1) this part will dominate its asymptotic behavior and (2) because we want to describe the worst case, not the nuance, of the algorithm
#Space and time complexity concerns the resources of the machine that are used by the algorithm
  #Consider searching two arrays for one unique element in the n+1 longer array—it's O(n) (not O(2n))
  #The hashmap that we use to check frequencies will also take up space complexity O(n)
  #We can improve the space complexity here with Xor
    #If you Xor the same number twice, it will cancel itself out
    #Xor returns 0 or 1 on a bit-by-bit basis when analyzing two binary representations
    #^ is the symbol for exclusive order
    #If you Xor 2 and 3 and then Xor the result to 2, you'll get 3
    #We can use Xor by Xor'ing all of the elements of each array and then return the result, which will be the unique element
      #The space is less because they are able to simply reassign the two bits rather than assigning and comparing the two arrays using a function call(?)

#Advanced CSS Selectors
#We can target elements with specific attributes using []
  #input[type="radio"] will only grab radio inputs
#the -webkit-appearance property is native to Webkit rendering engines used in Safari and Chrome
  #similarly, there's -moz- for Firefox and -ms- for Internet Explorer
#you can set a property to 'none' to remote it's browser default
  #often, resets are done in a separte css-reset.css file
#state selectors are chosen using a colon
  #input[type="radio"]:checked will only check the radio inputs if they're checked
  #another common state selector is :hover, for when the mouse is seen hovering over an item
#structural selectors will grab at the structure of the HTML document
  #the :first-child etc. are selectors of this kind
#combinators are characters (space, >, ~) that add to the complexity of selectors
  #the > combinator will pick the next children; the ~ will select all subsequence siblings
