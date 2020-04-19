# frozen_string_literal: true

require 'faraday'
require 'json'

class FcmRuby
  def initialize(api_token, project_id)
    @api_token = api_token
    @project_id = project_id
  end

  # See https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages for message structure
  # message = { data: {...}, notification: {...}, token: 'fcm_token', android: {...}, apns: {...} }
  # FcmRuby.new(key, project_id).send(message)
  def send(message)
    if message.is_a?(Array)
      send_to_all(message)
    else
      body = JSON.fast_generate(message: message)
      headers = {
        content_type: 'application/json',
        authorization: authorization
      }
      Faraday.post(end_point, body, headers)
    end
  end

  private

  def send_to_all(messages)
    request_string = messages.map do |message|
      sub_message = sub_message(message)
      body = ''
      body += "--#{boundary_mark}\r\n"
      body += "Content-Type: application/http\r\n"
      body += "Content-Length: #{sub_message.length}\r\n"
      body += "Content-Transfer-Encoding: binary\r\n"
      body += "Authorization: #{authorization}\r\n"
      body += "\r\n"
      body += sub_message
      body
    end.join("\r\n") + "\r\n--#{boundary_mark}--\r\n"

    headers = {
      content_type: "multipart/mixed; boundary=#{boundary_mark}",
      content_length: request_string.length.to_s
    }

    request_io = StringIO.new(request_string)
    body_io = Faraday::UploadIO.new(request_io, 'text/plain')

    res = Faraday.post(batch_end_point, body_io, headers)
    request_io.close
    res
  end

  def sub_message(message)
    body = JSON.fast_generate(message: message)
    sub_message = ''
    sub_message += "POST #{end_point_path} HTTP/1.1\r\n"
    sub_message += "Content-Length: #{body.length}\r\n"
    sub_message += "Content-Type: application/json; charset=UTF-8 \r\n"
    sub_message += "accept: application/json\r\n"
    sub_message += "\r\n"
    sub_message += body
    sub_message
  end

  def boundary_mark
    '__END_OF_PART__'
  end

  def batch_end_point
    'https://fcm.googleapis.com/batch'
  end

  def end_point
    @end_point ||= "https://fcm.googleapis.com#{end_point_path}"
  end

  def end_point_path
    "/v1/projects/#{@project_id}/messages:send"
  end

  def authorization
    @authorization ||= "Bearer #{@api_token}"
  end
end
