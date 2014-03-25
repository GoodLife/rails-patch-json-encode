# Rails::Patch::Json::Encode

This is a monkey patch for Rails in order to speed up its JSON encoding, and to draw people's attention to this [Rails issue](https://github.com/rails/rails/issues/9212). 

For full details please read Jason Hutchens' [blog post](http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres).

All credits goes to [Jason Hutchens](https://github.com/jasonhutchens) for discovering the issue and providing the code for this monkey patch.

## Installation

First, go to your Rails console and type:

    data = Hash.new
    key = 'aaa'
    1000.times { data[key.succ!] = data.keys }
    1000 * Benchmark.realtime { data.to_json }
    
See how Rails performs before the patch.

Second, bundle install this gem with a fast JSON encoding gem in your Rails' Gemfile.

    gem 'rails-patch-json-encode'
    gem 'oj'
    
In this case I choose the oj gem, but you can [choose a json-encoder gem that multi_json supports](https://github.com/intridea/multi_json#supported-json-engines).

Last, there are two levels of patch available. You have to choose one and call it explictly:

* `Rails::Patch::Json::Encode.patch_base_classes` patches all Ruby base classes.
* `Rails::Patch::Json::Encode.patch_renderers` patches Rails' ActionController::Renderers only. This is for those who had issue with the JSON gem, as patching base classes cause infinite recursive loop. 

Place one of them in Rails' initializers like config/initializers/rails_patch_json_encode.rb, and Rails should now use the faster encoder.

## Benchmark

For console benchmark comparison, restart console after the above installation. Call `Rails::Patch::Json::Encode.patch_base_classes` in console, then re-run the test to see how the performance changes.

The actual performance boost on real-world applications will probably be less than that. For one of my page I see the rendering time dropped by 25%.

## Warning

This gem may break your app. **Test your app**. I am not sure if this is production ready.

## What's with the name

This is just a temporal monkey patch, and a monkey patch isn't supposed to have a fancy name.

## Related reading

* Jason Hutchen's [blog post](http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres)
* [Rails issue](https://github.com/rails/rails/issues/9212)
* [Current refactoring done by chancancode](https://github.com/rails/rails/pull/12183) trying to address this issue.
* [A pull-request related to this](https://github.com/intridea/multi_json/pull/138) about JSON and Rails trying to patch the same method* 
* [Original issue and fix that resulted in this issue](https://rails.lighthouseapp.com/projects/8994/tickets/4890)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
