#CSS Box Model
#The box model allows us to assign a width and height to different elements
#CSS's default behavior is to wrap content within a box
  #We can manipulate the width and height of a box
#Elements are surrounded by a number of named styling layers: border, padding, margin, etc.
  #Padding is like a thick winter coat on the insider of an object's box
  #It's more about insulation than about isolation
    #Just think about the inner fleece of my blanket at home
  #The pixel assigments are always arrange TRBL (clockwise starting at top)
    #With just two, we then have TB and RL
    #With just one, we assign the same style to everything
  #Border will take a style (solid, dashed) as well as a color and thickness
  #Margin is about isolating elements from one another
    # Just think of someone named marge that you don't want to be near
    #Padding and border will affect the width/height of the box; margin will _not_ affect these
#Google developer tools will show us the box model of elements that we hover
#We can also add box model styling to in-line elements, but things get more difficulty here
  #With padding, for instance, we can easily pad left and right, but not top and bottom

#Understanding Hashmaps


#Deep-dive into various data structures that rely on the Hashmaps
#Set is an unordered list of unique elements
  #Cant' call .first, etc.
  #You can call .include?, .insert and .delete
  #Set is an ADT; the Hash is an example of the set as a data strcture
#If we did a linear array with an unless.arr.include?, we would have a time complexity of O(n) (for check, add and delete)

#Creating a Set
#To create a set, we look for the arr.min and arr.max, default the present of all values in the min-max range to false, and then search for the presence of each variable via its boolean key
  #Although it would be O(n) to create the Set from an array, it would only be O(1) to pull an element from an array
    #Arrays are contiguously stored data in a machine
    #Arrays will know the specific "RAM address" of each element, which has a unique byte address, so to process the seach, just return index*8 + the first pointer
    #Pointer arithmetic: if I know the start and step value of the memory storage, then I can access pieces of the memory storage unit using the start and step
  #Checking an array will also be O(1) because it's just using pointer arithmetic to access the memory address
  #This implementation will not work if we have floats (hard to identify as unique) or if we have arbitrarily large numbers (the arr.max - arr.min range would take a long time to traverse)
#Let's see if we can implement a set that allows us to control the amount of space that it takes up
  #I will make the set a fixed size and work around that constraint
  #We will need to store more than one element in each of the limited supplier of available space
    #We want to store the elements together in some way that allows us to query them from the correct bucket without fail
  #The tool that makes this 'bunkmakes' situation possible is the module
    #The range for any number, % n, will be (0...n)
    #If we choose 3 as our n, then we have four bucks (0..3) and then we just store all of the available data items into one of these modulo buckets
    #We then, when queries about the existence of a number in thet set, modulo the query and look in the corresponding modulo bucket
  #For include, the O(n) will decrease depending on how many in N
    #Because O(N/K) just reduces to N (K is the upper range of our modulo bucket set, so 4 in the example), since N will be dominant, the bucket size will still be O(n)
    #This impelementation will not improve the runtime
    #To improve this, we need K (4 in 0...4) to also expand with N, so we can then get O(1)
  #We build a set that expands K by adding a new bucket and increasing the mod value each time (%5 for the first round)
    #K might even be greater if we delete elements
    #We can therefore check inclusion in constant time because N and K will be the same (N/N == 1)
    #Because the dilutional average of all of the modulo result is just 1, the average content of each bucket will be 1
    #Insertion is still slow in this scheme!
      #We still have to slowly push each element into the array by inserting it into the right bucket (it's O(n))
    #If I create more x buckets up front, I still have O(n)
      #This averages out to be O(n) over time
  #If I create N new buckets up front, then instead of the average of N / x (linear), I have N / N (1)
    #Strictly speaking, you have 2*n + n / n, which means you have 3n, but we do not think about constants when we are looking at asymptotes
    #The amortized cost of the operation is a constant because the price of each add as we scale (when we double N and have to add more buckets) is paid for by the N number of 0 cost adds that lead to it
    #Amortized costs can fluctuate, operation by operation, but O(1) is the average over a long period of time
      #To compare this, think of flipping a coin... the rate at which you get a heads the first time is not the same as the average
      #With amortization, no luck is involved, just a fluctuating distribution of the time that it takes to process the data in comparison to the expected O(1) rate
    #Space in this situation is still O(n) becase we cannot escape that we have N objects
    #We can still run into issues with this if we have a 'pathological data set' where, for instance, all of the items end up in the same bucket because they all share the same modulo of N
      #This turns the operation back into O(n)

