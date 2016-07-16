#!/usr/bin/env ruby
# coding: utf-8

require 'bundler/setup'
require 'minitest/autorun'
require 'simple_nginx_parser'

class TestNgxParser < Minitest::Test
  def setup
    gemhome = File.dirname(__FILE__)
    official_conf1 = gemhome + "/conf/nginx.conf"
    my_conf1 = gemhome + "/conf/mynginx.conf"
    error_conf1 = gemhome + "/conf/parseerrornginx.conf"

    file = File.open(official_conf1)
    @official_tokens = SimpleNginxParser::NgxLexer.new.scan(file.read)

    file = File.open(my_conf1)
    @my_tokens = SimpleNginxParser::NgxLexer.new.scan(file.read)

    file = File.open(error_conf1)
    @error_tokens = SimpleNginxParser::NgxLexer.new.scan(file.read)
  end

  def test_parse
    # normal case
    obj = SimpleNginxParser::NgxParser.new.parse(@official_tokens)
    assert_equal true, obj.any?

    obj = SimpleNginxParser::NgxParser.new.parse(@my_tokens)
    assert_equal true, obj.any?

    # abnormal case
    assert_raises(Racc::ParseError) do 
      obj = SimpleNginxParser::NgxParser.new.parse(@error_tokens)
    end
  end
end

