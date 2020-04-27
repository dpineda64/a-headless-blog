defmodule HeadlessBlogWeb.InlineSvgCache do
  use GenServer

  alias PhoenixInlineSvg.Helpers

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def svg_image(conn, svg, collection \\ nil) do
    svg_name = "#{collection}/#{svg}"

    case lookup(svg_name) do
      {:ok, data} ->
        data

      {:error} ->
        data = svg_path(conn, svg, collection)
        insert(svg_name, data)
        data
    end
  end

  defp lookup(name) do
    GenServer.call(__MODULE__, {:lookup, name})
  end

  def insert(name, data) do
    GenServer.cast(__MODULE__, {:insert, name, data})
  end

  def init(_) do
    :ets.new(:svg_image, [:named_table, read_concurrency: true])
    {:ok, %{}}
  end

  def handle_call({:lookup, name}, _from, state) do
    data =
      case ets_lookup(name) do
        [{^name, data}] -> {:ok, data}
        [] -> {:error}
      end

    {:reply, data, state}
  end

  def handle_cast({:insert, name, data}, state) do
    :ets.insert(:svg_image, {name, data})
    {:noreply, state}
  end

  defp ets_lookup(name) do
    :ets.lookup(:svg_image, name)
  end

  defp svg_path(conn, svg_name, collection) when not is_nil(collection),
    do: Helpers.svg_image(conn, svg_name, collection)

  defp svg_path(conn, svg_name, nil), do: Helpers.svg_image(conn, svg_name)
end
