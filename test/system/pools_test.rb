require "application_system_test_case"

class PoolsTest < ApplicationSystemTestCase
  setup do
    @pool = pools(:one)
  end

  test "visiting the index" do
    visit pools_url
    assert_selector "h1", text: "Pools"
  end

  test "creating a Pool" do
    visit pools_url
    click_on "New Pool"

    fill_in "Season", with: @pool.season
    fill_in "Total points", with: @pool.total_points
    fill_in "User", with: @pool.user_id
    fill_in "Week", with: @pool.week
    click_on "Create Pool"

    assert_text "Pool was successfully created"
    click_on "Back"
  end

  test "updating a Pool" do
    visit pools_url
    click_on "Edit", match: :first

    fill_in "Season", with: @pool.season
    fill_in "Total points", with: @pool.total_points
    fill_in "User", with: @pool.user_id
    fill_in "Week", with: @pool.week
    click_on "Update Pool"

    assert_text "Pool was successfully updated"
    click_on "Back"
  end

  test "destroying a Pool" do
    visit pools_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pool was successfully destroyed"
  end
end
