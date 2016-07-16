module SimpleNginxParser
  class NgxParam < NgxDirective
    def initialize(directive, values)
      super(directive, NgxParam, values, [])
    end
  end
end
