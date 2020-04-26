# TODO: Write documentation for `Ms`
module Ms
  VERSION = "0.1.0"

  S = 1000
  M = S * 60
  H = M * 60
  D = H * 24
  W = D * 7
  Y = D * 365.25

  extend self

  def ms(val : String)
    raise Exception.new("val is not a non-empty string. val=#{val}") if val.size == 0
    parse(val)
  end

  def ms(val, options = {} of String => Bool)
    options[:long]? ? fmt_long(val) : fmt_short(val)
  end

  # Parse the given `str` and return milliseconds.
  private def parse(str : String)
    return if str.size > 100

    match = /^(-?(?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|weeks?|w|years?|yrs?|y)?$/i.match(str)

    return if match.nil?

    n = match[1].to_f64
    type = (match[2]? || "ms").downcase

    case type
    when "years", "year", "yrs", "yr", "y"
      return n * Y
    when "weeks", "week", "w"
      return n * W
    when "days", "day", "d"
      return n * D
    when "hours", "hour", "hrs", "hr", "h"
      return n * H
    when "minutes", "minute", "mins", "min", "m"
      return n * M
    when "seconds", "second", "secs", "sec", "s"
      return n * S
    when "milliseconds", "millisecond", "msecs", "msec", "ms"
      return n
    else
      return nil
    end
  end

  # Short format for `ms`.
  private def fmt_short(ms)
    ms_abs = ms.abs

    return (ms / D).round.to_i64.to_s + 'd' if ms_abs >= D
    return (ms / H).round.to_i64.to_s + 'h' if ms_abs >= H
    return (ms / M).round.to_i64.to_s + 'm' if ms_abs >= M
    return (ms / S).round.to_i64.to_s + 's' if ms_abs >= S

    return "#{ms.to_i64}ms"
  end

  # Long format for `ms`.
  private def fmt_long(ms)
    ms_abs = ms.abs

    return plural(ms, ms_abs, D, "day") if ms_abs >= D
    return plural(ms, ms_abs, H, "hour") if ms_abs >= H
    return plural(ms, ms_abs, M, "minute") if ms_abs >= M
    return plural(ms, ms_abs, S, "second") if ms_abs >= S

    "#{ms.to_i64} ms"
  end

  # Pluralization helper.
  def plural(ms, ms_abs, n, name)
    is_plural = ms_abs >= n * 1.5

    String.build do |str|
      str << (ms / n).round.to_i64
      str << " "
      str << name
      str << "s" if is_plural
    end
  end
end
