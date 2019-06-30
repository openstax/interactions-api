class AvroSwaggerSchemas

  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  SCHEMA_FILES = {
    "app/schemas" => %w(
      view_text.rb
    )
  }

  def self.load
    SCHEMA_FILES.each do |relative_path, filenames|
      filenames.each do |filename|
        full_filename = File.join(Rails.root, relative_path, filename)
        dsl = Avro::Builder.build_dsl(filename: full_filename)

        AvroRecordSwaggerizer.new(dsl).define_in(klass: self)
      end
    end
  end

end
