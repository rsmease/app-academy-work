#What is CSS?
  #A style sheet language for markup (XML, HTML, XHTML)
  #Empowers DRY behavior because you can separate styling from content
  #Cascading because multiple files can support one phase
  #There are three ways that a developer can style a webpage:
    #1. inline style attributes in the HTML document
      #pros: ensure the style is applied to the right element
      #cons: not DRY practice; cluttered, unreadable HTML; impossible to style pseudo-elements (visited, hover, active)
    #2. embedded style selectors in the style tag of the HTML
      #pros: cleaner HTML; apply styles to a specific document, not globally
      #cons: loaded with the HTML and not cached by the browser
    #3. externally-linked stylesheet
      #pros: can be cached by the browser for improved performance; global access across the site
      #cons: global application means dealing with side effect styling where it might not be expected

#CSS Pre-processor languages
  #CSS pre-processors are langauges that represent abstracted CSS, allowing you to build CSS styles without the traditional markup
    #That is, they are abstrations of CSS à la Rails for web applications
  #CSS pre-processes allow for variables, nesting, functions, mixins, operators and more!
    #They make CSS more etensible and DRYer
  #SCSS and Sass are the two most popular CSS pre-processors
    #You might also hear of Less and Stylus
  #SCSS (Sassy CSS) is sa superset of CSS3, so its bakwards compatible with browsers that accept the CSS3 standard (all of them)
  #A developer can add SCSS to a CSS file by just changing the file extension
  #Sass is just the older version of SCSS
    #With Sass, indentation is used in lieu of SCSS's newer adoption of the traditional brackets that CSS3 developers are used to
    #Many people prefer Sass because it looks more concise
  #Surprise! Both Sass and SCSS are written in Ruby

  #CSS3
  nav ul {
    margin: 0;
    padding: 0;
    list-style: none;
  }

  nav li { display: inline-block;

  #Sass
  $spacing: 0

  nav
    ul
      margin: $spacing
      padding: $spacing
      list-style: none
    li
      display: inline-block

  #SCSS

  $spacing: 0

  nav {
    ul {
      margin: $spacing;
      padding: $spacing;
      list-style: none;
    }
    li { display: inline-block; }
  }

  #Less is a simplified version of Sass with a shallower learning curve
    #Less is JavaScript-based and its run by NodeJS
    #It's syntax is similar to SCSS, with brackets
  #Stylus uses line indentation like Sass
    #Of the pre-processors, it behaves the most like a programming language
    #Style is perceived as less beginner-friendly
    #Stylus is also JS-based and runs on NodeJS

#CSS Frameworks
  #CSS framework is a bunch of pre-structured and satandarized code that supports CSS development (e.g. a grid system)
  #Bootstrap is the most farmous, developed by Twitter to standardize their UI components
    #Bootstrap used to be written in Less, but is now written in Sass
  #Foundation is another popular framework that offers more flexibility than Bootstrap

#Common CSS Lingo
  #UI: user interface, or how a user interacts with a device or technology
    #CSS helps to guide a user to specific behaviors that the developer has in mind
  #Responsive a website design is responsive it adjusts to (looks decent across) different device screen sizes
    #Breakpoints are set in a web page's styles; they're markers where proportional changes will result in a different set of styles (you can observe this manually on websites by modifying the size of your window)
    #Media queries: used for device-specific breakpoints; they include an optional media type and expressions that limit the scope of their contained styles
  #Pixel perfect: replicating a mockup perfectly (down to the pixel level)
    #Flat design: a minimalist UI design language charaterized by simple elements, subtle typography and flat colors; considered very modern
    #Skeuomorphism: a design language characterized by elements that look like their counterparts in the real world
    #Grid system: a CSS framework that organizes elements into column systems, usually very helpful for building responsive designs
  #Material design: Google's visual language inspired by paper and ink with realistic lighting
  #Material UI: React Components implementation of Google's design language, Material Design
  #W3C: group responsible for HTML and CSS standards

#CSS Responsive Design
  #Required these days because of the large number of different screen sizes available to web users
  #Media query is a wrapper for CSS code that tests if the device running it meets one or more criteria
    #Genrally, we're just talking about width, but media queries can also think about device orientation and pixel density
  #Some basic media query tools:
    #media type, the type of media display, generally a screen but consider something like 'print' which offers specific styles for a printed page
    #min-width, application of styles to devices where the screen is greater than or equal to the given width
  #Responsive designers consider generalized breakpoints instead of the screen widths of specific devices
    #When a screen is pushed into or out of a breakpoint, it will transform its styling dynamically
  #Mobile-first design reverses the historical disposition where developers would focus on a desktop experience and then remove styles / adjust styles to accommodate mobile views
    #Mobile-first design flips this on its head, thinking of the mobile design as the primary view and adding styles to the desktop experience
    #Mobile-first design is great for exactly this shift: it leads to the progressive addition of styles for a larger screen, rather than the awkward reduction of styles for a smaller screen
  #It's important to add teh viewport meta tag to your head if you want a website to be responsive 
