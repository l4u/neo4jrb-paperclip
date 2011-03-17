Neo4jrb::Paperclip - Making Paperclip play nice with Neo4j.rb
================================================================

This gem is based on [mongoid-paperclip 0.0.4](https://github.com/meskyanichi/mongoid-paperclip).

As the title suggests: `Neo4jrb::Paperclip` makes it easy to hook up [Paperclip](https://github.com/thoughtbot/paperclip) with [Neo4j.rb](https://github.com/andreasronge/neo4j).

This is actually easier and faster to set up than when using Paperclip and the ActiveRecord ORM.
This example assumes you are using **Ruby on Rails 3** and **Bundler**. However it doesn't require either.


Setting it up
-------------

Make sure you are using JRuby. Simply define the `neo4jrb-paperclip` gem inside your `Gemfile`. Additionally, you can define the `aws-s3` gem if you want to upload your files to Amazon S3. *You do not need to explicitly define the `paperclip` gem itself, since this is handled by `neo4jrb-paperclip`.*

**Rails.root/Gemfile - Just define the following:**

    gem "neo4jrb-paperclip", :require => "neo4jrb_paperclip"
    gem "aws-s3",            :require => "aws/s3"

Next let's assume we have a User model and we want to allow our users to upload an avatar.

**Rails.root/app/models/user.rb - include the Neo4jrb::Paperclip module and invoke the provided class method**

    class User < Neo4j::Rails::Model
      include Neo4jrb::Paperclip

      has_neo4jrb_attached_file :avatar
    end


That's it
--------

That's all you have to do. Users can now upload avatars. Unlike ActiveRecord, Neo4j doesn't use migrations normally, so we don't need to define the Paperclip columns in a separate file. Invoking the `has_neo4jrb_attached_file` method will automatically define the necessary `:avatar` fields for you in the background.

Known issues
------------

File size returns 0 - [paperclip issue](https://github.com/thoughtbot/paperclip/issues/100)

Related Links
------------

* [mongoid-paperclip](https://github.com/meskyanichi/mongoid-paperclip)
* [Neo4j.rb](https://github.com/andreasronge/neo4j)
* [Paperclip](https://github.com/thoughtbot/paperclip) 
