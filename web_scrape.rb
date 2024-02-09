require 'nokogiri'

class WebScrape
  attr_accessor :html

  GOOGLE_URL = "https://www.google.com".freeze

  def initialize(html)
    @html = html
  end

  def extract_from_carrousel(carrousel_css)
    doc = Nokogiri::HTML(@html)
    carrousel = doc.css(carrousel_css) # Selecting all <a> tags with class 'klitem'
    carrousel.map do |item|
      item_data = {}
      item_data[:name] = item['aria-label']
      item_data[:date] = item.at_css('div.ellip.klmeta')&.text # Using &.text to avoid nil error
      item_data[:google_link] = GOOGLE_URL + item['href']
      item_data[:thumbnail] = item.at_css('img')['src']

      item_data
    end
  end
end
html = File.read('files/van-gogh-paintings.html')
carrousel_css = 'a.klitem'
pp WebScrape.new(html).extract_from_carrousel(carrousel_css)
