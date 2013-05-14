class IO
  # @param [String] sep Line separtor (default: $/)
  # @param [Fixnum] bufsz Buffer size (default: 8192 bytes)
  # @return [Enumerator]
  def each_line_reverse sep = $/, bufsz = 8192
    raise ArgumentError, "invalid buffer size" unless bufsz.is_a?(Integer) && bufsz > 0
    return enum_for(:each_line_reverse, sep, bufsz) unless block_given?

    buffer = ''
    seplen = sep.length

    seek 0, SEEK_END
    return if pos == 0

    while pos > 0
      bytes = [bufsz, pos].min
      seek -bytes, SEEK_CUR
      buffer = read(bytes) << buffer
      seek -bytes, SEEK_CUR

      while ridx = buffer.rindex(sep, -1 - seplen)
        yield buffer.slice!((ridx + seplen)..-1)
      end
    end

    yield buffer unless buffer.empty?
  end
end

