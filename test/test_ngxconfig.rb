#!/usr/bin/env ruby
# coding: utf-8

require 'bundler/setup'
require 'minitest/autorun'
require 'simple_nginx_parser'

class TestNgxConfig < Minitest::Test
  def setup
    gemhome = File.dirname(__FILE__)
    @official_conf1 = gemhome + "/conf/nginx.conf"
    @my_conf1 = gemhome + "/conf/mynginx.conf"
  end

  def test_read
    # normal case
    obj = SimpleNginxParser::NgxConfig.new(@official_conf1)
    assert_equal true, obj.findAll.size > 0
    assert_equal true, obj.findAll.class == Array # always return Array obj 
    assert_equal true, obj.findParam('http').size > 0
    assert_equal true, obj.findParam('http').class == Array # always return Array obj 
    assert_equal true, obj.findParam('http', 'if', 'location').size == 0
    assert_equal true, obj.findParam('http', 'if', 'location').class == Array # always return Array obj 

    obj = SimpleNginxParser::NgxConfig.new(@my_conf1)
    assert_equal true, obj.findAll.size > 0
    assert_equal true, obj.findAll.class == Array # always return Array obj 
    assert_equal true, obj.findParam('http').size > 0
    assert_equal true, obj.findParam('http').class == Array # always return Array obj 
    assert_equal true, obj.findParam('http', 'if', 'location').size > 0
    assert_equal true, obj.findParam('http', 'if', 'location').class == Array # always return Array obj 

    # exception case
    assert_raises(SimpleNginxParser::NgxConfig::CantReadConfigurationError) do
      obj = SimpleNginxParser::NgxConfig.new('')
    end

  end
end

