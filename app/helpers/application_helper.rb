# frozen_string_literal: true

module ApplicationHelper
  def flash_messages
    classes = {
      'notice' => 'success',
      'alert' => 'negative'
    }

    render 'layouts/flash_message', alert_classes: classes
  end
end
