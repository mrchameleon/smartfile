# SmartFile

A ruby client wrapper for the [SmartFile](http://smartfile.com) file platform.
SmartFile has free developer accounts with 1 user, 100GB storage, and 200GB monthly transfer!

Works with Ruby 1.9 and likely 2.0 (Has not been tested)
This is an early version and the interface might change so use at your own risk.
As of version 0.1, only whoami and ping paths have been tested! I added some others to play around with for the next gem version.

## API Paths Currently Implemented

  - Path - Info, as :path_info
  - Path - Data, as :path_data
  - Path - Search, as :path_search
  - Ping, as :ping
  - Whoami, as :whoami
  - Session, as :session

## Setup:

Instructions assume you are using Rails, but Rails is not required. 

Create the file config/smartfile.yml:

    key: your smartfile apikey here
    pass: your smartfile password here

Create the file config/initializers:

    api_config_path = "#{Rails.root}/config/smartfile.yml"
    if File.exists?(api_config_path)
      SMARTFILE_CONFIG = YAML.load_file(api_config_path)
    end

## Usage:

    call = SmartFile.new
    params = {:attribute => "query"}
    call.setup(:whoami, format = "json")
    
    # regular get
    result = call.get(params)
    
    # regular post
    result = call.post(params)
    
    # get or post with full response object
    result = call.get(params, true)
    puts result
    => "#<Net::HTTPOK 200 OK readbody=true>"
    puts result.body
    '{"ping": "pong"}'


## Valid Return Formats: 
  - json
  - json-p
  - json-t
  - html
  - xhtml
  - txt 
  - xml

## (Optional) Use [Nokogiri](http://nokogiri.org/) to parse XML formatted results:

    doc = Nokogiri::XML(result.body)

Then, to search for nodes existing in the result body by XML node name:

    full_node = doc.css('nodeName')

To get the value of a node:

    attr = doc.search('attr').text