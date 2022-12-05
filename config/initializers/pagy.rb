require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 25
Pagy::DEFAULT[:page_param] = :page
Pagy::DEFAULT[:overflow] = :empty_page
Pagy::DEFAULT.freeze
