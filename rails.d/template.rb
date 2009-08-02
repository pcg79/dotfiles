# Inlining a bunch of file directives is a pain in the ass.  Just use an
# existing directory instead.
def directory(path, log_action = true)
  path = File.expand_path(path)
  log 'directory', path if log_action
  in_root do
    everything_including_dotfiles = "{.[!.]*,*}"
    sources = Dir.glob(File.join(path, everything_including_dotfiles))
    FileUtils.cp_r(sources, ".")
  end
end

# Rails should utilize better yaml conventions
def rewrite_database_yml
  app_name = nil
  in_root { app_name = File.basename(FileUtils.pwd) }
  gsub_file "config/database.yml.example", "APP_NAME", app_name
  run "cp config/database.yml.example config/database.yml"
end

############################################################

paperclip    = yes?("Add the paperclip gem?")
clearance    = yes?("Add the clearance gem?")
twitter_auth = yes?("Add the twitter-auth gem?") unless clearance

%w(index.html dispatch.* javascripts/*.js images/rails.png favicon.ico).each do |public_file|
  run "rm public/#{public_file}"
end

capify!

directory "~/.rails.d/template"

rewrite_database_yml

run "mkdir -p app/javascripts/vendor"
run "curl -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > app/javascripts/vendor/jquery.js"

gem "haml",                        :version => "2.0.9"
gem "thoughtbot-hoptoad_notifier", :version => "1.1",     :lib => "hoptoad_notifier", :source  => "http://gems.github.com"
gem "thoughtbot-pacecar",          :version => "1.1.5",   :lib => "pacecar",          :source  => "http://gems.github.com"
gem "thoughtbot-paperclip",        :version => "2.2.9.1", :lib => "paperclip",        :source  => "http://gems.github.com" if paperclip
gem "thoughtbot-clearance",        :version => "0.6.6",   :lib => "clearance",        :source  => "http://gems.github.com" if clearance
gem "mbleigh-twitter-auth",        :version => "0.1.21",  :lib => "twitter-auth",     :source  => "http://gems.github.com" if twitter_auth

gem "mocha",                   :env => :test
gem "fakeweb",                 :env => :test
gem "thoughtbot-shoulda",      :env => :test, :lib => "shoulda",      :source  => "http://gems.github.com"
gem "thoughtbot-factory_girl", :env => :test, :lib => "factory_girl", :source  => "http://gems.github.com"

plugin "strip_attributes",       :git => "git://github.com/rmm5t/strip_attributes.git"
plugin "dancing_with_sprockets", :git => "git://github.com/coderifous/dancing_with_sprockets.git"

if paperclip
  initializer 'paperclip.rb', <<-CODE
Paperclip::Attachment.default_options[:url]  = "/system/:class/:attachment/:id_partition/:style/:filename"
CODE
end

git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"
