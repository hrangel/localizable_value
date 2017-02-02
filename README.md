# LocalizableValue

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/localizable_value`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'localizable_value'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install localizable_value

Then, create tables:

    $ rake localizable:setup

Add to the controllers you want (e.g. ApplicationController)
```ruby
before_action :set_editor_config
before_action :set_localizable_pages

# Inplace Editor config
def set_editor_config
  @can_edit = false # or true
  @inplace_editing_mode = (@can_edit ? 'edit' : 'read')
end

# set pages

def set_localizable_pages
  @global_page = LocalizableValue::LocalizedPage.global_page

  route_control = controller_name ? controller_name : 'root'
  route_action = action_name ? action_name : 'home'
  @current_page = LocalizableValue::LocalizedPage.current_page(route_control, route_action)
end
```

Don't forget to add scripts

    //= require jquery
    //= require best_in_place
    //= require inplace_editing

    $(document).ready(function() {
      /* Activating Best In Place */
      jQuery(".best_in_place").best_in_place();
    });


## Usage

The exambple belows considers you are using @global_page and @current_page

```slim
- # editable h1
h1 = localized_value_string(@current_page, 'main-title', 'My Main Title')

- # read only h1
h1 = localized_value_string_read(@current_page, 'main-title', 'My Main Title')

- # editable text section
div.text = localized_value_text(@current_page, 'main-text', 'My Main Text with markdown')

- # others
= localized_value_element(page, key, default_value, label)
= localized_value_link(page, key, default_value, link)
= localized_value_link_attr(page, key, default_value, link_attrs)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/localizable_value. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

