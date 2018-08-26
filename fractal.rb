require 'chunky_png'

class Fractal
  def initialize(width, height)
    @width = width
    @height = height
    @file = ChunkyPNG::Image.new(@width, @height, ChunkyPNG::Color::WHITE)
  end

  def draw(iterations)
    pos_x = 0
    pos_y = 0

    print "Calculating...\n"

    while pos_y < @height
      while pos_x < @width
        part_re = pos_x / @width.to_f * 3 - 2.0 # -2 ... 1
        part_im = pos_y / @height.to_f * 2 - 1 # -1 ... 1

        alpha = calculate_color(part_re, part_im, iterations)
        @file[pos_x, pos_y] = ChunkyPNG::Color.rgba(0, 0, 0, alpha)

        pos_x += 1
      end

      pos_y += 1
      pos_x = 0
    end
  end

  def save(filename)
    @file.save(filename, interlace: true)
    print 'Created ' + filename + "\n"
  end

  private

  def calculate_color(part_re, part_im, iterations)
    i = 0
    x = 0
    y = 0
    alpha = 255

    while i < iterations
      xn = x * x - y * y + part_re
      yn = 2 * x * y + part_im
      x = xn
      y = yn

      return alpha if x * x + y * y > 4

      i += 1

      if alpha > 5
        alpha -= 10
      elsif alpha == 5
        alpha -= 5
      end
    end
    255
  end
end

fractal = Fractal.new(800, 600)
fractal.draw(600)
fractal.save('fractal.png')
