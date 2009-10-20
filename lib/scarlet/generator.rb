module Scarlet
  module Generator
    def self.files(destination)
      Dir.mkdir(destination) if Dir[destination].empty?
      ["javascripts", "stylesheets"].each do |folder|
        FileUtils.cp_r(File.join(File.dirname(__FILE__), "templates", "html", folder), destination)
      end
    end
  end
end