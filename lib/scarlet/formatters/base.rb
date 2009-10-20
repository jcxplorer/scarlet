module Scarlet::Formatters
  module Base
    attr_accessor :slide

    def initialize(slide)
      @slide = slide
    end
    
    protected
    
      def process_code
        slide.text.gsub!(/(([\t\n])?@@@(?:\ ([a-z]+))?(.+?)@@@([\t\n])?)/m) do |block|
          before = $~[2]
          after = $~[5]
          language = ($~[3] || :text).to_sym
          code = $~[4]

          yield(code, language, before, after)
        end
      end
  end
end