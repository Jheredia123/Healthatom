require "test_helper"

class DemonSlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @demon_slayer = demon_slayers(:one)
  end

  test "should get index" do
    get demon_slayers_url
    assert_response :success
  end

  test "should get new" do
    get new_demon_slayer_url
    assert_response :success
  end

  test "should create demon_slayer" do
    assert_difference("DemonSlayer.count") do
      post demon_slayers_url, params: { demon_slayer: { kanji: @demon_slayer.kanji, kanji_meaning: @demon_slayer.kanji_meaning, name: @demon_slayer.name, power: @demon_slayer.power } }
    end

    assert_redirected_to demon_slayer_url(DemonSlayer.last)
  end

  test "should show demon_slayer" do
    get demon_slayer_url(@demon_slayer)
    assert_response :success
  end

  test "should get edit" do
    get edit_demon_slayer_url(@demon_slayer)
    assert_response :success
  end

  test "should update demon_slayer" do
    patch demon_slayer_url(@demon_slayer), params: { demon_slayer: { kanji: @demon_slayer.kanji, kanji_meaning: @demon_slayer.kanji_meaning, name: @demon_slayer.name, power: @demon_slayer.power } }
    assert_redirected_to demon_slayer_url(@demon_slayer)
  end

  test "should destroy demon_slayer" do
    assert_difference("DemonSlayer.count", -1) do
      delete demon_slayer_url(@demon_slayer)
    end

    assert_redirected_to demon_slayers_url
  end
end
