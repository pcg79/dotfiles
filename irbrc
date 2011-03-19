IRB.conf[:PROMPT_MODE] = :SIMPLE

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

def history
  puts Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
end

# Ruby 1.8 / Rails 2
# require 'rubygems'
#
# begin
#   require 'hirb'
#   Hirb::View.enable
# rescue LoadError
#   warn "Missing hirb gem"
# end

# Ruby 1.9 / Rails 3
require 'bundler'
begin
  Bundler.require :console
rescue Bundler::GemfileNotFound
  require 'rubygems'
  require 'wirble'
  require 'hirb'
end
Wirble.init
Wirble.colorize
Hirb.enable
