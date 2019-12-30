# frozen_string_literal: true

module ApplicationHelper
  def flash_messages
    classes = {
      'notice' => '#00e676 green accent-3',
      'alert' => '#b71c1c red darken-4'
    }

    render 'layouts/flash_message', alert_classes: classes
  end
end
