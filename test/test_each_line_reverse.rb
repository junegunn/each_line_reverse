require 'rubygems'
require 'benchmark'
require 'minitest/autorun'
require 'each_line_reverse'
require 'tempfile'

class TestEachLineReverse < MiniTest::Unit::TestCase
  def test_each_line_reverse_block
    Dir[File.expand_path('../..', __FILE__) + '**/*'].each do |file|
      [nil, $/, 'e', ' '].each do |sep|
        next if File.directory?(file)

        # Without block
        lines = File.open(file).each(*sep).to_a.reverse
        assert_equal lines, File.open(file).each_line_reverse(*sep).to_a

        # With block
        rlines = []
        File.open(file).each_line_reverse(*sep) do |line|
          rlines << line
        end
        assert_equal lines, rlines

        # Buffer size
        [0, -1, :sym].each do |bufsz|
          assert_raises(ArgumentError) { File.open(file).each_line_reverse(sep || $/, bufsz) }
        end
        (0..16).each do |sh|
          bufsz = 1 << sh
          assert_equal lines, File.open(file).each_line_reverse(sep || $/, bufsz).to_a
        end
      end
    end
  end

  def test_benchmark
    file = Tempfile.new('test_each_line_reverse')
    line = '_' * 80
    (10 ** 6).times do |i|
      file.puts line
    end
    file.close
    Benchmark.bm(20) { |x|
      x.report(:each_line_reverse) {
        File.open(file.path).each_line_reverse.take(10)
      }
      x.report(:reverse) {
        File.readlines(file.path).reverse.take(10)
      }
    }
  end
end
