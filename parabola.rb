
class Parabola
   def initialize(a: 1.0, h: 0.0, k: 0.0)
      @a = a
      @h = h
      @k = k
   end
   def [](x)
      return @k + @a*(x - @h)**2
   end
end

