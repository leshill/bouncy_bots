$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bouncy_bots/form_builder_ext'

module BouncyBots
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def bounce_bots(to, *field_path)
      before_filter :bounce_bot

      cattr_accessor :bounce_to
      cattr_accessor :bounce_field
      cattr_accessor :bounce_field_parents
      bouncy_settings(to, *field_path)
    end

    protected

    def bouncy_settings(to, *field_path)
      self.bounce_to = to
      self.bounce_field = field_path.last
      self.bounce_field_parents = field_path[0..-2]
    end
  end

  protected

  def bounce_bot
    bot_check = bounce_field_parents.inject(params) {|p, parent| p[parent] || {}}.delete(bounce_field)
    redirect_to(send(bounce_to)) and return false unless bot_check.blank?
    true
  end
end

