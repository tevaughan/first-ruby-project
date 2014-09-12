
require 'optparse'
require 'ostruct'

# Representation of the command-line for the parabola-generator program.
class GenParabolaCmdline
   # 'self' here indicates that 'parse' is method of class (not of instance).
   # +args+:: List of command-line arguments to the program. ARGV is passed in
   #          here.
   def self.parse(args)
      # Options to be specified on the command line along with default values.
      options = OpenStruct.new
      options.w = 1.0  # Default width is 1.0.
      options.x = 0.0  # Default x position of vertex is 0.0.
      options.y = 0.0  # Default y position of vertex is 0.0.
      options.b = 0.0  # Default beginning x is 0.0.
      options.e = 0.0  # Default ending    x is 0.0.
      options.n = 0    # Default number of steps is 0, an illegal value.
      parser = OptionParser.new do |opts|
         opts.banner = "Usage:  #{$0} [-w W] [-x X] [-y Y] [-b B] [-e E] -n N"
         opts.separator <<EOF

Send to standard output the coordinates of points along a parabola.  Each line
of output contains one pair of coordinates separated by white space.

Options:

EOF
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
         xdsc = "X coordinate of vertex."
         xdef = "By default, X=#{options.x}"
         opts.on("-x", "--x-coord X", Float, xdsc, xdef) do |x|
            options.x = x
         end
         ydsc = "Y coordinate of vertex."
         ydef = "By default, Y=#{options.y}"
         opts.on("-y", "--y-coord Y", Float, ydsc, ydef) do |y|
            options.y = y
         end
         bdsc = "Beginning x coordinate."
         bdef = "By default, B=#{options.b}"
         opts.on("-b", "--x-beg B", Float, bdsc, bdef) do |b|
            options.b = b
         end
         edsc = "Ending x coordinate."
         edef = "By default, E=#{options.e}"
         opts.on("-e", "--x-end E", Float, edsc, edef) do |e|
            options.e = e
         end
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
         opts.on_tail("-h", "--help", "Show this message.") do
            puts opts
            exit 0
         end
      end
      parser.summary_width = 20
      parser.parse!(args)
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
end

