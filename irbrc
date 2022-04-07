IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'irb/ext/save-history'

#History configuration
IRB.conf[:SAVE_HISTORY] = 1000

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

def history
  entries = if Readline::HISTORY.entries.respond_to? :split
    Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
  else
    Readline::HISTORY.entries[0..-2]
  end
  puts entries
end

def full_history
  puts Readline::HISTORY.entries.join("\n")
end

def reset!
  exec $0
end

def require_with_rescue(lib)
  require lib
rescue LoadError
  puts "Error loading #{lib}. Continuing."
end

# Ruby 1.9 / Rails 3
require 'bundler'
begin
  Bundler.require :console
rescue Bundler::GemfileNotFound
  begin
    require 'rubygems'
    # require_with_rescue 'wirble'
  rescue LoadError => e
	  puts "load error - #{e}"
  end
end

begin
  Wirble.init
  Wirble.colorize
rescue
end

if ENV.include?('RAILS_ENV')
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end

  rails_root = File.basename(Dir.pwd)
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{rails_root} > ",
    :PROMPT_S => "#{rails_root} * ",
    :PROMPT_C => "#{rails_root} ? ",
    :RETURN   => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  IRB.conf[:IRB_RC] = Proc.new do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.instance_eval { alias :[] :find }
  end
end
