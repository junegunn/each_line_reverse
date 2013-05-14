each_line_reverse
=================

Read lines of a file in reverse order.

Installation
------------

Add this line to your application's Gemfile:

    gem 'each_line_reverse'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install each_line_reverse

Usage
-----

```ruby
require 'each_line_reverse'

File.open('long-long-file').each_line_reverse do |line|
  # line.chomp
end

# Returns an enumerator when block is not given
enum = File.open('long-long-file').each_line_reverse
last_10x10 = enum.each_slice(10).take(10)

# Optional parameters:
# - Line separator   (default: $/)
# - Read buffer size (default: 8192)
enum = File.open('long-long-file').each_line_reverse("\r\n", 16384)
```

Benchmark
---------

```ruby
require 'benchmark'
require 'each_line_reverse'

Benchmark.bm { |x|
  x.report(:each_line_reverse) {
    File.open('long-long-file').each_line_reverse.take(10)
  }
  x.report(:reverse) {
    File.readlines('long-long-file').reverse.take(10)
  }
}
```

### 1 million-line file

```
                           user     system      total        real
each_line_reverse      0.000000   0.000000   0.000000 (  0.027401)
reverse                1.000000   0.260000   1.260000 (  1.266308)
```

### 10 million-line file

```
                           user     system      total        real
each_line_reverse      0.000000   0.000000   0.000000 (  0.021664)
reverse               12.590000   3.250000  15.840000 ( 19.271157)
```

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
