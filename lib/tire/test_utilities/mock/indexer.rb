module Tire
  module Indexing
    module ClassMethods
      def init_elasticsearch_index klass
        idx = Tire::Index.new klass.tire.index.name
        idx.delete
        idx.create mappings: klass.tire.mapping_to_hash, settings: klass.tire.settings
        idx.refresh        
      end      
    end
  end
  extend Indexing::ClassMethods
end