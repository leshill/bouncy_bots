$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bouncy_bots/form_builder_ext'

module BouncyBots
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def bounce_bots(field, to, filter_opts = {})
      before_filter :bounce_bot, filter_opts

      cattr_accessor :bounce_to
      cattr_accessor :bounce_field
      bouncy_settings(field, to)
    end

    protected

    def bouncy_settings(field, to)
      self.bounce_field = field
      self.bounce_to = to
    end
  end

  protected

  def bounce_bot
    bot_check = find_bounce_field(params)
    redirect_to(send(bounce_to)) and return false unless bot_check.blank?
    true
  end

  def find_bounce_field(hash)
    if hash.has_key?(bounce_field)
      return hash.delete(bounce_field)
    else
      hash.values.each do |value|
        if value.kind_of?(Hash)
          bounce = find_bounce_field(value)
          return bounce unless bounce.nil?
        end
      end
      return nil
    end
  end
end

