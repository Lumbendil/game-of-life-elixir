defmodule GameOfLife do
  @moduledoc """
  Documentation for GameOfLife.
  """

  @doc """
  Run a single iteration
  """
  def iterate(seed) do
    GameOfLife.iterate(seed, length(seed) - 1, length(hd(seed)) - 1)
  end

  def glider(speed \\ 300) do
    GameOfLife.loop([[false, false, false, false, false, false, false, false],
[false, false, false, false, false, false, false, false],
[false, false, false, true, false, false, false, false],
[false, true, false, true, false, false, false, false],
[false, false, true, true, false, false, false, false],
[false, false, false, false, false, false, false, false],
[false, false, false, false, false, false, false, false],
[false, false, false, false, false, false, false, false],
[false, false, false, false, false, false, false, false]], speed)
  end

  def print(state) do
    IO.write("+");
    Enum.map(0..(length(hd(state)) - 1), fn _ -> IO.write("-") end);
    IO.write("+\n");
    Enum.map(state, fn row ->
      IO.write("|");
      Enum.map(row, fn cell ->
        IO.write(:stdio, case cell do
          true -> 'X'
          false -> ' '
        end);
      end);
      IO.write("|\n");
    end)
    IO.write("+");
    Enum.map(0..(length(hd(state)) - 1), fn _ -> IO.write("-") end);
    IO.write("+\n");
  end

  def loop(seed, speed) do
    print(seed);
    Process.sleep(speed);
    loop(iterate(seed), speed);
  end

  def iterate(seed, height, width) do
    Enum.map(0..height, fn i ->
      Enum.map(0..width, fn j -> stateFunction(get_cell(seed, i, j), neighbourFunction(seed, width, height, i, j)) end)
    end)
  end

  defp neighbourFunction(state, width, height, i, j) do
    firstRow = case i do
      0 -> height
      _ -> i - 1
    end;
    lastRow = case i do
      i when i == height -> 0
      _ -> i + 1
    end

    firstColumn = case j do
      0 -> width
      _ -> j - 1
    end

    lastColumn = case j do
      j when j == width -> 0
      _ -> j + 1
    end

    getNeighbours(state, firstRow, i, lastRow, firstColumn, j, lastColumn)
  end

  defp getNeighbours(state, firstRow, secondRow, thirdRow, firstColumn, secondColumn, thirdColumn) do
      get_integer(state, firstRow, firstColumn) + get_integer(state, secondRow, firstColumn) + get_integer(state, thirdRow, firstColumn) + get_integer(state, firstRow, secondColumn) + get_integer(state, thirdRow, secondColumn) + get_integer(state, firstRow, thirdColumn) + get_integer(state, secondRow, thirdColumn) + get_integer(state, thirdRow, thirdColumn)
  end

  defp get_integer(state, i, j) do
    boolean_to_integer(get_cell(state, i, j))
  end

  defp get_cell(state, i, j) do
    get_in(state, [Access.at(i), Access.at(j)])
  end

  defp boolean_to_integer(true), do: 1
  defp boolean_to_integer(false), do: 0

  defp stateFunction(_, neighboursAlive) when neighboursAlive < 2 do
    false
  end

  defp stateFunction(_, neighboursAlive) when neighboursAlive > 3 do
    false
  end

  defp stateFunction(false, neighboursAlive) when neighboursAlive == 3 do
    true
  end

  defp stateFunction(state, _) do
    state
  end
end
