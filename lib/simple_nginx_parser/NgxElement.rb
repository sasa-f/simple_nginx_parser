module SimpleNginxParser
  class NgxElement
    attr_accessor :directive, :type, :values, :elements
    def initialize(directive, type, values, elements)
      @directive = directive
      @type = type
      @values = values
      @elements = elements
    end
  end
end
