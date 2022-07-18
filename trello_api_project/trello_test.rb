require_relative 'trello'
require 'minitest/autorun'

class TrelloTest < Minitest::Test
  def test_reading_json_from_files_using_generic_method
    # skip
    pseudo_json_config = {"api_key"=>"xyz1732813213412", "name"=>"pomidor", "costam"=>"bo tak"}
    key = 'xyz1732813213412'
    read_json_config = FileWork.new(folder: '../po_prostu_files').read_file('tomato.json')
    parsed_json_config = JSON.parse(read_json_config)
    assert_equal pseudo_json_config, parsed_json_config
    assert_equal key, parsed_json_config['api_key']
  end

  def test_reading_config
    # skip
    config = FileWork.new(folder: '.').read_file('config.example.json')
    test_value = 'example'
    assert_equal test_value, JSON.parse(config)['test_value']
  end

  # Don't try this at home * testing outside request *
  def test_if_faraday_is_working
    # skip
    ddos_google = TrelloApiCommunicator.new
    assert_equal 200, ddos_google.ddos_google
  end

  def test_successfully_querying_trello
    # skip
    board = TrelloApiCommunicator.new.get_board
    assert_equal 200, board.status
  end

  def test_getting_zielony_board
    # skip
    board = TrelloApiCommunicator.new.get_board
    assert_equal 'admin', JSON.parse(board.body).first['memberType']
  end

  def test_getting_lists_from_board
    # skip
    lists_from_board = TrelloApiCommunicator.new.pull_lists_from_board()
    board_size = JSON.parse(lists_from_board.body).length
    assert_equal 200, lists_from_board.status
    assert_equal 4, board_size
  end

  def test_getting_cards_from_list
    # skip
    list_of_cards = TrelloApiCommunicator.new.pull_cards_from_list()
    assert_equal 200, list_of_cards.status
  end

  def test_creating_a_card_on_a_list
    # skip
    new_card = TrelloApiCommunicator.new.add_card_to_a_list()
    assert_equal 200, new_card.status
  end

  def test_delete_the_first_card_from_a_list
    # skip
    TrelloApiCommunicator.new.add_card_to_a_list()
    list_of_cards = JSON.parse(TrelloApiCommunicator.new.pull_cards_from_list.body)
    size_of_list = list_of_cards.length
    first_card_id = list_of_cards[0]['id']
    deletion = TrelloApiCommunicator.new.delete_card_from_a_list(first_card_id)
    size_of_list_after_deletion = JSON.parse(TrelloApiCommunicator.new.pull_cards_from_list.body).length
    assert_equal 200, deletion.status
    assert_equal size_of_list - 1, size_of_list_after_deletion
  end

  def test_delete_all_cards_on_a_list
    # skip
    5.times do
      TrelloApiCommunicator.new.add_card_to_a_list()
    end
    TrelloApiCommunicator.new.delete_all_cards_from_list
    size_of_list_after_deletion = JSON.parse(TrelloApiCommunicator.new.pull_cards_from_list.body).length
    assert_equal 0, size_of_list_after_deletion
  end

end