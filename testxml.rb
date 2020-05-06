require 'pg'
#!/usr/bin/ruby -w
require 'rexml/document'
require 'nokogiri'

doc = Nokogiri::XML(File.open("tracking.xml")) 
block = doc.xpath("//Package/Activity")
chld_name = block.map do |node|
  data=  node.children.map{|n| [n.name,n.text.strip] if n.elem? }.compact
  p node.css('ActivityLocation Address City').text
  end.compact
  