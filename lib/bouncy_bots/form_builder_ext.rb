module BouncyBots
  module FormBuilderExt
    def bounce_field(options = {})
      ActionView::Helpers::InstanceTag.new(object_name, @template.controller.bounce_field, self, options.delete(:object)).to_input_field_tag("text", options)
    end

    def bounce_label(text = nil, options = {})
      ActionView::Helpers::InstanceTag.new(object_name, @template.controller.bounce_field, self, options.delete(:object)).to_label_tag(text, options)
    end
  end
end

if defined? ActionView
  ActionView::Helpers::FormBuilder.send(:include, BouncyBots::FormBuilderExt)
end

