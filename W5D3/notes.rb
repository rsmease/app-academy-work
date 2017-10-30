#HTTP
  #Hypertext transfer protocol
    #Hypertext is a string of text that and bring you to other content (text)
    #Transfer: HTTP is all about sending Hypertext between machines
    #Protocol: agreed upon set of rules
  #HTTP presumes a reliable connection; it only governs the content of the transferred hypertext
  #About HTTP requests
    #First part: HTTP method
    #Second part: path where the resource lives
    #Third part: HTTP version
    #Body: all of the headers (stored as a hash object) that provide you more information about how to process the request... language, proxy server, etc.
      #Host header: required header telling you where the server should return the request
      #Accept.Language: en (accept only English replies)
    #HTTP responses start with the HTTP version and then tell us about the status code of the request, along with a human-readable string about the response status
      #We also get a bunch of headers as a hash, just like in the request
      #Content-length: 32
      #Content-Type: text/html
      #(Body with all of the html)
    #Browsers know how to receive the HTML and render it as a webpage
    #Netcat is a tool for reviewing HTTP request/response cycles (nc)

#Rails Inside and Out
  #Rails is a web application framework
    #Framework is a piece of software that applies rules and boilerplate to automate the development of that software
  #Rails ships with a web server (Puma in Rails 5)
  #An HTTP request will flow through this web server and pick up additional data and functionality from Rails
  #Rails includes a router that receives HTTP requests
    #The router will check your routes.rb file to find a match
  #If a route is found, Rails isntantiates a new controller instances for the appropriate controller so that it can call the requested HTTP method
  #ActionController::Base is the superclass of all controllers and it provides a lot of the low level logic for our classes
  #ActiveRecord::Base is the superclass of all models
  #Rails instantiates a User model, which passes a request to the database, as appropriate
  #The controller will then take this data and push it into an applicable view and return it to the users web browser
  #What we need for Rails Lite: Router, ActionController::Base, ActiveRecord::Base
    #We need the Router to be able to load the routes file and create the list of routes
    #Router should be able to create a new controller and send it params
    #ActionController needs to call and create models
    #ActionController needs to return view output so that it can be sent as part of the HTTP response

#Rack
  #Rack is the middleware that sits between web servers and web applications
  #Why do we need middleware?
    #The webserver is responsible for receiving an HTTP request
    #There are many kinds of webservers and many kinds of frameworks with their own routers
  #The middleware is responsible for parsing these differences and ensuring that a variety of available tools can all speak with one another
  #We can start using rack to demo it
    gem install rack
    require 'rack'

