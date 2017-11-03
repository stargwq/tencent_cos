# frozen_string_literal: true
require 'yaml'

module TencentCos
  class Config
    ATTRS = %i[secret_id secret_key app_id region duration_seconds bucket_name request_retry timeout].freeze
    attr_accessor(*ATTRS)

    def initialize(options = nil?)
      if options.nil?
        options = YAML.load_file(File.expand_path("tencent_cos.yml"))
      end

      ATTRS.each do |attr|
        send("#{attr}=", options[attr.to_sym])
      end
  
      # default values
      self.request_retry ||= 3
      self.timeout ||= 3
    end

    def host
      "http://#{bucket_name}-#{app_id}.cos.#{region}.myqcloud.com"
    end
  end
end
