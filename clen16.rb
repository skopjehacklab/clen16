# encoding: utf-8

require 'rubygems'
require 'twitter'
require 'fileutils'
require 'keys'

VOTES      = "votes/*/**"
DONE       = "done"
VOTE_TYPES = {
  'za'       => 'Јас гласав ЗА #цензура #член16',
  'protiv'   => 'Јас гласав ПРОТИВ #цензура #член16',
  'vozdrzan' => 'Јас НЕ гласав ПРОТИВ #цензура #член16'
}

Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
end

def tweet(message, image)
  Twitter.update_with_media(message, File.new(image))
end

def random_tweet
  images = Dir.glob(VOTES)

  if images.empty?
    puts 'No more votes'
  else
    image     = images[rand(images.length)]
    vote_type = image.split('/')[1]
    message   = VOTE_TYPES[vote_type]

    tweet(message, image)
    FileUtils.mv(image, DONE)
  end
end

random_tweet
