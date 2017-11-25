require 'chunky_png'

class Fractal
  WIDTH = 800
  HEIGHT = 600
  FILENAME = 'fractal.png'.freeze
  ITERATIONS = 600

  def initialize
    @file = ChunkyPNG::Image.new(WIDTH, HEIGHT, ChunkyPNG::Color::WHITE)
    print "Calculating...\n"
    draw
    @file.save(FILENAME, interlace: true)
    print 'Created ' + FILENAME + "\n"
  end

  def draw
    pos_x = 0
    pos_y = 0

    while pos_y < HEIGHT
      while pos_x < WIDTH
        part_re = pos_x / WIDTH.to_f * 3 - 2.0 # -2 ... 1
        part_im = pos_y / HEIGHT.to_f * 2 - 1 # -1 ... 1

        if is_element(part_re, part_im)
          @file[pos_x, pos_y] = ChunkyPNG::Color.rgba(0, 0, 0, 255) # black
        end

        pos_x += 1
      end

      pos_y += 1
      pos_x = 0
    end
  end

  def is_element(part_re, part_im)
    i = 0
    x = 0
    y = 0

    while i < ITERATIONS
      xn = x * x - y * y + part_re
      yn = 2 * x * y + part_im
      x = xn
      y = yn

      return false if x * x + y * y > 4

      i += 1
    end
    true
  end
end

Fractal.new