#TCP/IP
  #Transmission Control Protocol(TCP) and Internet Protocol(IP) are used in conjunction so often that they're generally concerned the same protocol (TCP/IP)
  #Key research outcomes of research into the best possible large-scale information network:
    #decentralize the network with multiple paths between any two points
    #divide messages into message blocks (packets)
    #deliver those messages using the 'store and forward' method (intermediate recipient receives a messages, stores and verifies it, and then forwards on to end recipient)
    #these search results were original described in 1974 by Vint Cerf and Bob Kahn
  #IP is a set of rules about hwo to send information from one computer to another
    #finding the next-hope host and sending the packet to that hose
    #capturing incoming packets and passing payloads to the transport layer
    #providing error detection and diagnostics
  #IP protocol does not guarantee the quality of packet delivery
    #IP is an 'unreliable' server which engages in 'best effor delivery'
  #An IP address is an identified assigned to a computer that is connected to a TCP/IP network  #There are two major versions in the history of IP address, IPv4, with 32-bit addresses and IPv6, with 128-bit addresses
  #Packet refers to a formatted unit of data that contains, along with its payload, control information about how to delivery the payload
    #Typically the source and destination addresses, stored in the header of the packet
    #Packets are examples of datagrams (data + telegram), whose defining characteristic is having enough information to make it from its source to its target without two computers having prior awareness of one another
  #TCP is a higher-level protocol running on top of IP
    #It provides applications with information delivered by IP
    #It ensures that the information is reliable, ordered and error-checked
    #E.g. it permits a sender to resend information if it does not receive a response within a specific period of time
    #TCP is also responsible for breaking large pieces of information into pckets (to be sent via IP) and reassembling groups of individual packets into information that can be used by applications
  #Handshaking is the action described by the protocols of TCP
    #Handshaking involves three format steps:
      #a 'synchronize' message sent from A to B
      #a 'synchronize-acknowledgment' messages sent from B to A
      #an 'acknowledgement' message sent back from A to B
    #Once a handshake has taken place, packets are exchanged
  #Ports
    #TCP uses port numbers to identified application end points on a computer
      #This is related to the physical location of the memory where your information will be stored
  #Applicaiton layer
    #This term refers to the abstraction of a set of protocols and interfaces used by computers in a communications network
    #Generally, it describes applicatiosn that interact with TCP
      #Telnet, FTP, SMTP, DNS, HTTP, SSH
    #This term is most helpful in differntiating the responsbilities of an application (e.g. a browser implementing HTTP), the underlying transport layer(TCP) and the internet layer(IP)
  #The phenomenon of the Internet can be summarize as an interaction of machines at three layers: application layer (local software implementation), transfer layer (transfer protocols for secure movement of inter-network actions) and internet layer (protocols for inter-network interactions)

  require 'rack'

  hey_app = Proc.new do |env|
    req = Rack::Request.new(env)
    res = Rack::Response.new

    file = File.open('index.html', 'r')
    lines = file.read

    res.write(lines)

    res['Content-Type'] = 'text/html'

    res.finish
  end

  Rack::Server.start({
      app: hey_app,
      Port: 3000
    })

#Rack Middleware
  #Rack also offers additional functionality, because we can store code in the middleware itself
  #E.g. if we're serving static assets, we want this common functionality to live inside of this middleware rather than living in the app
  #User authentication, another common middleware, can be stacked with Rack so that is immediately available to incoming requests
  #We call a collection of middleware programs a stack
    #Rack::Builder allows us to build a stack of Middleware programs, run in LIFO order 

  class LoggerMiddleware

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def call(new)
      write_log(env)
      app.call(env)
    end

    private

    def write_log(env)
      log_file = File.open('application.log', 'a')
      log_text = <<-LOG
      TIME: #{Time.new}
      IP: #{env['REMOTE_ADDR']}
      PATH: #{env['REQUEST_PATH']}
      _________________________________\n
      LOG

      log_file.write(log_text)
      log_file.close
    end
  end

  class BrowserFilter
    def initialize(app)
      @app = app
    end

    def call(env)
      res = Rack::Response.new

      if env["HTTP_USER_AGENT"].cinlude?("MSIE")
        res.status = 302
        res['Location'] = 'https://www.google.com/chrome'
        res.finish
      else
        app.call(env)
      end
    end

  end

  app = Rack::Builder.new do
    #lowest middleware is run first (here, BrowserFilter)
    use LoggerMiddleware
    use BrowserFilter
    run hey_app
  end

  Rack::Server.start({
    app: app,
    Port: 3000
    })

#TCP Video
  #TCP provides a guarantee that IP transfers send data without corrupting it
  #TCP devices exchange packets that are something like components of a linked list, where each packet contains information about how to order it among the other packets, the total packet load, etc.
    #The sever will send the packets to the client and wait for a response for each packet, resending the packets when a response is not received within a certain period of time
    #The divison of packets are known as segments; the responses are known as read receipts
  #On the internet, things like traffic and load balancing can lead to unsent packets, which is why this handshake approach is necessary

