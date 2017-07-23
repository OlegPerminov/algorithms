require 'minitest/autorun'
require 'task5.rb'

class TestPersonTree < Minitest::Test

  def setup
    @tree = PersonTree.new
    @person1 = Person.new(20, 100, 150, 60)
    @person2 = Person.new(10, 101, 160, 70)
    @person3 = Person.new(30, 110, 170, 70)
    @person4 = Person.new(5, 110, 170, 70)
    @person5 = Person.new(15, 110, 170, 70)
    @person6 = Person.new(25, 110, 170, 70)
    @person7 = Person.new(40, 110, 170, 70)
    @person8 = Person.new(1, 110, 170, 70)
    @person9 = Person.new(7, 110, 170, 70)
    @person10 = Person.new(20, 220, 170, 70)
    @person11 = Person.new(40, 220, 170, 70)
    @person12 = Person.new(40, 220, 170, 70)
    @tree.insert(@person1.age, @person1)
    @tree.insert(@person2.age, @person2)
    @tree.insert(@person3.age, @person3)
    @tree.insert(@person4.age, @person4)
    @tree.insert(@person5.age, @person5)
    @tree.insert(@person6.age, @person6)
    @tree.insert(@person7.age, @person7)
    @tree.insert(@person8.age, @person8)
    @tree.insert(@person9.age, @person9)
    @tree.insert(@person10.age, @person10)
    @tree.insert(@person11.age, @person11)
    @tree.insert(@person12.age, @person12)
  end

  def test_find_number_of_persons_by_single_value
    assert_equal(@tree.find(15).persons.size, 1)
    assert_equal(@tree.find(20).persons.size, 2)
    assert_equal(@tree.find(40).persons.size, 3)
  end

  def test_find_persons_by_single_value
    assert_equal(@tree.find(15).persons, Set.new << @person5)
    assert_equal(@tree.find(20).persons, [@person1, @person10].to_set)
    assert_equal(@tree.find(40).persons, [@person7, @person11, @person12].to_set)
  end

  def test_find_number_of_nodes_by_range
    assert_equal(@tree.find_by_range(15..30).size, 4)
    assert_equal(@tree.find_by_range(15..25).size, 3)
    assert_equal(@tree.find_by_range(1..15).size, 5)
    # Max range at tree
    assert_equal(@tree.find_by_range(1..40).size, 9)
    # Max range at tree (values 0 and 41 are abscent at tree)
    assert_equal(@tree.find_by_range(0..41).size, 9)
  end

  def test_find_vsplit_value
    # Find vsplit at range with nodes 1-5-7
    assert_equal(@tree.find_vsplit(1..7).data, 5)
    # Find vsplit at range with nodes 1-5-7-10-15
    assert_equal(@tree.find_vsplit(1..15).data, 10)
    # Find vsplit at range with nodes 15-10'-20-30'-25 (x' - skip nodes at range)
    assert_equal(@tree.find_vsplit(15..25).data, 20)
    # Find vsplit at range with nodes 25-30-40
    assert_equal(@tree.find_vsplit(25..40).data, 30)
  end
end
