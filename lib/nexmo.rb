# frozen_string_literal: true
require 'zeitwerk'

module Nexmo
  class ZeitwerkInflector < Zeitwerk::Inflector
    def camelize(basename, _abspath)
      case basename
      when 'http', 'json', 'jwt', 'sms', 'tfa'
        basename.upcase
      when 'call_dtmf'
        'CallDTMF'
      when 'version'
        'VERSION'
      else
        super
      end
    end
  end

  private_constant :ZeitwerkInflector

  loader = Zeitwerk::Loader.new
  loader.tag = File.basename(__FILE__, '.rb')
  loader.inflector = ZeitwerkInflector.new
  loader.push_dir(__dir__)
  loader.setup

  def self.config
    @config ||= Config.new
  end

  def self.configure(&block)
    block.call(config)
  end
end
