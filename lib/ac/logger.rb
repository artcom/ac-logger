require 'logger'
require 'ac/logger/version'

module AC::Logger
  def self.[](*args)
    Instance.new(*args)
  end

  Levels = {
    "debug" => ::Logger::DEBUG,
    "info"  => ::Logger::INFO,
    "warn"  => ::Logger::WARN,
    "error" => ::Logger::ERROR,
    "fatal" => ::Logger::FATAL,
  }

  class Instance < ::Logger

    # default output is STDOUT for rails test and non-rails apps, to a logfile
    # otherwise
    def default_outstream
      if ! (Object.const_defined? 'Rails')
        STDOUT
      else
        if 'test' === ::Rails.env
          STDOUT
        else 
          "#{::Rails.root.to_s}/log/#{::Rails.env}.log"
        end
      end
    end

    def initialize out = nil, level = ::Logger::WARN
      super(out || default_outstream)
      self.level = level
    end

    # this is to de-patch the rails formatting patch..
    def format_message(severity, ts, progname, msg)
      "#{ts.strftime '%Y-%m-%d %H:%M:%S'} #{severity.chars.first} #{msg}\n"
    end 

    # exception convenience function with callstack logging:
    #
    #   Log.ex e
    #
    # does actually do: 
    #   Log.error e
    #   Log.debug "#{e.backtrace.join "\n\t"}"
    #
    # and:
    #   Log.ex e, "some message here"
    #
    # stands for:
    #   Log.error "some message here"
    #   Log.debug "#{e.backtrace.join "\n\t"}"
    #
    def ex(e, msg = nil, level = :error)
      __send__ level, "#{e}: #{msg}"
      debug "#{e} -> (callstack):\n\t#{e.backtrace.join "\n\t"}"
    end
  end
end