#DNS
  #Domain Name System - the naming conventions that allow you to connect to specific servers
  #DNS is about translating a humand-readable address to an IP address
  #If you make a request for a previously visited DNS, your OS will delivery the address from its memory
  #If you make a request to a new DNS, the OS will make a series of requests to various servers so that it can find the correct address, first seeking the root name servers (the .coms and .govs of the world, not the google.coms and healthcare.govs)
    #Servers that can establish pathways to new servers are called DNS resolvers
      #Servers that hold .coms are rootname servers
      #Servers that hold a list of googles and yahoos are called TLD name servers
      #Specific domain servers are just called domain servers
  #To speed up this process, resolutions can be cached by the higher order servers so that you can send a resolution without searching out the more specific servers
  #Larger domains (e.g. google.com) will even as higher order servers to cache specific, local servers to manage their traffic more effectively
    #This is called load balancing

#Creating a Web Server
  #A server is something that's always running, always ready for receipt of new requests
    #Clients, in contract, are starting up and shutting down all the time
  #LocalHost is a special host name meaning 'my own computer'

require 'socket'
#allows for multithreading of requests and receipt simultaneously
require 'thread'
require 'json'

#TCP to transfer data back and forth between client and server
#Bespoke protocol. We need to reply this bespoke protocol with HTTP (HyperText Transfer Protocol)
#HTML is the HyperText Markup Language

#We would sent Port 80 to www.google.com
#GET / HTTP/1.1/
#Host: www.google.com

##{METHOD} #{PATH} #{PROTOCOL_VERSION}
#{HEADER_NAME: HEADER_VALUE}

$id = 0
$cats = []

server = TCPServer.new(3000)
Thread.abort_on_exception = true

#CRUD (create, read, update, request)
#HTTP verbs are 'what to do', #HTTP path is what to do the verb to
def handle_request(socket)
  Thread.new do
    cmd = socket.gets.chomp

    case cmd
    when "INDEX"
      #GET /cats
      socket.puts $cats.to_jason
    when "SHOW"
      #GET /cats/:id
      cat_id = socket.gets.chomp.to_i
      cat = $cats.find { |cat| cat[:id] == cat_id }
      socket.push cat.to_json
    when "CREATE"
      #POST /cats (same path, different HTTP verb)
      name = socket.gets.chomp
      cat_id = $id
      $id += 1
      $cats.push({id: cat_id, name: name})
    when "UPDATE"
      #PATCH /cats/:id (same path, different HTTP verb)

      cat_id = socket.gets.chomp.to_i
      cat = $cats.find { |cat| cat[:id] == cat_id }

      new_name = socket.gets.chomp
      cat[:name] = new_name
    when "DESTROY"
      #DELETE /cats/:id
      cat_id = socket.gets.chomp.to_i
      $cats.reject! { |cat| cat[id] == cat_id }
    end


    socket.puts("Thanks for Connecting")
    socket.puts("What is your name, human?")

    name = socket.gets.chomp

    socket.puts("Closing the Connection")
    socket.push("Goodbye #{name}")
    scoket.close
  end
  puts "Spawned worker thread"
end

loop do
  socket = server.accept
  handle_request(socket)
end

#We could query this server: GET / HTTP/1.1 Host: www.google.com and get all of the source code on the Google webpage
  #This is example what your browser does when your type something in the address bar
#The multithreading above allows us to create multiple sockets that are all waiting for a response at the same time
#One weakness with Ruby threads, for development, is that they won't crash a program is one of the threads fails
  #This is designed for the benefit of the end users in a live, multithreaded program
