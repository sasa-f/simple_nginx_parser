require 'strscan'

module SimpleNginxParser
  class NgxLexer

    STRING_EXCEPT_QUOTE = '[\(\)0-9a-zA-Z_\/+?\$&^@*\\\\|\-:\.\~=\[\]!]'
    STRING_INCLUDE_QUOTE = '[\(\)0-9a-zA-Z_\/+?\$&^@*\\\\|\-:\.\~=\[\]!"\']'

    STRING = /#{STRING_EXCEPT_QUOTE}{1}#{STRING_INCLUDE_QUOTE}*#{STRING_EXCEPT_QUOTE}{1}|#{STRING_EXCEPT_QUOTE}{1}/
    STRING_EXCEPT_NUMBER = /[\(\)a-zA-Z_\/+?\$&^@*\\|\-:\.\~=\[\]!]+/
    SINGLE_QUOTED_STRING = /'["\(\)0-9a-zA-Z_\/+?\$&^@*\\|\-:\.\~=;\[\] {}#!%]+'/
    DOUBLE_QUOTED_STRING = /"['\(\)0-9a-zA-Z_\/+?\$&^@*\\|\-:\.\~=;\[\] {}#!%]+"/
    SEMICOLON = /;/
    COMMENT = /\s*#.*$/
    LBRACE = /{/
    RBRACE = /}/
    SPACE = /[[:space:]]/

    def initialize
      @q = []
    end
   
    def scan(config)
      s = StringScanner.new(config)

      prev_pos = s.pos
      until s.eos?
        @q << scanString(s.matched) if s.scan(STRING)
        @q << [:SINGLE_QUOTED_STRING, s.matched] if s.scan(SINGLE_QUOTED_STRING)
        @q << [:DOUBLE_QUOTED_STRING, s.matched] if s.scan(DOUBLE_QUOTED_STRING)
        @q << [:SEMICOLON, s.matched] if s.scan(SEMICOLON)
        @q << [:COMMENT, s.matched] if s.scan(COMMENT)
        @q << [:LBRACE, s.matched] if s.scan(LBRACE)
        @q << [:RBRACE, s.matched] if s.scan(RBRACE)
        s.scan(SPACE) # skip

        raise TokenError if prev_pos == s.pos
        prev_pos = s.pos
      end
      @q
    end

    def scanString(str)
      str = str.rstrip
      # only numeric
      return [:STRING, str] if STRING_EXCEPT_NUMBER =~ str
      # prefix is a '0' character
      return [:STRING, str] if str[0] == '0'
      return [:NUMBER, str]
    end

    class TokenError < StandardError; end
  end
end
