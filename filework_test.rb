require_relative 'filework'
require 'minitest/autorun'

class FileworkTest < Minitest::Test
  def test_outputs_input
    assert_equal 'tomato', FileWork.new.raw_output('tomato')
  end

  def test_interface_returns_its_input_kek
    value = 'tym razem nie tomato bo Dawid nie chcial kek'
    test_input = StringIO.new(value)
    assert_equal value, FileWork.new(input: test_input).standard_input
  end

  def test_interface_returns_with_no_input
    test_input = StringIO.new
    assert_nil FileWork.new(input: test_input).standard_input
  end

  def test_interface_returns_its_input_to_std_output
    value = 'test outputu'
    test_output = StringIO.new
    FileWork.new(output: test_output).standard_output(value)
    assert_equal test_output.string, <<~OUTPUT
      #{value}
    OUTPUT
  end

  def test_a_value_from_standard_input_goes_out_in_the_standard_output
    value = 'jakis string ktory wrzucam'
    test_input = StringIO.new(value)
    test_output = StringIO.new
    FileWork.new(input: test_input, output: test_output).standard_input_output
    assert_equal test_output.string, <<~OUTPUT
      #{value}
    OUTPUT
  end

  def test_reading_files
    testowy_file = File.path("po_prostu_files/filework_tekst")
    actual = IO.read(testowy_file)
    assert_equal 'Tekst', actual
  end

  def test_reading_files_via_class
    file_name = "filework_tekst"
    actual = FileWork.new.read_file(file_name)
    assert_equal 'Tekst', actual
  end

  def test_reading_an_absolutely_unexisting_file_throws_file_error
    assert_raises FileWork::FileError do
      file_name = "pomidor"
      FileWork.new.read_file(file_name)
    end
  end

  def test_writing_files
    # skip
    value = 'This is a test string haha xDDDDDDDDd'
    file_name = 'test_writing_files_file'
    file_path = 'po_prostu_files/'+file_name
    File.delete(file_path)
    FileWork.new.write_file(value, file_name)
    assert_equal value, IO.read(file_path)
  end

  def test_overwritting_files
    # skip
    original_value = 'This is a test string haha xDDDDDDDDd'
    file_name = 'test_overwritting_file'
    file_path = 'po_prostu_files/'+file_name
    File.delete(file_path)
    FileWork.new.write_file(original_value, file_name)
    overwritten_value = 'this shit got overwritten kek'
    FileWork.new.write_file(overwritten_value, file_name)
    assert_equal overwritten_value, IO.read(file_path)
  end

  def test_appending_to_files
    skip
  end

  def test_reading_json_from_files_using_generic_method
    # skip
    pseudo_json_config = {"api_key"=>"xyz1732813213412", "name"=>"pomidor", "costam"=>"bo tak"}
    key = 'xyz1732813213412'
    read_json_config = FileWork.new.read_file('tomato.json')
    parsed_json_config = JSON.parse(read_json_config)
    assert_equal pseudo_json_config, parsed_json_config
    assert_equal key, parsed_json_config['api_key']
  end

  def test_reading_json_using_dedicated_method
    # skip
    key = 'xyz1732813213412'
    name = 'pomidor'
    read_json_config = FileWork.new.read_json('tomato')
    assert_equal key, read_json_config['api_key']
    assert_equal name, read_json_config['name']
  end

  def test_writing_json_using_dedicated_method
    # skip
    test_hash = {
      api_key: "testapi77777777777",
      name: "tez_pomidor",
      costam: "tez_costam"
    }
    FileWork.new.write_json(test_hash, 'test_config_json')
    assert_equal JSON.parse(JSON.generate(test_hash)), JSON.parse(IO.read('po_prostu_files/test_config_json.json'))
  end
end