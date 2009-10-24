require 'rtex'

module Scarlet::Formatters
  class PDF < Scarlet::Formatters::LATEX
    include Scarlet::Formatters::Base
    
    def self.from_latex(latex)
      RTeX::Document.new(latex).to_pdf
    end
  end
end