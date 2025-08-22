require "application_system_test_case"

class DemonSlayersTest < ApplicationSystemTestCase
  setup do
    @demon_slayer = demon_slayers(:one)
  end

  test "visiting the index" do
    visit demon_slayers_url
    assert_selector "h1", text: "Demon slayers"
  end

  test "should create demon slayer" do
    visit demon_slayers_url
    click_on "New demon slayer"

    fill_in "Kanji", with: @demon_slayer.kanji
    fill_in "Kanji meaning", with: @demon_slayer.kanji_meaning
    fill_in "Name", with: @demon_slayer.name
    fill_in "Power", with: @demon_slayer.power
    click_on "Create Demon slayer"

    assert_text "Demon slayer was successfully created"
    click_on "Back"
  end

  test "should update Demon slayer" do
    visit demon_slayer_url(@demon_slayer)
    click_on "Edit this demon slayer", match: :first

    fill_in "Kanji", with: @demon_slayer.kanji
    fill_in "Kanji meaning", with: @demon_slayer.kanji_meaning
    fill_in "Name", with: @demon_slayer.name
    fill_in "Power", with: @demon_slayer.power
    click_on "Update Demon slayer"

    assert_text "Demon slayer was successfully updated"
    click_on "Back"
  end

  test "should destroy Demon slayer" do
    visit demon_slayer_url(@demon_slayer)
    click_on "Destroy this demon slayer", match: :first

    assert_text "Demon slayer was successfully destroyed"
  end
end
