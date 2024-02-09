require 'nokogiri'

class WebScrape
  attr_accessor :html

  def initialize(html)
    @html = html
  end
end
html = file_contents = File.read('files/van-gogh-paintings.html')

p WebScrape.new(html).html
