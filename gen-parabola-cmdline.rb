
require 'optparse'
require 'ostruct'

# Representation of the command-line for the parabola-generator program.
class GenParabolaCmdline
   # Construct a parser for the command line, and then run the parser.
   #
   # The key word 'self' here indicates that 'parse' is a method of the class
   # (and not of an instance).
   #
   # +args+:: List of command-line arguments to the program. ARGV is passed in
   #          here.
   def self.parse(args)
      options = self.getDefaultOptions
      parser = self.makeParser(options)
      parser.summary_width = 20
      parser.parse!(args)  # args (ARGV) will have options removed!
      if options.n < 1
         puts "GenParabolaCmdline::parse: ERROR: " +
              "Number of steps must be specified.\n\n"
         puts parser
         exit 1
      end
      if options.b == options.e
         puts "GenParabolaCmdline::parse: ERROR: " +
              "(beg, end) must be different, not " +
              "(#{options.b}, #{options.e})\n\n"
         puts parser
         exit 1
      end
      options
   end

   private

   # Construct options to be specified on the command line, and set a default
   # value for each.
   def self.getDefaultOptions
      options = OpenStruct.new
      options.w = 1.0  # Default width is 1.0.
      options.x = 0.0  # Default x position of vertex is 0.0.
      options.y = 0.0  # Default y position of vertex is 0.0.
      options.b = 0.0  # Default beginning x is 0.0.
      options.e = 0.0  # Default ending    x is 0.0.
      options.n = 0    # Default number of steps is 0, an illegal value.
      return options
   end

   def self.makeWidthParser(opts, options)
      wdsc = "From vertex, change in x for unit change in y."
      wdef = "By default, W=#{options.w}"
      opts.on("-w", "--width W", Float, wdsc, wdef) do |w|
         if w <= 0.0
            puts "GenParabolaCmdline::parse: ERROR: " +
                 "Width must be positive, not #{w}\n\n"
            puts opts
            exit 1
         end
         options.w = w
      end
   end

   def self.makeXvertParser(opts, options)
      xdsc = "X coordinate of vertex."
      xdef = "By default, X=#{options.x}"
      opts.on("-x", "--x-coord X", Float, xdsc, xdef) do |x|
         options.x = x
      end
   end

   def self.makeYvertParser(opts, options)
      ydsc = "Y coordinate of vertex."
      ydef = "By default, Y=#{options.y}"
      opts.on("-y", "--y-coord Y", Float, ydsc, ydef) do |y|
         options.y = y
      end
   end

   def self.makeXbegParser(opts, options)
      bdsc = "Beginning x coordinate."
      bdef = "By default, B=#{options.b}"
      opts.on("-b", "--x-beg B", Float, bdsc, bdef) do |b|
         options.b = b
      end
   end

   def self.makeXendParser(opts, options)
      edsc = "Ending x coordinate."
      edef = "By default, E=#{options.e}"
      opts.on("-e", "--x-end E", Float, edsc, edef) do |e|
         options.e = e
      end
   end

   def self.makeNumstepsParser(opts, options)
      ndsc = "Number of steps between B and E."
      opts.on("-n", "--num-steps N", Integer, ndsc) do |n|
         if n < 1
            puts "GenParabolaCmdline::parse: ERROR: " +
                 "number of steps must be positive, not #{n}\n\n"
            puts opts
            exit 1
         end
         options.n = n
      end
   end

   def self.makeHelpParser(opts, options)
      opts.on_tail("-h", "--help", "Show this message.") do
         puts opts
         exit 0
      end
   end

   # Construct a parser for the command line.
   #
   # +options+:: Options to be set by parser. Default values have already been
   #             loaded in options before makeParser is called.
   def self.makeParser(options)
      return OptionParser.new do |opts|
         opts.banner = "Usage:  #{$0} [-w W] [-x X] [-y Y] [-b B] [-e E] -n N"
         opts.separator <<EOF

Send to standard output the coordinates of points along a parabola.  Each line
of output contains one pair of coordinates separated by white space.

Options:

EOF
         self.makeWidthParser(opts, options)
         self.makeXvertParser(opts, options)
         self.makeYvertParser(opts, options)
         self.makeXbegParser(opts, options)
         self.makeXendParser(opts, options)
         self.makeNumstepsParser(opts, options)
         self.makeHelpParser(opts, options)
      end
   end
end

