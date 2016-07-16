module SimpleNginxParser
  class NgxBlock < NgxDirective
    def initialize(directive, values, elements)
      super(directive, NgxBlock, values, elements)
    end
  end
end
