module ActiveRecordPlaygroundRunner
  class Playground
    include Renderer
    include SeedsHelpers

    attr_reader :uuid, :name

    def initialize(name, &block)
      @uuid = SecureRandom.uuid
      @name = name
      @examples = []
      instance_exec(&block) if block
    end

    def schema(&block)
      @schema = block
    end

    def seeds(&block)
      @seeds = block
    end

    def models(&block)
      @models = block
    end

    def example(name, &block)
      @examples << Example.new(name, &block)
    end

    def setup
      render "Setup" do
        create_db
        establish_connection
        create_schema
        load_models
        run_seeds
        remove_connection
      end
      self
    end

    def run
      establish_connection
      set_logger
      run_examples
      remove_connection
      self
    end

    def destroy
      drop_db
      self
    end

    private

    def database_name
      "#{name.parameterize}-#{uuid}"
    end

    def drop_db
      system "dropdb #{database_name}"
    end

    def create_db
      system "createdb #{database_name}"
    end

    def create_schema
      ActiveRecord::Schema.define(version: 1, &@schema)
    rescue StandardError => e
      render "Error creating schema:" do
        puts e
      end
    end

    def load_models
      @models.call
    rescue StandardError => e
      render "Error loading models:" do
        puts e
      end
    end

    def run_seeds
      instance_exec(&@seeds)
    rescue StandardError => e
      render "Error running seeds:" do
        puts e
      end
    end

    def run_examples
      @examples.each(&:call)
    end

    def establish_connection
      ActiveRecord::Base.establish_connection(adapter: "postgresql", database: database_name)
    end

    def remove_connection
      ActiveRecord::Base.remove_connection
    end

    def set_logger
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end
  end
end
