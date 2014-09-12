
require 'optparse'
require 'ostruct'

# Representation of the command-line for the parabola-generator program.
#
# The key word 'self' in the method declarations indicates that the method
# belongs to the class (and not to an instance). This is like a static method
# in C++.
class GenParabolaCmdline
   # Construct a parser for the command line, and then run the parser.
   #
   # +args+:: List of command-line arguments to the program. ARGV is passed in
   #          here.
   def self.parse(args)
      options = self.getDefaultOptions
      parser = self.makeParser(options)
      parser.summary_width = 20
      parser.parse!(args)  # args (ARGV) will have options removed!
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
      options.e = 1.0  # Default ending    x is 0.0.
      options.n = 10   # Default number of steps is 10.
      options
   end

   # Define what to do when the width is encountered.
   # +parser+::  Parser to which definition will be attached.
   # +options+:: Option values loaded with defaults on entry.
   def self.widthHandler(parser, options)
      wdsc = "From vertex, change in x for unit change in y."
      wdef = "By default, W=#{options.w}"
      parser.on("-w", "--width W", Float, wdsc, wdef) do |w|
         if w <= 0.0
            puts "GenParabolaCmdline::parse: ERROR: " +
                 "Width must be positive, not #{w}\n\n"
            puts parser
            exit 1
         end
         options.w = w
      end
   end

   # Define what to do when the horizontal coordinate of the vertex is
   # encountered.
   # +parser+::  Parser to which definition will be attached.
   # +options+:: Option values loaded with defaults on entry.
   def self.xVertHandler(parser, options)
      xdsc = "X coordinate of vertex."
      xdef = "By default, X=#{options.x}"
      parser.on("-x", "--x-coord X", Float, xdsc, xdef) do |x|
         options.x = x
      end
   end

   # Define what to do when the vertical coordinate of the vertex is
   # encountered.
   # +parser+::  Parser to which definition will be attached.
   # +options+:: Option values loaded with defaults on entry.
   def self.yVertHandler(parser, options)
      ydsc = "Y coordinate of vertex."
      ydef = "By default, Y=#{options.y}"
      parser.on("-y", "--y-coord Y", Float, ydsc, ydef) do |y|
         options.y = y
      end
   end

   # +parser+::  Parser to which definition will be attached.
   # +options+:: Option values loaded with defaults on entry.
   def self.xBegHandler(parser, options)
      bdsc = "Beginning x coordinate."
      bdef = "By default, B=#{options.b}"
      parser.on("-b", "--x-beg B", Float, bdsc, bdef) do |b|
         options.b = b
      end
   end

   # +parser+::  Parser to which definition will be attached.
   # +options+:: Option values loaded with defaults on entry.
   def self.xEndHandler(parser, options)
      edsc = "Ending x coordinate."
      edef = "By default, E=#{options.e}"
      parser.on("-e", "--x-end E", Float, edsc, edef) do |e|
         options.e = e
      end
   end

   # +parser+::  Parser to which definition will be attached.
   # +options+:: Option values loaded with defaults on entry.
   def self.numStepsHandler(parser, options)
      ndsc = "Number of steps between B and E."
      ndef = "By default, N=#{options.n}"
      parser.on("-n", "--num-steps N", Integer, ndsc, ndef) do |n|
         if n < 1
            puts "GenParabolaCmdline::parse: ERROR: " +
                 "number of steps must be positive, not #{n}\n\n"
            puts parser
            exit 1
         end
         options.n = n
      end
   end

   # +parser+::  Parser to which definition will be attached.
   def self.helpHandler(parser)
      parser.on("-h", "--help", "Show this message.") do
         puts parser
         exit 0
      end
   end

   # Construct a parser for the command line.
   #
   # +options+:: Options to be set by parser. Default values have already been
   #             loaded in options before makeParser is called.
   def self.makeParser(options)
      return OptionParser.new do |parser|
         parser.separator <<EOF

Send to standard output the coordinates of points along a parabola.  Each line
of output contains one pair of coordinates separated by white space.

Options:

EOF
         self.widthHandler(parser, options)
         self.xVertHandler(parser, options)
         self.yVertHandler(parser, options)
         self.xBegHandler(parser, options)
         self.xEndHandler(parser, options)
         self.numStepsHandler(parser, options)
         self.helpHandler(parser)
      end
   end
end

