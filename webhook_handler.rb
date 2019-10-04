# frozen_string_literal: true

require 'sinatra'
require 'csv'
require 'json'
require 'excon'

set :port, 80

access_token = File.open('access_token.txt').read

get '/' do
  'hello world'
end

post '/' do
  # puts "params: #{params}"
  # request.body.rewind
  # request_body = request.body.read
  # puts "request_body: #{request_body}"
  response = Excon.post('https://api.github.com/repos/quzhi1/WebhookPlayground/issues',
                        headers: {
                          'Authorization' => 'token ' + access_token,
                          'Content-Type' => 'application/json',
                          'User-Agent' => 'WebhookPlayground'
                        },
                        body: '{
                           "title": "Echo",
                           "body": "This is a issue echoing"
                         }')
  puts "response: #{response.inspect}"
  'OK'
end
