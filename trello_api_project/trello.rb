require 'json'
require 'faraday'
require_relative '../filework'

class TrelloApiCommunicator
  def initialize
    config = JSON.parse(FileWork.new(folder: '.').read_file('config.json'))
    @key = config['api_key']
    @token = config['api_token']
    @auth = "key=#{@key}&token=#{@token}"
    @address = "https://api.trello.com/1"
  end

  def ddos_google
    Faraday.get('https://www.google.com').status
  end

  def get_board(board: 'QQuJXFB7')
    Faraday.get("#{@address}/boards/#{board}/memberships?#{@auth}")
  end

  def pull_lists_from_board(board: 'QQuJXFB7')
    Faraday.get("#{@address}/boards/#{board}/lists?#{@auth}")
  end

  def pull_cards_from_list(list: '62b0a89f9e8ba22e91a1d6be')
    Faraday.get("#{@address}/lists/#{list}/cards?#{@auth}")
  end

  def add_card_to_a_list(list_id: '62b0a89f9e8ba22e91a1d6be', card_name: 'Testowa etykieta rubiego hue')
    Faraday.post("#{@address}/cards?#{@auth}&idList=#{list_id}&name=#{card_name}")
  end

  def delete_card_from_a_list(card_name)
    Faraday.delete("#{@address}/cards/#{card_name}?#{@auth}")
  end

  def delete_all_cards_from_list(list: '62b0a89f9e8ba22e91a1d6be')
    list_of_cards = JSON.parse(pull_cards_from_list(list: list).body)
    size_of_list = list_of_cards.length
    size_of_list.times do |x|
      first_card_id = list_of_cards[x]['id']
      delete_card_from_a_list(first_card_id)
    end
  end
end

