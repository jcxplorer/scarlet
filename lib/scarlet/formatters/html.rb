require 'RedCloth'

module Scarlet::Formatters
  class HTML
    include Scarlet::Formatters::Base
    
    def text
      process_code do |code, language, before, after|
        before + "<notextile><div class=\"code\">" + Scarlet::Highlighter.run(code, :format => "html", :lexer => language) + "</div></notextile>" + after
      end
      
      RedCloth.new(slide.text).to_html
    end
    
    def self.default_template
      File.join(File.dirname(__FILE__), "..", "templates", "html", "default.erb")
    end
  end
end