require 'avro_field_swaggerizer'

class AvroRecordSwaggerizer

  attr_reader :dsl

  def initialize(dsl)
    @dsl = dsl
  end

  def name
    @dsl.as_schema.name.camelcase.to_sym
  end

  def fields
    @dsl.as_schema.fields
  end

  def field_swaggerizers
    fields.map{|field| AvroFieldSwaggerizer.new(field)}
  end

  def define_in(klass:)
    swaggerizer = self
    required_field_names = []

    klass.class_eval do
      swagger_schema swaggerizer.name do
        swaggerizer.field_swaggerizers.each do |field_swaggerizer|
          field_swaggerizer.define_in(self)
          required_field_names.push(field_swaggerizer.name) if field_swaggerizer.required?
        end

        key :required, required_field_names
      end
    end
  end

end
