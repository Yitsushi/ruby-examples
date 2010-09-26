require 'rubygems'
require 'open-uri'
require 'json'

LOGIN   = 'bitly_username'
API_KEY = 'api_key_from_bitly_account_settings'

class BitLy
  public
  def initialize(login, api_key)
    @login   = login
    @api_key = api_key
    @base_url = "http://api.bit.ly/v3/expand?apiKey=#{api_key}&login=#{login}"
  end

  def expand(sort_url)
    request "#{@base_url}&shortUrl=#{sort_url}"
  end

  private
  def request(url)
    data = open(url, 'User-Agent' => 'rExpander v0.1').read
    JSON.parse(data)['data']['expand'][0]   rescue nil
  end
end


bl = BitLy.new(LOGIN, API_KEY)

url = bl.expand('http://bit.ly/dq8kWE') || (puts "!!! URL Error"; exit 1)

puts "Short URL:   #{url['short_url']}"
puts "Long URL:    #{url['long_url']}"
puts "Global Hash: #{url['global_hash']}"
puts "User Hash:   #{url['user_hash']}"

# Output:
# =======
# Short URL:   http://bit.ly/dq8kWE
# Long URL:    http://github.com/Yitsushi/ruby-examples
# Global Hash: aXqfUM
# User Hash:   dq8kWE
#
# Or use the bitly gem by philnash: http://github.com/philnash/bitly
#   $ gem install bitly
#   or
#   $ sudo gem install bitly
# It' a very nice gem for bit.ly
