module GoogleAdword::ErrorHandling
  extend ActiveSupport::Concern
  included do
    Rack::Utils::SYMBOL_TO_STATUS_CODE.keys.each do |status|
      define_singleton_method("handle_as_#{status}") do |*args|
        rescue_from args.first do |error|
          if args.last.is_a? Hash
            opts = args.last
            error_code = opts[:error_code]
          end
          if Rails.env.development?
            p "-------inspection------"
            p error.inspect
            p "-----------------------"
            p "-------backtrace-------"
            p error.backtrace
            p "-----------------------"
          end
          render json: {message: error.message, status: error_code}
        end
      end
    end
  end
end
