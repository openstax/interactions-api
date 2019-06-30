Avro::Builder::DSL.load_paths.clear
Avro::Builder.add_load_path(File.join(Rails.root, 'app/schemas'))
