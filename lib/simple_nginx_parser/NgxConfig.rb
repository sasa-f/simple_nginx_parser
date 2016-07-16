module SimpleNginxParser
  class NgxConfig
    attr_reader :config
    alias findAll config

    def initialize(path)
      @basedir = File.dirname(__FILE__)
      read(path)
    end

    def read(path)
      # open Include File
      @basedir = File.dirname(path)
      expanded_config = expandIncludeFile(path)
      raise CantReadConfigurationError if expanded_config.nil?

      # parse File
      token = NgxLexer.new.scan(expanded_config)
      @config = NgxParser.new.parse(token)
    end

    def expandIncludeFile(path)
      return nil unless File.exists?(path)

      file = File.open(path, 'r')
      config_string = file.read
      config_string.gsub!(/include\s*["']*(.+)["']*\s*;/) do |match|
        matched_path = $1
        is_absolute_path = matched_path[0] == '/'
        abstract_path = is_absolute_path ? matched_path : @basedir + '/' + matched_path
        concrete_paths = Dir.glob(abstract_path)

        replace_str = ''
        replace_str = match if concrete_paths.empty? # not exists include directory or file
        concrete_paths.each do |concrete_path|
          expanded_config = expandIncludeFile(concrete_path)
          replace_str += expanded_config.nil? ? match : expanded_config
        end

        replace_str
      end
      return config_string
    end

    def findParam(*params)
      tmp_config = @config.clone
      found_elements = []

      begin 
        found_elements = find(tmp_config, *params)
      rescue NoMatchedConditionError => e
        STDERR.puts e
      end

      return found_elements
    end

    def find(elements, *params)
      return elements if params.empty?

      param = params.shift
      selected_elements = elements.select{|ele| ele.directive == param}
      raise NoMatchedConditionError if selected_elements.empty?

      selected_elements.each do |ele|
        ele.elements = find(ele.elements, *params)
      end
      return selected_elements
    end

    class NoMatchedConditionError < StandardError; end
    class CantReadConfigurationError < StandardError; end

  end
end

