defmodule AuctionWeb.Api.ItemView do
  use AuctionWeb, :view

  # When we are showing all of the items (index), instead of enumerating them or whatever, we define the function to handle one item (the second one)
  # and we can use Phoenix's render_one.
  def render("index.json", %{items: items }) do
    %{data: render_many(items, __MODULE__, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, __MODULE__, "item_with_bids.json")}
  end

  def render("item_with_bids.json", %{item: item}) do
    %{
      type: "item",
      id: item.id,
      title: item.title,
      description: item.description,
      ends_at: item.ends_at,
      bids: render_many(item.bids, AuctionWeb.Api.BidView, "bid.json")
    }
  end
end
