# Require Gemfile gems

def safe_eval(*args)

  # require 'stringio'
  # old_values = [$stderr,$VERBOSE]
  # $stderr = StringIO.new
  # $VERBOSE= false

  ::Thread.new{

    safe_ok= false
    begin
      $SAFE= 3
      safe_ok= true
    rescue
    end
    if safe_ok
      eval(*args)
    end

  }.value

ensure
  # $stderr = old_values[0]
  # $VERBOSE= old_values[1]

end


safe_eval " puts('hello world'); Process.exit! "
