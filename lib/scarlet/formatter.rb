module Scarlet
  module Formatter
    DEFAULT = Scarlet::Formatters::HTML
    FORMATTERS = {
      :html => Scarlet::Formatters::HTML,
      :xhtml => Scarlet::Formatters::HTML,
      :latex => Scarlet::Formatters::LATEX
    }
    
    def Formatter.for(format)
      FORMATTERS[format.to_sym]
    end
    
    def Formatter.default
      DEFAULT
    end
  end
end