require 'rails_helper'

RSpec.describe 'avro swaggerization' do

  let(:swaggered_class) do
    Class.new do
      include Swagger::Blocks
      include OpenStax::Swagger::SwaggerBlocksExtensions

      swagger_root do
        key :swagger, '2.0'
      end
    end
  end

  context 'crazy_avro_record' do
    let(:crazy_avro_record_dsl) do
      Avro::Builder.build_dsl(filename: File.join(Rails.root, "spec/support/crazy_avro_record.rb"))
    end

    before { define(crazy_avro_record_dsl) }

    it 'defines CrazyRecord' do
      expect(swagger_hash).to have_key(:CrazyRecord)
    end

    it 'defines required UUIDs' do
      expect(swagger_hash[:CrazyRecord][:properties]).to match hash_including({
        anonymous_id: hash_including({
          type: :string,
          format: :uuid,
        }),
      })
    end

    it 'defines optional UUIDs' do
      expect(swagger_hash[:CrazyRecord][:properties]).to match hash_including({
        fun_uuid: hash_including({
          type: :string,
          format: :uuid,
        }),
      })
    end

    it 'defines required fields' do
      expect(swagger_hash[:CrazyRecord][:required]).to contain_exactly(
        "anonymous_id"
      )
    end
  end

  def define(dsl)
    AvroRecordSwaggerizer.new(dsl).define_in(klass: swaggered_class)
  end

  def swagger_hash
    Swagger::Blocks.build_root_json([swaggered_class])[:definitions]
  end

end
