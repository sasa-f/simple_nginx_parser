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
    error_conf1 = gemhome + "/conf/lexererrornginx.conf"

    @official_file = File.open(official_conf1)
    @my_file = File.open(my_conf1)
    @error_file = File.open(error_conf1)
  end

  def test_parse
    # normal case
    obj = SimpleNginxParser::NgxLexer.new.scan(@official_file.read)
    assert_equal true, obj.any?

    obj = SimpleNginxParser::NgxLexer.new.scan(@my_file.read)
    assert_equal true, obj.any?

    # abnormal case
    assert_raises(SimpleNginxParser::NgxLexer::TokenError) do
      obj = SimpleNginxParser::NgxLexer.new.scan(@error_file.read)
    end
  end
end

