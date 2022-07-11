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

  def test_getting_zielony_board
    # skip
    board = TrelloApiCommunicator.new.get_board
    assert_equal 'admin', JSON.parse(board.body).first['memberType']
  end

  def test_successfully_querying_trello
    # skip
    board = TrelloApiCommunicator.new.get_board
    assert_equal 200, board.status
  end

end