#Something like 'cats' is referred to as a resourece if it can be indexed as a model with all defined units

  $id = 0
  $cats = [{id: 1, name: "Markov"}, {id: 2, name: "Curie"}]

  server = TCPServer.new(3000)
  Thread.abort_on_exception = true

  #CRUD (create, read, update, request)
  #HTTP verbs are 'what to do', #HTTP path is what to do the verb to
  def handle_request(socket)
    Thread.new do
      line1 = socket.gets.chomp

      re =/^([^ ]+)+ ([^ ]+) + HTTP\/1.1$/
      match_data = re.match(line1)
      verb = match_data[1]
      path = match_data[2]

      cat_regex = /\/cats\/(\d+)/
      if [verb, path] == ["GET", "/cats"]
        socket.gets
        socket.puts $cats.to_jason
      elsif verb == "GET" && cat_regex =~ path
        match_data2 = cat_regex.match(path)
        socket.gets
        cat_id = match_data2[1].to_i
        cat = $cats.find { |cat| cat[:id] == cat_id }
        socket.push cat.to_json
      elsif verb == "DELETE" && cat_regex =~ path
        match_data2 = cat_regex.match(path)
        socket.gets
        cat_id = match_data2[1].to_i
        $cats.reject! { |cat| cat[id] == cat_id }
        socket.puts true.to_json
      elsif [verb, path] == ["POST", "/cats"]
        header1 = socket.gets.chomp
        match_data2 = /Content-Length: (\d+)/.match(header1)
        #when we give the server a real header and body, we make a point to separate the header from the body by a blank link
        socket.gets
        content_length = match_data2[1].to_i

        body_data = socket.gets.chomp
        cat = JSON.parse(body_data)
        cat[:id] = ($id += 1)
        $cats.push(cat)
      elsif verb = "PATCH " && cat_regex =~ path
        match_data2 = cat_regex.match(path)
        cat_id = match_data2[1].to_i
        match_data2 = /Content-Length: (\d+)/.match(header1)
        socket.gets
        content_length = match_data2[1].to_i

        body_data = socket.gets.chomp
        parsed_body_data = JSON.parse(body_data)
        cat = $cats.find { |cat| cat[:id] = cat_id }
        parsed_body_data.each do |(key, value)|
          cat[key.to_sym] = value
        end
      end


      socket.puts("Thanks for Connecting")
      socket.puts("What is your name, human?")

      name = socket.gets.chomp

      socket.puts("Closing the Connection")
      socket.push("Goodbye #{name}")
      scoket.close
    end
    puts "Spawned worker thread"
  end

  loop do
    socket = server.accept
    handle_request(socket)
  end

#HTTP Reading
  #Three steps to an HTTP request/response cycle
    #Establish a connection between client and host
    #Client creates a request and sends it to host
    #Host creates a response and sends it to client
  #After the TCP handshake protocol, the client server delivers an HTTP request to the Host server
  #HTTP request has 4/5 components:
    #HTTP method (verb)
    #Request target (path)
    #HTTP protocol version (HTTP/1.1)
    #Request header (e.g. host name)
    #Request body (only with POST/PATCH/DELETE actions)
  #The header is a set of key-value pairs that specify various properties of the HTTP request
    #accept (acceptable content types for the response)
    #content-type (format of request body)
    #cookie (cookie previously sent by the server, now being returned to the client)
    #host (domain name of the host server; optionally, the port number on which the server is listening)
    #user-age (information about the requester's web browser and operating system)
  #HTTP response has 4/5 components:
    #HTTP protocol version (HTTP/1.1)
    #Status code (200)
    #Textual description of status code ("OK")
    #Response header (see above)
    #Response body (typically, an entire HTML page)
  #The header might contain:
    #Content-type (format of response body)
    #date (date of response generation)
    #last-modified (date time when the resource was last modified)
    #location (e.g. in a 302 response)
    #set-cookie (set a cookie associated with the current website to a specific value)
  #Response request types:
    #200: OK
    #302: Moved
    #404: Not Found
    #500: Inerntal Server Error
  #A MIME type is equivalent to a filename extension
    #Multipurporse internet mail extension
    #It's specified in the content-type response header and tells the client how to parse the response body
    #Some common MIME types:
      #application/json
      #application/pdf
      #application/zip
      #image/jpg
      #image/png
      #image/gif
      #text/html
      #text/plain
