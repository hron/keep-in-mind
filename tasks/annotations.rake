require File.expand_path(File.dirname(__FILE__) + "/../keep_in_mind")

namespace :notes do
 task :export do
   %w(TODO FIXME OPTIMIZE).each do |type|
     KeepInMind.export type
   end
 end
end
