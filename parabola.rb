
class Parabola
   def initialize(w: 1.0, x: 0.0, y: 0.0)
      @w = w
      @x0 = x
      @y0 = y
   end
   def [](x)
      return @y0 + ((x - @x0)/@w)**2
   end
end

