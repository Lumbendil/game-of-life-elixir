defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "Still life Square" do
    assert GameOfLife.iterate([[false, false, false, false], [false, true, true, false], [false, true, true, false], [false, false, false, false]]) == [[false, false, false, false], [false, true, true, false], [false, true, true, false], [false, false, false, false]]
  end
  test "Blinker" do
    assert GameOfLife.iterate([[false, false, false, false, false],
[false, false, true, false, false],
[false, false, true, false, false],
[false, false, true, false, false],
[false, false, false, false, false]]) == [[false, false, false, false, false],
[false, false, false, false, false],
[false, true, true, true, false],
[false, false, false, false, false],
[false, false, false, false, false]]
  end
end
