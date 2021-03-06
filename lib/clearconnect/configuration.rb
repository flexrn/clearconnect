module ClearConnect
  class Configuration
    attr_accessor \
      :username,
      :password,
      :site_name,
      :session,
      :format

    def initialize
      @username = nil
      @password = nil
      @site_name = nil
      @format = :json
      @session = false
      @endpoints = nil
    end

    def site_name=(site_name)
      @site_name = site_name
    end

    #--
    # do endpoints need to be set at any point?
    #++
    def endpoints
      @endpoints ||= {
        clearconnect: "https://ctms.contingenttalentmanagement.com/#{@site_name}/clearConnect/2_0/index.cfm",
        wsdl: "https://media.healthcaresource.com/public/#{@site_name}/WSDL/staffingWebService.wsdl"
      }
    end

    #--
    # I don't think this is necessary
    #++
    def endpoints=(options = {})
      if options.nil? 
        @endpoints
      end
      @endpoints = options
    end
  end

  class << self
    attr_accessor :configuration
  end

  # Configure clearconnect someplace sensible,
  # like config/initializers/clearconnect.rb
  #
  # @example
  #   ClearConnect.configure do |c|
  #     c.username = 'username'
  #     c.password = 'password'
  #     c.sitename = 'sitename'
  #   end

  def self.configure
    self.configuration ||= Configuration.new
    if block_given?
      yield configuration
    end
  end
end
