require 'RedCloth'

module Scarlet::Formatters
  class LATEX
    include Scarlet::Formatters::Base
    
    def text
      process_code do |code, language, before, after|
        before + "<notextile>" + Scarlet::Highlighter.run(code, :format => "latex", :lexer => language) + "</notextile>" + after
      end
      
      RedCloth.new(slide.text).to_latex
    end
    
    def self.default_template
      File.join(File.dirname(__FILE__), "..", "templates", "latex", "default.erb")
    end
  end
end