#DATA STRUCTURES
#CS Concepts that are agnostic to a specific language
#Arrays/Hashes etc. are data structs
#Abstract data types are a level above data structs (ADTs)
  #E.g. a Set is an ADT
  #Note that both an array and a hash map could be a set (it's more abstract)
#Another abstract data type is a map (dictionary)
  #Hash maps are the most common implementation of a map
  #You could, for example, also implementat a map using a 2D arr
  #Map requires me to have unique keys (set of keys)
#When considering ADTS, think about what features you need to implement
#ADTs can be required for specific algorithsm to work
  #In some cases, an ADT is just preferred for efficiency or performance
#Consider a stack, where you remote and add only to the top
  #The things at the top are the newest, and at the bottom the oldest
  #Last in, first out (LIFO)
  #Stack supports push and pop
  #A stack is almost always implemented with an arr
  #Stacks are also used in recursive algoithms
    #When you use an iterative solution, you still need the stack
#Consider a queue, where you pull and push on opposite sides
  #Removing from the front of the line is called dequeing
  #Adding to the end of the line is enqueing
  #First in, first out (FIFO)
  #queues can be implemented easily with an array
    #we call this enqueing and dequeing because you can push/shift or pop/unshift
#Consider a tree
  #Binary trees are the most common type of trees
    #Each node/vertex of the tree has at most two children
    #Each child has at most one parent
  #We can also have a ternary tree
    #Each node/vertex of the tree has at most three children
    #Each child as at most one parent
  #We can also have a unary tree (i.e. a linked list)
    #Each node has one child and each child one parent
  #Beyond three, we just call it an n-ary tree or polytree
  #We can talk about 'roots' of 'subtrees' where we look at smaller trees
    #The final nodes without children are called the leaves of the tree
  #The number of node layers to a tree are called its depth or height
  #Trees are really good at solving a surprising number of problems
  #Tree traversal is thinking about how to move through a tree
    #Depth-first and breadth-first are two well-known pattern
    #BFS will run layer by layer, reading from 'left to right'
      #Return parents, then children
    #DFS will run down each lineage, one at a time
      #Return children, then parents
#To explain trees, we are going to design a Tic Tac Toe AI
  #It's fairly obvious to imagine an AI moving over a tree looking for options

#How the Hash Works in Ruby
  #Hashes are a data structure organized by key-value pairs, where all keys are unique
  #Hashes are also known as dictionaries and associative arrays
  #Hashes use division of a numerical representation of each object (modulo operation) to store the access ID for each key more efficiently
    #If the keys were kept as their genuine input, we would occasionally have very long strings or numbers or other objects as keys, which would be harder to search and access
  #Although progressively less likely for larger hash sets, 'hash collision' is always a possibility, where multiple keys return the same number as a result of the modulo operation
    #Seeding a hash with random values produced by the hashing function also greatly decreases the possibility of a hash collision
    #Ruby stores hashes of less than six in the same bucket by default, only using the modulo hashing strategy for larger hash sizes
    #Hashes are ordered in Ruby, which has some space consequence, but no time consequences

#Dynamic Arrays
  #Dynamic arrays are arrays that will store n*2 (or some other constant n*k) available space, half of which is unoccupied
  #The unused space allows for insertion at O(1) time, rather than O(n) (because to add memory to an array, we have to reassign the array to a new physical space in memory)
    #The array must will use O(n) operations when the array is expanded due to the arrive of n*k new inputs, but the total cost is amortized to O(1)

#XOR
  #XOR (^) is the strict or exclusive version of OR (||) that will return false for true ^ true (which return true with ||)
  #Bit comparisons using ^ are useful for hashing numbers
    #It promotes high determinism, comprehensiveness and uniformity
    #It is also very predictable, so it needs the aid of other function features to make the spread of hashes less easy to guess
  #Other bit operators do not produce the same uniformity 
