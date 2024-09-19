require 'io/console'

art = [
  "----    ---- ------------ ----         ----           --------        ------------ ----    ----    ------    ------------ ",
  "****    **** ************ ****         ****          **********       ************ ****    ****   ********   ************ ",
  "----    ---- ----         ----         ----         ----    ----      ---          ----    ----  ----------  ------------ ",
  "************ ************ ****         ****         ***      ***      ***          ************ ****    ****     ****     ",
  "------------ ------------ ----         ----         ---      ---      ---          ------------ ------------     ----     ",
  "****    **** ****         ************ ************ ****    ****      ***          ****    **** ************     ****     ",
  "----    ---- ------------ ------------ ------------  ----------       ------------ ----    ---- ----    ----     ----     ",
  "****    **** ************ ************ ************   ********        ************ ****    **** ****    ****     ****     ",
  "                                                                                                                          "
]

max_length = art.map(&:length).max
art.map! { |line| line.ljust(max_length) }

cols, rows = IO.console.winsize
art_width = art[0].length

gap_size = cols
gap = ' ' * gap_size
total_segment_length = art_width + gap_size

repeats = ((cols + total_segment_length - 1) / total_segment_length).ceil + 2

art_lines = art.map do |line|
  initial_gap = ' ' * gap_size
  (initial_gap + (line + gap) * repeats)
end

offset = 0

begin
  print "\e[?25l"
  print "\e[2J\e[H"

  loop do
    print "\e[H"

    art_lines.each do |line|
      visible_line = line[offset, cols]
      puts visible_line
    end

    offset += 1
    offset %= total_segment_length

    sleep(0.05)
  end
ensure
  print "\e[?25h"
end
