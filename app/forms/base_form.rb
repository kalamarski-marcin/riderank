class BaseForm

  attr_reader :errors, :model, :params

  def initialize(model, params={})
    @model = model
    @params = params
    @errors = {}
    @logger = ::Logger.new("#{Rails.root}/log/form.log")
  end

  def validate
    schema
    result = @schema.call(@params)
    @errors = result.errors
    result.success?
  end

  def save
    raise StandardError, 'An abstract method'
  end

  def schema
    raise StandardError, 'An abstract method'
  end

  def method_missing(method)
    method = method.to_s
    if method.include? 'error?'
      key = method.slice(0..-8).to_sym
      return @errors.key?(key)
    elsif method.include? 'error'
      key = method.slice(0..-7).to_sym
      return @errors[key] if @errors.key? key
    else
      key = method.to_sym
      return @params[key] if @params.key? key
      ''
    end
    raise ArgumentError
  end

  def sth_went_wrong(&block)
    @errors = { critical: 'Something went wrong. Please contact us.' }
    block.call if block_given?
  end
end
