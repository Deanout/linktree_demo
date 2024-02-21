# frozen_string_literal: true

require 'application_system_test_case'

class ThemesTest < ApplicationSystemTestCase
  setup do
    @theme = themes(:one)
  end

  test 'visiting the index' do
    visit themes_url
    assert_selector 'h1', text: 'Themes'
  end

  test 'should create theme' do
    visit themes_url
    click_on 'New theme'

    fill_in 'Css value', with: @theme.css_value
    fill_in 'Name', with: @theme.name
    check 'Premium' if @theme.premium
    fill_in 'Theme type', with: @theme.theme_type
    click_on 'Create Theme'

    assert_text 'Theme was successfully created'
    click_on 'Back'
  end

  test 'should update Theme' do
    visit theme_url(@theme)
    click_on 'Edit this theme', match: :first

    fill_in 'Css value', with: @theme.css_value
    fill_in 'Name', with: @theme.name
    check 'Premium' if @theme.premium
    fill_in 'Theme type', with: @theme.theme_type
    click_on 'Update Theme'

    assert_text 'Theme was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Theme' do
    visit theme_url(@theme)
    click_on 'Destroy this theme', match: :first

    assert_text 'Theme was successfully destroyed'
  end
end
