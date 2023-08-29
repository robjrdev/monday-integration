class Lead < ApplicationRecord

  before_save :to_monday_crm

  def to_monday_crm
      api_key = ENV['monday_api_key']

      
      query = 'mutation ($myItemName: String!, $columnVals: JSON!) { create_item (board_id: 1813019309, group_id: topics item_name: $myItemName, column_values: $columnVals) { id } }'

      vars = {
        myItemName: self.name,
        columnVals: ({
          "lead_email": { "text": "#{self.email}",  "email": "#{self.email}" },
          "lead_phone": { "text": "#{self.phone}",  "phone": "#{self.phone}", "countryShortName": "US" },
          "text5": "#{self.location}",
        }).to_json
      }

      url = 'https://api.monday.com/v2'
      headers = {
        'Authorization' => api_key,
        'Content-Type' => 'application/json',     
      }
      body = {
      query: query,
      variables: vars
      }
      response = HTTParty.post(url, headers: headers, body: body.to_json)
      if response.code == 200
        parsed_response = JSON.parse(response.body)
        puts JSON.pretty_generate(parsed_response)
      else
        puts "Request failed with status code: #{response.code}"
      end
  end
end

