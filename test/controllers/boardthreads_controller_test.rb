require 'test_helper'

class BoardthreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @boardthread = boardthreads(:one)
  end

  test "should get index" do
    get boardthreads_url
    assert_response :success
  end

  test "should get new" do
    get new_boardthread_url
    assert_response :success
  end

  test "should create boardthread" do
    assert_difference('Boardthread.count') do
      post boardthreads_url, params: { boardthread: { title: @boardthread.title } }
    end

    assert_redirected_to boardthread_url(Boardthread.last)
  end

  test "should show boardthread" do
    get boardthread_url(@boardthread)
    assert_response :success
  end

  test "should get edit" do
    get edit_boardthread_url(@boardthread)
    assert_response :success
  end

  test "should update boardthread" do
    patch boardthread_url(@boardthread), params: { boardthread: { title: @boardthread.title } }
    assert_redirected_to boardthread_url(@boardthread)
  end

  test "should destroy boardthread" do
    assert_difference('Boardthread.count', -1) do
      delete boardthread_url(@boardthread)
    end

    assert_redirected_to boardthreads_url
  end
end
