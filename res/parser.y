
class SimpleNginxParser::NgxParser
rule
  statements : statement statements { result = val[0].concat(val[1]) }
             | statement { result = val[0] }

  statement  : param { result = [val[0]] }
             | comment { result = [val[0]] }
             | block { result = [val[0]] }

  param      : directive values SEMICOLON { result = NgxParam.new(val[0],val[1]) }
  comment    : COMMENT { result = NgxComment.new(val[0].lstrip) }
  block      : directive values LBRACE statements RBRACE {result = NgxBlock.new(val[0], val[1], val[3]) }

  directive  : STRING { result = val[0] }

  values     : value values { result = val.flatten}
             | { result = [] }

  value      : NUMBER { result = val[0].to_i }
             | STRING { result = val[0] }
             | DOUBLE_QUOTED_STRING { result = val[0] }
             | SINGLE_QUOTED_STRING { result = val[0] }

end

---- inner
IF = 'if'
def parse(tokens)
  @q = tokens
  config = do_parse
  config
end

def next_token
  @q.shift
end

