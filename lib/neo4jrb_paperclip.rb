# encoding: utf-8

begin
  require "paperclip"
rescue LoadError
  puts "Neo4jrb::Paperclip requires that you install the Paperclip gem."
  exit
end

##
# Use Neo4j's logger.
module Paperclip
  class << self
    def logger
      Neo4j::Config[:logger]
    end
  end
end


##
# The Neo4jrb::Paperclip extension
# Makes Paperclip play nice with the Neo4j Models
#
# Example:
#
#  class User < 
#    include Neo4jrb::Paperclip
#
#    has_neo4jrb_attached_file :avatar
#  end
#
# The above example is all you need to do. This will load the Paperclip library into the User model
# and add the "has_neo4jrb_attached_file" class method. Provide this method with the same values as you would
# when using "vanilla Paperclip". The first parameter is a symbol [:field] and the second parameter is a hash of options [options = {}].
#
# Unlike Paperclip for ActiveRecord, since MongoDB does not use "schema" or "migrations", Neo4jrb::Paperclip automatically adds the neccesary "fields"
# to your Model (MongoDB collection) when you invoke the "#has_neo4jrb_attached_file" method. When you invoke "has_neo4jrb_attached_file :avatar" it will
# automatially add the following fields:
#
#  field :avatar_file_name,    :type => String
#  field :avatar_content_type, :type => String
#  field :avatar_file_size,    :type => Fixnum
#  field :avatar_updated_at,   :type => DateTime
#
module Neo4jrb 
  module Paperclip

    ##
    # Extends the model with the defined Class methods
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      ##
      # Adds Neo4jrb::Paperclip's "#has_neo4jrb_attached_file" class method to the model
      # which includes Paperclip and Paperclip::Glue in to the model. Additionally
      # it'll also add the required fields for Paperclip since MongoDB is schemaless and doesn't
      # have migrations.
      def has_neo4jrb_attached_file(field, options = {})

        ##
        # Include Paperclip and Paperclip::Glue for compatibility
        include ::Paperclip
        include ::Paperclip::Glue

        ##
        # Invoke Paperclip's #has_attached_file method and passes in the
        # arguments specified by the user that invoked Neo4jrb::Paperclip#has_neo4jrb_attached_file
        has_attached_file(field, options)

        ##
        # Define the necessary collection fields in Neo4jrb for Paperclip
        property :"#{field}_file_name",    :type => String
        property :"#{field}_content_type", :type => String
        property :"#{field}_file_size",    :type => Fixnum 
        property :"#{field}_updated_at",   :type => DateTime
      end

      ##
      # This method is deprecated
      def has_attached_file(field, options = {})
        raise "Neo4jrb::Paperclip#has_attached_file is deprecated, " +
          "Use 'has_neo4jrb_attached_file' instead"
      end
    end
  end
end
