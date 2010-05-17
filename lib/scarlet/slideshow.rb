module Scarlet
  class Slideshow
    attr_reader :slides, :options
    
    def initialize(enumerable, options={})
      @options = options
      formatter = options[:format].nil? ? Scarlet::Formatter.default : Scarlet::Formatter.for(options[:format]) 
      @slides = slice(enumerable)
      @slides.each { |slide| slide.format!(formatter) }
    end
    
    def render
      case @options[:format]
      when :html
        template = File.read(options[:template] || Scarlet::Formatters::HTML.default_template)
        ERB.new(template).result(binding)
      when :latex
        template = File.read(options[:template] || Scarlet::Formatters::LATEX.default_template)
        ERB.new(template).result(binding)
      when :pdf
        template = File.read(options[:template] || Scarlet::Formatters::PDF.default_template)
        Scarlet::Formatters::PDF.from_latex(ERB.new(template).result(binding))
      else
        raise "Format not supported."
      end
    end
    
    private
    
      def slice(enumerable)
        slides = []
        enumerable.lines.each do |line|
          if line.include? "!SLIDE"
            slides << Scarlet::Slide.new
            slides.last.classes = line.gsub("!SLIDE", "").strip
          else
            next if slides.empty?
            slides.last.text << line
          end
        end
        return slides
      end
  end
end
