require 'json'

class FileWork

  class FileError < StandardError
    puts "No such file exists"
  end

  attr_accessor :folder

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @folder = 'po_prostu_files'
  end

  def raw_output(input)
    input
  end

  def standard_input
    @input.gets
  end

  def standard_output(string)
    @output.puts string
  end

  def standard_input_output
    gotten_string = @input.gets
    @output.puts gotten_string
  end

  def read_file(file_name)
    begin
      IO.read("#{folder}/#{file_name}")
    rescue
      raise FileError
    end
  end

  def write_file(string, file_name)
    IO.write("#{folder}/#{file_name}",string)
  end

  def read_json(file_name)
    JSON.parse(read_file("#{file_name}.json"))
  end

  def write_json(hash, name)
    write_file(JSON.generate(hash), "#{name}.json")
  end

end

# FileWork.standard_io