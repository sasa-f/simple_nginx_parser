# SimpleNginxParser

SimpleNginxParser is Nginx configuration file parser.
The feature is as follows.

+ toranslate from a Configuration file to a array object.
+ serch from the translated object by directive name.


## Usage

```
require 'simple_nginx_parser'

config = SimpleNginxParser::NgxConfig.new("path/to/nginx.conf")
p config.findAll
p config.findParam('http')
p config.findParam('http', 'server', 'location')

ngxele = parser.findAll
ngxele.first.directive
ngxele.first.values
ngxele.first.elements
ngxele.first.type

```

Before parsing 'include' directive, include files are expanded on the defined spot.
