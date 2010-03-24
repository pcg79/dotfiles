IRB.conf[:PROMPT_MODE] = :SIMPLE

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

def history
  puts Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
end

require 'rubygems'

begin
  require 'hirb'
  Hirb::View.enable
rescue LoadError
  warn "Missing hirb gem"
end
