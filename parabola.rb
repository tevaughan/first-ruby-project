
# Representation of a parabola.
class Parabola
   # Construct parabola from its width and from the location of its vertex.
   # +w+:: Width of parabola. From the vertex, +w+ is the horizontal distance
   #       corresponding to unit vertical distance.
   # +x+:: Horizontal coordinate of the vertex.
   # +y+:: Vertical coordinate of the vertex.
   def initialize(w: 1.0, x: 0.0, y: 0.0)
      @w = w
      @x0 = x
      @y0 = y
   end
   # Return the vertical coordinate on the parabola for the given horizontal
   # coordinate.
   # +x+:: Horizontal coordinate.
   def [](x)
      return @y0 + ((x - @x0)/@w)**2
   end
end

