module SimpleNginxParser
  class NgxComment < NgxElement
    NOT_DIRECTIVE = ''
    def initialize(values)
      super(NOT_DIRECTIVE , NgxComment, values, [])
    end
  end
end
