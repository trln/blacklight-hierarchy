# frozen_string_literal: true

module Blacklight::HierarchyHelper
  def facet_toggle_button(field_name, described_by)
    aria_label = I18n.t(
      "blacklight.hierarchy.#{field_name}_toggle_aria_label",
      default: :'blacklight.hierarchy.toggle_aria_label'
    )

    # For Rails 5.2 support all options must be symbols.  See https://github.com/rails/rails/issues/39813
    tag.button(:'aria-expanded' => 'false',
                :'aria-label' => aria_label,
                :'aria-describedby' => described_by,
                class: 'toggle-handle') do
      tag.span(Blacklight::Hierarchy::Engine.config.closed_icon, :'aria-hidden' => 'true', class: 'closed') +
      tag.span(Blacklight::Hierarchy::Engine.config.opened_icon, :'aria-hidden' => 'true', class: 'opened')
    end
  end

  # --------------------------------------------------------------------------------------------------------------------------------
  # below are methods pertaining to the "rotate" notion where you may want to look at the same tree data organized another way
  # --------------------------------------------------------------------------------------------------------------------------------

  def facet_after(prefix, order)
    orders = blacklight_config.facet_display[:hierarchy][prefix]
    orders[orders.index(order) + 1] || orders.first
  end
end
