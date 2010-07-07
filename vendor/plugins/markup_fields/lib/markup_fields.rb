require "bluecloth"

module MarkupFields
  
  def self.included(base)
    base.extend(ClassMethods)
    # sets up default of stripping tags for all fields
    base.send(:init_markup_fields)
  end

  module ClassMethods
    
    def init_markup_fields
      before_validation :sanitize_fields
      
      write_inheritable_attribute(:markup_fields_options, {
        :fields => {},
        :except => [],
      })
      class_inheritable_reader :markup_fields_options
      class_inheritable_writer :markup_fields_options
      
      include MarkupFields::InstanceMethods
    end
    
    # This is a plugin specific to the needs of SingleForest. It is based on xss_terminate but uses the sanitize plugin.
    # The default behavior is to parse `field` from a markup language into html. All other text fields are stripped of html.
    # Arguments
    # <tt>field</tt> - Sting/Symbol containing a single field name.
    # <tt>options</tt> - Hash containing a list of options, see Options
    # Options
    # <tt>:raw</tt> - field to dump <tt>field</tt> before parsing, set to false to disable
    # <tt>:parser</tt> - Parser to use, defaults to escaping all html.
    # <tt>:santize_options</tt> - (none functional) Options to pass to the html santizer. Defaults to Sanitize::Config::BASIC.
    # <tt>:extensions</tt> - Enable SingleForest smiley and link parser extensions. Enabled by default. (Not used yet)
    def markup_field(field, options = {})
      #Because people are morons.
      options = { 
        :type => "#{field}_type".to_sym, 
        :raw => "#{field}_raw".to_sym,
        :parser => :markdown, 
        #:sanitize_options => Sanitize::Config::BASIC,
        :extensions => true,
      }.update options
      markup_fields_options[:fields][field.to_sym] = options
      markup_fields_options[:except] << options[:raw] if options[:raw].to_sym == "#{field}_raw".to_sym
    end
    
    # By default all string and text fields are cleared of html before they are saved to the database. 
    # (Fields flagged with markup_field are skipped.)
    # This method accepts a list of fields to ignore when clearing html.
    # Use :all to disable html cleaning.
    def skip_sanitize(array)
      markup_fields_options[:except] << array
      markup_fields_options[:except].flatten!
    end
    
    def markup_parser(str, parser)
      return puts "Warning: Nil value in markup_parser" if str.nil?
      case parser
      when :markdown
        html = BlueCloth.new(str)
        html = html.to_html
        Sanitize.clean(html, Sanitize::Config::BASIC)
        html
      when :html
        Sanitize.clean(str, Sanitize::Config::BASIC)
        str
      else
        CGI::escapeHTML(str)
      end
    end
  end
  
  module InstanceMethods
    def sanitize_fields 
      puts "sanitize_fields"
      if markup_fields_options.nil?
        puts "ERROR, Can't retreive options for markup_fields" 
        return
      end
      if markup_fields_options[:except] != :all 
        self.class.columns.each do |column|
          next unless (column.type == :string || column.type == :text)
          name = column.name.to_sym
          value = self[name]
          next if value.nil? || !value.is_a?(String)
          next if markup_fields_options[:fields].include? name 
          next if markup_fields_options[:except].include? name
          # Disabling sanitize
          #self[name] = Sanitize.clean(self[name])
          puts "cleaning field: #{name}"
          self[name] = CGI::escapeHTML(self[name])
        end
      end
      markup_fields_options[:fields].each {|k, v|
        markup_field(k, v) 
      }
    end
    
    def markup_field(field, options)
      puts "Running markup with #{field}, #{options.inspect}"
      self[field] = self.class.markup_parser(self[options[:raw]], options[:parser])
    end
  end
end