#Hashing
  #Hashing functions turn any random input into a determinstic but seemingly arbitrary large string encoding.
  #Hashing functions are uniform——any string is just as likely as any other string
    #The possible outputs are, approaching infinity, uniformly output, which means that there's nothing that we can predict about the output
    #Think about a coin; you cannot scientifically predict the precise output of a hashing function
    #Hashing function outputs should be so confusing that we cannot reverse engineer them just by looking at the hash string
  #Common hashing funtions: Cityhash, CRC32, Shah2, Murmurhash
  #Cryptographic hashing functions: MDS (now outdated), Shah1, Shah2, Blowfish
    #These tend to be slower but safer, so you wouldn't use them for a hashmap
  #All objects in Ruby have a hashing object that calls Murmurhash
    #Knowhing that a number can be hashed, you can then build hashes for strings, arrays and hashes

#Using hashes to solve our Set problem
  #Ruby's .hash function will output a number, not a string
  #We'll modulo the numerical hash results of input values rather than the numbers themselves (this also allows us to hash strings into numbers and store those in the array, too)
    #There's no pattern to the hash outputs, because that's a feature of hashing functions, so we are much less likely to reach the situation described above where everything is stored in one bucket
      #This approach guards against a pathological data set
    #We store the "actual value" in each bucket, but the bucket choice is determined based on the modulo of the number
      #We want this so that we don't have the runtime tax involved with reversing the hash
      #This means that things will still clump a little bit, but we cannot possibly see a clumping of all results into the same bucket, so we hae the average number of things in each bucket
    #This approach is *still* O(n), but in practice it is much more likely to approach O(1) as an average
  #Note that, in Ruby, there's a built-in set module
  #Also note that, in Ruby, Ruby will hash the object ID
    #This means that we need a unique hashing function for arrays that are commonly reused (Arrays, for instance)
    #If we didn't have an overriding function to combat this, we would have to deal with this issue for hashes
      #If you're going to overwrite ==, you should also consider overwriting .hash

#Linked Lists
  #A list of nodes that are linked together
  #A singly linked list is just a list where each item has a pointer to each subsequent item
    #E.g. we could give each object an @nest value; the head and the tail of the linked list would have a @nest == nil
  #You can then loop through the linked list node by node
  #Linked lists are generally not a useful data structure
    #Finding in a linked list is O(n); pushing/unshifting in a linked list is O(1)
    #Deleting a member of the linked list is very easy because you just change the pointer of the previous object
      #The deleted member then has no reference so no memory is stored to keep it
  #A doubly-linked list will also have an @prev, which points to the previous element in the linked list
    #To delete here, you have to reset the earlier node's @next and the next node's @prev
      #This is O(1)
  #Accessing an element in a linked list is O(n) becuase you have to move through the list
  #The programming pattern for linked lists can be simplified with the use of sentinel nodes
    #Even if you have nothing in the list, you always have a head an a tail
    #When you want to add something to the list, you just modify the value of the head and tail

#Linked Lists to Build a Hashmap
  #Add the tuple/add of the key and value to each link in the linked list
  #Reimagine the buckets of the hashmap as linked lists instead of arrays
  #I will use the keys to decide what I modulo by, because this will allow me to ensure that I a set (i.e. don't use the values)
  #As we add our key-values pairs to each of the linked lists in each of the buckets, we just relate them to the existing key-value pair nodes in eaach of the linked list buckets
  #Lookup will not increase in speed using this implementation (it's still effectively O(1) because of the average distribution of values in each of the buckets should be constant )
    #Inserting a new value will just add it to the final-1 node of the linked list (This is O(1))
  #Linked lists are not a requirement for Hashmaps (you can do it with an array as well)

#Caches
  #The caching problem is about decided what to store in local memory and what to unassign and then reconstruct
  #Reconstruction is much more expensive than just looking for something that's hidden away in a hash
  #The cache on a cellphone is relatively small
    #You can see this in e.g. Instagram feed
  #We need to decide what goes into the cache and what comes out
    #LRU (least recently used) is the most common caching method
    #presumption of the LRU is that we are most likely to need the most commonly accessed things (things we haven't used in a long time are the least recently used)
    #We measure the time that we least used something and then we push them out of the frame when we anticipate needing new items
      #This would be O(n)
  #We can use linked lists to make this O(1) instead of O(n)
    #Rejection from a linked list is O(1) because I just identify the head (oldest item) and remove it
    #Reading appears to still be O(n)
    #To take someone in the cache and move them to the front, I just take the prev pointer and point the prev to my next, and then point my next to my former prev; I am then unlinked and I can be reassigned
  #To review, hashes are O(n) to insert and remove, but O(1) to access
    #Conversely, linked lists are O(n) to access, but O(1) to insert and remove

#LRU Cache: Combining Hashmap and Linked Lists
  #If each of the indices in a has can point to the element inside of a linked list, then you get the benefits of both data structures
  #Reject someone, we have O(1) to remove the element from the linked list, and then we have a link that leads us to get O(1) when deleting the key from the Hash
  #Insertion is also O(1) time
  #Reading is just reading a hashmap, so reading is also O(1)
  #LRU caches are a very common implementation
  #The value of a linked list is that they have a stable identity with respect to their own position (stored as a value in a subhash of the hash that tracks the location of each object in the linked list)
