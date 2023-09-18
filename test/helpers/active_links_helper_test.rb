require 'test_helper'

class ActiveLinksHelperTest < ActionView::TestCase
  test 'should create a link_to with an added class of active' do
    def current_page?(_link)
      true
    end
    expected = link_to('Home', root_path, class: 'active')
    actual = active_link_to('Home', root_path)
    assert_equal(
      expected, actual
    )
  end

  test 'should create a link_to without an added class of active' do
    def current_page?(_link)
      false
    end
    expected = link_to('Home', root_path)
    actual = active_link_to('Home', root_path)
    assert_equal(
      expected, actual
    )
  end

  test 'should create a link_to with an added class of active when using a block' do
    def current_page?(_link)
      true
    end
    expected = link_to('Home', root_path, class: 'active')
    actual = active_link_to(root_path) do
      'Home'
    end
    assert_equal(
      expected, actual
    )
  end

  test 'should create a link_to without an added class of active when using a block' do
    def current_page?(_link)
      false
    end
    expected = link_to('Home', root_path)
    actual = active_link_to(root_path) do
      'Home'
    end
    assert_equal(
      expected, actual
    )
  end

  test 'should create a link_to without an added class of active when using a block and options' do
    def current_page?(_link)
      false
    end
    expected = link_to('Home', root_path, id: 'home')
    actual = active_link_to(root_path, id: 'home') do
      'Home'
    end
    assert_equal(
      expected, actual
    )
  end
end
