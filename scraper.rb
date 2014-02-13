require 'anemone'

Anemone.crawl("http://t66y.com/thread0806.php?fid=16", options={delay: 3, verbose: true, read_timeout: 30, user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36"}) do |anemone|
#Anemone.crawl("https://github.com/LeoShi/",options={delay: 1.5}) do |anemone|
  titles = []
  #anemone.on_every_page { |page| titles.push page.doc.at('title').inner_html }
  #anemone.after_crawl { puts titles.compact.sort }

  anemone.on_every_page do |page|
    puts page.url
    #puts "links:#{page.links.inspect}"
  end
end


#http = Net::HTTP.new("t66y.com", 80)
#request = Net::HTTP::Get.new("http://t66y.com/thread0806.php?fid=16")
#response = http.request(request)
#puts response.inspect

#http = Net::HTTP.new("t66y.com", 80)
#request = Net::HTTP::Get.new("http://t66y.com/thread0806.php?fid=22")
#
#response = http.request(request)
#puts response.inspect