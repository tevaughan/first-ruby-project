
class CmdParm
   attr_reader :letter
   attr_reader :required
   attr_reader :defVal
   # Construct a representation of a parameter to a command-line program.
   #
   # +letter+::    Letter for command-line parameter. This is the letter that
   #               must be preceded by a '-' on the command line in order to
   #               specify the parameter.
   #
   # +required+::  Flag indicating whether the parameter be required on the
   #               command line.
   #
   # +argSym+::    Symbol representing the value of the parameter's argument.
   #               The symbol is displayed in the message describing how to use
   #               the program.  If parameter take no argument, then argSym is
   #               omitted or set to "".
   #
   # +defVal+::    Default value for parameter's argument, in case the
   #               parameter be not specified on the command line.
   def initialize(letter:, required: true, argSym: "", defVal: nil)
      if letter.to_str.size != 1
         puts "CmdParm: ERROR: expected single letter, not '#{letter.to_str}'"
         exit 1
      end
      @letter   = letter
      @required = required
      @argSym   = argSym
      @defVal   = defVal
   end
   # Produce description for documentation of usage.
   def desc
      return "-#{@letter} <#{@argSym}>"
   end
   # Produce the symbol for the parameter's argument. If the parameter take no
   # argument, then return the empty string; otherwise, return the symbol
   # surrounded by angle brackets.
   def argSym
      if @argSym == ""
         return ""
      end
      return "<#{@argSym}>"
   end
end

