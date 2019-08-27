require_relative './test'

class NexmoMessagesTest < Nexmo::Test
  def messages
    Nexmo::Messages.new(config)
  end

  def message_id
    '00A0B0C0'
  end

  def date
    'YYYY-MM-DD'
  end

  def test_get_method
    uri = 'https://rest.nexmo.com/search/message'

    params = {id: message_id}

    request_stub = stub_request(:get, uri).with(query: params.merge(api_key_and_secret)).to_return(response)

    assert_equal response_object, messages.get(message_id)
    assert_requested request_stub
  end

  def test_search_method_with_ids
    uri = 'https://rest.nexmo.com/search/messages'

    id1, id2, id3 = '00A0B0C0', '00A0B0C1', '00A0B0C2'

    values = [['ids', id1], ['ids', id2], ['ids', id3], ['api_key', api_key], ['api_secret', api_secret]]

    query = WebMock::Util::QueryMapper.values_to_query(values)

    request_stub = stub_request(:get, uri).with(query: query).to_return(response)

    assert_equal response_object, messages.search(ids: [id1, id2, id3])
    assert_requested request_stub
  end

  def test_search_method_with_recipient_and_date
    uri = 'https://rest.nexmo.com/search/messages'

    params = {date: date, to: msisdn}

    request_stub = stub_request(:get, uri).with(query: params.merge(api_key_and_secret)).to_return(response)

    assert_equal response_object, messages.search(params)
    assert_requested request_stub
  end

  def test_rejections_method
    uri = 'https://rest.nexmo.com/search/rejections'

    params = {date: date, to: msisdn}

    request_stub = stub_request(:get, uri).with(query: params.merge(api_key_and_secret)).to_return(response)

    assert_equal response_object, messages.rejections(params)
    assert_requested request_stub
  end
end
