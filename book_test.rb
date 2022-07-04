require_relative 'book'
require 'minitest/autorun'

class BookTest < Minitest::Test
  def test_if_it_works
    assert Book.new.title('kekw') == 'kekw'
  end
  def test_if_numbers_work
    assert Book.new.metoda1(2,4,'Mateusz') == [6, 'Mateusz', 8]
  end
end

