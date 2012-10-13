# encoding: utf-8

$KCODE = 'utf8'
require 'rubygems'
require 'twitter'
require 'fileutils'
require 'erb'
require 'keys'

EXTENSION  = "png"
VOTES      = "votes/*/*.#{EXTENSION}"
DONE       = "done"
VOTE_TYPES = {
  'za'       => 'Јас <%= mp %> гласав ЗА #цензура #член16',
  'protiv'   => 'Јас <%= mp %> гласав ПРОТИВ #цензура #член16',
  'vozdrzan' => 'Јас <%= mp %> НЕ гласав ПРОТИВ #цензура #член16'
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
    image       = images[rand(images.length)]
    image_parts = image.split('/')
    vote_type   = image_parts[1]
    template    = VOTE_TYPES[vote_type]
    mp          = image_parts.last.gsub(".#{EXTENSION}", "")

    message = ERB.new(template).result(binding)
    tweet(message, image)
    FileUtils.mv(image, DONE)
  end
end

random_tweet
