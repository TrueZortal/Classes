require 'json'
require 'faraday'
require_relative '../filework'

class TrelloApiCommunicator
  def initialize
    config = JSON.parse(FileWork.new(folder: '.').read_file('config.json'))
    @key = config['api_key']
    @token = config['api_token']
  end

  def ddos_google
    Faraday.get('https://www.google.com').status
  end

  def get_board(board: 'QQuJXFB7')
    Faraday.get("https://api.trello.com/1/boards/#{board}/memberships?key=#{@key}&token=#{@token}")
  end
end

