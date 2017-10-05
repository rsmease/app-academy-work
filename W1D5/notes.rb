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
