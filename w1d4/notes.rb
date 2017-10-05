#GIT INTRODUCTION VIDEOS
#How do we use git and why?
#Git is a form of version control
#A commit is a point in the historical timeline of a projects development
#Git allows for multiple people to modify different parts of code and then merge their changes together
#Think about these boxes:
  #Working directory (all minute changes)
  #Staging area (git add)
#We commit staging areas, not working directories
  #Before committing, we want to review the changes made
  #git review --staged
#Git commit creates a formal version of the projects
#Git branch allows for the development of multiple versions that we can stage together before committing
#Git log will show the series of commits that have been made to specific files
  #Braching allows you to modify a branch instead of the master
  #We can make commits to each branch so that it has multiple stable versions
#We have to create a repo in Git before we can push our commits to it
#The common git push origin master will push our master to git
  #Alternatively, we could push it to a service that does more than just display the code, like Heroku, which is a cloud server
#Your head, your current working directory, can be appended to different points on the development of your git branch

#WHY GIT?
#VCSs allow us to keep track of changes made and revert to previous versions of a project
#Git stores data as a series of snapshots
#Git performs most operations locally, without the internet
#Git is distributed but centralized
  #We only pull from the internet when we want to make changes to an older version
  #We only push to the internet when we are ready to submit a new branch
#Files live in three stages: modified, staged and committed
  #You can control what is staged and committed
  #Multiple people can contribute and reconcile their various version disparities

#Typical Git command sequence
  #git init
  #git remote add origin (location)

  #git init creates an empty repot, and then remote add will look for a remote repo at the specified web address

  #git add add -A (all files in working director)
  #git commit -m "Comment" (commit with comment)
  #git push

  #git add will add files to the staging area, whereas git commit will commit them to the local repo; messages should be written as imperatives ("make this change")
  #git push will push the local repo to a remote repo
    #first time, git push -u origin master
    #then, git push origin master

#commit and push frequently!

#RUBY GEMS
#code packages to share with other developers
#Github is the best place to find gems
#gems with more than 1K users are mainstream, gems with more than 500 are fairly popular
#with rbenv installed, you don't need to use sudo commands to install new gems
#you can try out gems live in pry
#rbenv == ruby environemnt

#HISTORY OF VERSION control
#Concurrent Version Systems is a free open source option; it has been dead since 2008
#Apache Subversion is another free, open source operations
  #Better than CVS, it has atomic control operations and cheaper branch operations
  #It is slow compared to Git and it is server-based rather than peer-to-peer, so you rely on a specific device
#Mercurial is distributed like git and it's relatively inexpensive
  #Many choose it because it has better support for Windows users
  #Because it's implemented in Python, it's also easier to extend

#Version control, revision control and source control are all the same thing
#Atomic operations are operations whose changes are rolled back if they are somehow interrupted before completion, to prevent source corruption
#Semantic version a.b.c (major.minor.patch) updating lingo

#AGILE DEVELOPMENT
#Developed in the early 2000s, agile focuses on rapid development of software feature prototypes
#Break projects into smaller parts
#Each team must be cross-functional, meaning that it can manage all of the features of its piece independently
#Agile emphasizes colocation
#Pair programming can be used to improve product quality
#TDD leads to more agile code because the unit tests make it easier to understand the outcomes of bugs and test individual pieces
#Continuous integration is the process of repeatedly merging a new product to see how it interacts with the existing code base
  #Agile for new feature development

#ALTERNATIVES TO AGILE
#Waterfall: each phase of development is fully completed before the next one begins
#Prototyping: make multiple prototypes that will eventually be refined toward the final product
#Spiral: blends aspects of other methodologies based on risk analysis

#HTML Forms
#Forms allow users to interact with an application by inputting data
#Form#action takes a URI; Form#method takes an HTTP request ofeither GET or POST
#Input#type will be things like a button, checkbox, color, date, email, hidden number, password, radio, search, url
#Input#checked/name/placeholder/value are usually just text
#Label#for takes text corresponding to the id attribute of the element being labeled
#Select#name and Select#disabled are usually just text
#Option#.... usually just text
#Textarea... usually just text or numbers

#Input elements are by far the most common
#Labels can be written in two ways
#Submitting forms makes a default post request with parameters made up by the provided values for each name attribute

#SERIALIZATION AND PERSISTENCE

#Serialization is the process of converting objects into a format that can be passed to another device
#JSON is the most common serialization format
#Ruby has a .to_json that will convert to JSON for you
  #This will only work for simply hash input
#YAML is mean to solve the problem of saving more complicated classes
  #YAML saves the instance variables of an object and records the class of the object that's been saved
  #JSON is the the dominant serialization technology on the web
  #In the world of server-side Ruby, YAML is the leader because it's better at Ruby serialization

#USING GIT ADD
#Git add . will add files to a repo without merging the changes; you probably don't want to use it
#Instead, use git add -A
