require 'anemone'
require 'mechanize'
require 'set'

class CaoliuSpider

  def initialize
    @base_file_path = '/Users/lei/temp'
    @skip_urls = %w(http://t66y.com/htm_data/16/1402/661124.html http://t66y.com/htm_data/16/1110/622028.html http://t66y.com/htm_data/16/1109/594741.html http://t66y.com/htm_data/16/1106/524942.html http://t66y.com/htm_data/16/1006/341683.html http://t66y.com/htm_data/16/0907/344501.html http://t66y.com/htm_data/16/0805/136474.html).to_set
  end

  def run
    Anemone.crawl("http://t66y.com/thread0806.php?fid=16", options={delay: 3, verbose: false, read_timeout: 30, depth_limit: 1}) do |anemone|
      anemone.on_pages_like(/htm_data/) do |page|
        unless @skip_urls.include? page.url.to_s.strip
          puts "link url:#{page.url}"
          page.doc.search("//input[@type='image']").each do |a|
            download_pic a['src']
          end
        end
      end
    end
  end

  def download_pic url
    uri = URI.parse(URI.encode(url))
    hostname, image_name = uri.host.downcase, uri.path.split('/')[-1]
    img_folder_path = File.join(@base_file_path, hostname)
    system("mkdir -p #{img_folder_path}")

    img_file_path = File.join(img_folder_path, image_name)
    unless File.exist? img_file_path
      sleep 2
      puts "img file: #{img_file_path}"
      agent = Mechanize.new
      agent.keep_alive = false
      agent.get(url).save img_file_path
    end
  end


end

CaoliuSpider.new.run