require 'rubygems'
begin
  require 'utility_belt'
rescue LoadError
  warn "Missing utility_belt gem"
end

begin
  require 'hirb'
  Hirb::View.enable
rescue LoadError
  warn "Missing hirb gem"
end
