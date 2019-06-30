class AvroFieldSwaggerizer

  attr_reader :field

  def initialize(field)
    @field = field
  end

  def name
    @field.name.underscore.to_sym
  end

  def doc
    @field.doc
  end

  def required?
    !optional?
  end

  def optional?
    field.type.type_sym == :union &&
    field.type.schemas.map(&:type_sym).include?(:null)
  end

  def get_type_info(field_type)
    if field_type.type_sym == :union
      sub_types = field_type.schemas

      non_null_sub_types = sub_types.dup.reject{|type| type.type_sym == :null}

      if non_null_sub_types.size == 1
        return get_type_info(non_null_sub_types[0])
      else
        raise "Cannot handle multiple non-null types"
      end
    else
      case field_type.logical_type&.to_sym
      when :uuid
        type = :string
        format = :uuid
      when :fixed
        raise "For fixed types, need to specify a logical type"
      else
        case field_type.type_sym
        when :string
          type = :string
        else
          raise "Unhandled type"
        end
      end
    end

    {
      type: type,
      format: format
    }.compact
  end


  def define_in(context)
    me = self

    context.property name do
      if me.doc.present?
        key :description, me.doc
      end

      type_info = me.get_type_info(me.field.type)

      key :type, type_info[:type] if type_info.has_key?(:type)
      key :format, type_info[:format] if type_info.has_key?(:format)
    end
  end

end
