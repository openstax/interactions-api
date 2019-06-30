import File.join(Rails.root, 'app/schemas/common')

namespace "org.openstax"

record :view_text do
  required :anonymous_id, :fixed, size: 16, logical_type: :uuid
  # required :app_id, :fixed, size: 16
  # required :at, :timestamp
  # required :book_version_id, :string
  # required :page_version_id, :string
  # optional :first_content_element_id, :string
  # optional :last_content_element_id, :string
end
