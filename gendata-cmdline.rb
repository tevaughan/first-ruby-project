
require 'optparse'
require 'ostruct'

class GenDataCmdLine
   # 'self' here indicates that 'parse' is a (static) method of the class, not
   # a method of the instance.
   def self.parse(args)
      # Options to be specified on the command line along with default values.
      options = OpenStruct.new
      options.w = 1.0
      options.x = 0.0
      options.y = 0.0
      options.b = 0.0
      options.e = 0.0
      options.n = 0
      parser = OptionParser.new do |opts|
         opts.banner = "Usage:  #{$0} [-w W] [-x X] [-y Y] -b B -e E -n N"
         opts.separator <<EOF

Send to standard output the coordinates of points along a parabola.  Each line
of output contains one pair of coordinates separated by white space.

Options:

EOF
         wdsc1 = "At vertex, change in x for unit change"
         wdsc2 = "in y."
         wdef = "By default, W=#{options.w}"
         opts.on("-w", "--width W", Float, wdsc1, wdsc2, wdef) do |w|
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
         opts.on("-b", "--x-beg B", Float, bdsc) do |b|
            options.b = b
         end
         edsc = "Ending x coordinate."
         opts.on("-e", "--x-end E", Float, edsc) do |e|
            options.e = e
         end
         ndsc = "Number of steps between B and E."
         opts.on("-n", "--num-steps N", Integer, ndsc) do |n|
            options.n = n
         end
         opts.separator ""
         opts.on_tail("-h", "--help", "Show this message.") do
            puts opts
            exit
         end
      end
      parser.parse!(args)
      if options.n < 0
         puts("GenDataCmdLine::parse: ERROR: " +
              "negative number #{options.n} of steps")
      end
      options
   end
end

