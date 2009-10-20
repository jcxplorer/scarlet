require 'optparse'

module Scarlet
  module Runner
    def self.go!(argv)
      options = { :format => :html }

      OptionParser.new do |opts|
        opts.banner = <<-EOF
Usage:
  scarlet [options] file
  scarlet --generate destination
EOF

        argv = ["-h"] if argv.empty?

        opts.on "-f", "--format FORMAT", "Format to generate" do |format|
          options[:format] = format.to_sym
        end

        opts.on "-t", "--template FILE", "ERB template file to use" do |file|
          options[:template] = file
        end

        opts.on "-g", "--generate DEST", "Generate javascript and stylesheet files" do |path|
          Scarlet::Generator.files(path)
          exit
        end

        opts.on "-h", "--help", "Show this message" do
          puts opts
          exit
        end

        begin
          opts.parse!(argv)
        rescue OptionParser::InvalidOption => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end

      file = File.read(argv[0])
      slideshow = Scarlet::Slideshow.new(file, options)
      puts slideshow.render
    end
  end
end