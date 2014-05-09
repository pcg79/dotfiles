Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"

    TOPLEVEL_BINDING.eval("self").extend ::Rails::ConsoleMethods
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "no awesome_print :("
end

class Object
  def local_methods
    (self.methods - Object.methods).sort
  end
end
