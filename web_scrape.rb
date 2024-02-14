require 'nokogiri'

class WebScrape
  attr_accessor :html

  GOOGLE_URL = "https://www.google.com".freeze

  def initialize(html)
    @html = html
  end

  def extract_from_carousel(carousel_css)
    doc = Nokogiri::HTML(@html)
    carousel = doc.css(carousel_css)[2]
    binding.irb
    carousel.css('a').map do |item|
      # binding.irb
      item_data = {}
      item_data[:name] = item['aria-label']
      item_data[:date] =  item.css("div:first-child+div").map(&:text).last
      item_data[:google_link] = "#{GOOGLE_URL}#{item['href']}" if item['href']
      # item_data[:thumbnail] = item.at_css('img')['src'] if item.at_css('img')

      item_data
    end
  end

  def find_child(item)
    return item if item.children.empty?
    find_child(item.children.last)
  end
end
p 'files/van-gogh-paintings.html'
html = File.read('files/van-gogh-paintings.html')
# p 'files/timothee chalamet - Google Search.html'
# html = File.read('files/timothee chalamet - Google Search.html')
# p 'files/van gogh - Google Search.html'
# html = File.read('files/van gogh - Google Search.html')

carousel_css = 'g-scrolling-carousel'
pp WebScrape.new(html).extract_from_carousel(carousel_css)
