# Rails::Patch::Json::Encode

This is a monkey patch for Rails in order to speed up its json encoding, and to draw people's attention to this [Rails issue](https://github.com/rails/rails/issues/9212). 

For full details please read Jason Hutchen's [blog post](http://devblog.agworld.com.au/post/42586025923/the-performance-of-to-json-in-rails-sucks-and-theres).

All credits goes to [Jason Hutchens](https://github.com/jasonhutchens) for discovering the issue and provide the code for this monkey patch.

## Usage

First, go to your Rails console and type:

    data = Hash.new
    key = 'aaa'
    1000.times { data[key.succ!] = data.keys }
    1000 * Benchmark.realtime { data.to_json }
    
See how Rails performs before the patch.

Then bundle install this gem with a fast JSON encoding gem in your Rails' Gemfile.

    gem 'rails-patch-json-encode'
    gem 'oj'
    
In this case I choose the oj gem, but you can [choose a json gem that multi_json supports](https://github.com/intridea/multi_json#supported-json-engines).

Rails should now use the faster decoder. Now restart your console again and rerun the test to see how the performance changes.

The actual performance boost on real data will probably be less than that.

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
