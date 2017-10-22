#Secure State
  #I wouldn't want to just enumerate the pages where people's purchase lists or credit card pages are a available to review via a webpage
  #We could randomize the webpage that's visible to the user, making it much harder to check for people's personal content
  #Similarly, if we have any kind of naked information in the url (search id, etc.), we are at risk of exposing our data
    #A limitation of HTTP is that it's stateless
      #There's no way for HTTP to hold onto state without reminding the server in every new request (ever new click / new view that's loaded)
      #Cookies are our solution to the stateless reality of HTTP
#Cookies
  #Cookies are little pieces of data that are delivered by a website's server when they make requests for information
    #Cookies are saved on the client-side machine
    #Cookies are just a large hash
    #Each website domain's cookies are private to that domain; browsers do not allow interdomain snooping
    #Clients will reject a cookie if it's too large, and each domain can only hold 20 cookies
    #If you don't have cookies, you cannot have state
  #In the problem above, cookies can store the cart_id problem discussed above
    #The remaining risk is the guessability of the cart_id
  #How can I associate a username and password with a set of cookies?
    #Storing the password in plaintext is obviously a huge risk because someone can be 'sniffing' the packets as they are passed
    #We cannot pass the username and password in our HTTP request as raw text
    #We cannot just pass the username, because that's easy enough to spoof
  #We solve this with session tokens, which are random bits with a time limit
    #In a session token, we have a code that's generated each time and passed to and from the server-side application
    #A new session token is sent with each request from the client
    #This process of generating sessions is the basic authentication model
  #There are still issues remaining with this model of authentication
#Encoding and Encryption
  #We should always think about the most dangerous possilbe outcomes
  #E.g. we should guard against a SQL injection attack
    #Persons could inject 'SELECT * FROM users' and obtain your entire database
  #Password encryption is a guardrail against the ever-present possibility that some unknown vulnerability in our system would lead to a leak of data from the database
  #Encoding: a16z - if you understand the overall scheme of the encoding, you can decode the string
    #base64 encoding is another common encoding scheme
    #HTTP and all web addresses are encoded in ASCII
      #base64 is the a-zA-z-_ subset of ASCII
  #Encypting - Caesar cipher - you can't decode the string, even if you understand the encoding, unless you have a key
  #Where can we safety store the key to an encrypted data transfer?
    #A key is fundamentally just one layer away from the plaintext password
    #Anyone with the key could find a way to access the password

#Authentication Hashing
  #We need a hashing function!
    #Hashes are a one-way encoding function
  #Passwords are hashed (digested) by the hashing function
    #The only remaining risk is that possibility of a hashing collision
    #It's always possible to create a hash collision, but the larger the size of the hash (in terms of # of modulo buckets, which is always N of the hash length) the harder it would be to establish a hash collision
  #The hashing functions that we use to build hashes are not the same that we want to use for cryptography
    #cryptography hashes are designed to produce even more entropy, thereby drastically reducing the possibilty of a hash collision even further
    #Sha-1 and MDS are now deprecated; Sha-2, Scrypt and BCrypte/Blowfish are more modern libraries
  #As hashing funcitons get older, people learn their weaknesses, and experts force us to move forward to new encryption functions
    #We rely on cryptographers to know which hashing functions are currently stable, and which are no longer secure due to exposed weaknesses
  #There's something that still weak with this approach...

#Salting
  #Users are stupid; they tend to use the same password for all their websites
    #Users are only as safe as the weakest site where their password is stored
    #A basic way to fix this is two-step authentication
  #90% of users use the 1000s most common passwords (password, password123, football, starwars)
  #If 8% of my users use 'password', 8% of my hashes will be identical, and I can see this trend, then I can identify those users and steal their password
  #Hackers could take the 1,000 most common passwords and pass them through the hashes for all the most common hashes over the known hashing functions behind each site
    #This would not be too hard; it could even be easily be publish, and it has been! They're known as 'rainbow tables'
  #Salting is the solution to rainbow tables
    #Take a small, randomly generated string and attach it to the password
    #We now have a much more colorful, entropic database of password hashes
    #Everyone is just as protected as everyone else
  #Attacks are persistent; they go so far as to steal the computational power of other users to hack away at a password database
  #Companies need a strategy to make sure that cracking passwords is so expensive that I don't even try
    #They run a password through a hashing function 40 times, which leads to a price for brute-forcing 40 times harder

#BCrypt library
  #BCrypt::Password.create("mypassword")
    #Returns a massive hashed digest of your password
    #The first part of that digest will be a report about the number of times that the password was hashed
    #Next, you'll get the consistent salt
    #Next, you'll get the randomized hashing result of the password
    #$2a version number $10 number of hashses
    #pass.salt will return the salt
    #pass.checkum will return the hashing function of the password
    #we store the password as a simple string inside of the database
      #We then use BCrypt::Password.new(string_of_hashing_digest) and check whether the new hash of our password matches
    #BCrypt is slow to match hashes, which is why it's so valuable

#Session, Flash
  #Session is like params, it's a hash that's available to you in the controller
    #You can set keys in the session, which are the cookies available to your user; thise gets stored on the client machine
    #Session is established in a way that prevents the users from hacking their own cookies (they are hashed)
  #You want to minimize the amount of state that you store in the cookies and maximize what you want to store in your server
    #Cookies have to be passed between server and client each time
  #A permanent cookie is not permnanet; it lasts 20 years if you really want it to, but for much less time when handling sensitive data
  #Very not-permanent cookies (cookies renewed with each HTTP request) are managed by Flash
    #e.g. 'username can't be blank' at a login screen
    #flash will manage the error patterns becuase the cookie itself will only persist for one more request cycle
  #Flash.now is another useful feature to remember
    #Flash.now only exists for this request, so it's not properly even a cookie
    #Flash.now is not persisted to the next cycle

#Authentication Pattern (Auth Pattern)
  #Never ever design your own authentication pattern
  #In the User model, we'll store the password digest, validate that it has a minimum number of characters, and also allow_nil
    #Allow_nil allows us to pull the password out of the database
    self.password_digest = BCrypt::Password.new(password)
  #When you create a user for the first time, you store the password digest rather than storing the password
  #I also need session tokens
    #generate_session_token, ensure_session_token, reset_session_token
  #User model will also need a find_by class method for finding the user by its credentials
  #We now need a UserController, SessionController and ApplicationController
    #User: new (sign up), create (log in)
    #Session: new (sign up), create (log in), destroy (log out)
    #Application: current_user (caches the session token), login!(user) (set the session token), redirect_unless_logged_in(check if current_user)
    #In all controlled pages where security matters, check the redirect_unless_logged_in method

#CSRF Attack
  #To demonstrate the attack, I need to show you a mutable state
  #Cross-Site Request Forgery - making a request at a good site, but passing the value to a bad site
  #Attempt to hijack an existing session with a legitimate service
  #We can generate a random CSRF token and add it to the session as well as the user params
    #We can also do this lazily, so we don't have to generate a new token with every action
  #Next, write a validate_csrf token that compares the two session tokens, which will prevent us from being hijacked by a separate session
  #We only need a CSRF protection strategy for posting data
  #Another site cannot get the session's CSRF token from the 'good site'
    #Sandboxing is a web browser strategy that separates all cookies from the cookies of other domains
  #Rails calls this the 'authenticity_token' and it's a built-in
    #We then add 'protect_from_forgery with:exception' to our ApplicationController
    #We used to have a with: null_session
      #This just sets the current_user to nil
      #This was changed because it seemed that the action was still taking place
      #Developers attempting to implement their own CSRF protection were confused
    #This has to be added to all of your forms
