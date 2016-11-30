require 'ox'

module RXT

  class Template
    def self.from_file(path)
      new(File.read(path), path)
    end

    def initialize(rxt_source, filename='(rxt)', lineno=1)
      @block = CleanBinding.get.eval(<<-END_SOURCE, filename, lineno-1)
        Proc.new do
          #{rxt_source}
        end
      END_SOURCE
    end

    def render(instance_variables={})
      dsl = DSL.new

      instance_variables.each do |name, value|
        dsl.instance_variable_set("@#{name}", value)
      end

      dsl.instance_eval(&@block)

      root = dsl.__root
      Ox.dump(root, with_xml: root.attributes.any?)
    end

    module CleanBinding
      def self.get
        binding
      end
    end
  end

  class DSL
    attr_reader :__root

    def initialize
      @__root = Ox::Document.new
      @__element_stack = [@__root]
    end

    def xml(attrs={})
      attrs.each do |key, value|
        @__root[key] = value
      end
    end

    def respond_to_missing?(method_name, include_private=false)
      true # responds to all methods
    end

    def method_missing(method_name, *args)
      elem = __make_element(method_name, *args)
      @__element_stack.last << elem
      @__element_stack.push(elem)

      yield if block_given?

      @__element_stack.pop
    end

    def __make_element(name, attributes_or_content={}, content=nil)
      if attributes_or_content.is_a?(Hash)
        attributes = attributes_or_content
      else
        attributes = {}
        content = attributes_or_content
      end

      Ox::Element.new(name.to_s).tap do |elem|
        attributes.each { |key, value| elem[key] = value }
        elem << content.to_s unless content.nil?
      end
    end
  end

end

