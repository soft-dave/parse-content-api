require 'nokogiri'
require 'open-uri'

class Page < ApplicationRecord
  has_many :page_contents, dependent: :destroy
  validates :page_url, uniqueness: true
  after_create :parse_page


  def parse_page
    doc = Nokogiri::HTML(open(self.page_url))
    self.parse_tags.to_a.each do |tag|
      doc.css(tag).each do |link|
        self.page_contents.find_or_create_by(tag: tag, content: link.content.to_s.force_encoding("ISO-8859-1").encode("UTF-8"))
      end
    end
  end

  def parse_tags
    %w(a h1 h2 h3)
  end

end
