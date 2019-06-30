
#  Avro::Builder.build_dsl(filename: File.join(Rails.root, 'app/schemas/view_text.rb'))
# Avro::Builder.build(filename: File.join(Rails.root, 'app/schemas/view_text.rb'))


dsl = Avro::Builder.build_dsl(filename: File.join(Rails.root, 'app/schemas/view_text.rb'))
pp dsl.as_schema.fields


# pass dsl object to converter that creates a swagger_schema -- make a big list of those
# pass it to swagger codegen to generate bindings and pass to swagger-blocks to make json



# env
# code sha
# app name
