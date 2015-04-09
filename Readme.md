# riotjs-rails <a href="http://badge.fury.io/rb/riotjs-rails"><img src="https://badge.fury.io/rb/riotjs-rails@2x.png" alt="Gem Version" height="18"></a>

### About

Rails 3.1+ asset-pipeline gem to provide riot.js

### Prerequisite

You should install [nodejs](https://nodejs.org/) for riot.js compilation work

### Setup

Have in your Gemfile:

```ruby
gem 'riotjs-rails'
```

And, have in your application.js manifest:

```js
//= require riot
```

### Usage

You can create a tag by including a file in `app/assets/javascripts`, this file must end with `.tag`.

The name of the file will be used as the tag name, so let's say we want to create a `timer.tag`.

All we need to do is create a file called `app/assets/javascripts/timer.tag`:

```jsx
<timer>

  <p>Seconds Elapsed: { time }</p>

  this.time = opts.start || 0

  this.tick = function() {
    this.update({ time: ++this.time })
  }

  var timer = setInterval(this.tick.bind(this), 1000)

  this.on("unmount", function() {
    clearInterval(timer)
  })

</timer>
```

After, we mount the tag using `riot.mount('timer')` where we want to use it.

For instance in your `application.js`:

```js
//= require jquery
//= require jquery_ujs
//= require riot
//= require_tree .

$(function() {
  riot.mount('timer');
});
```

And then include the tag adding `<timer></timer>` in your html.

You should see `Seconds Elapsed: 0` changing the number after each second.

## Contributing

Contributions are welcome, please follow [GitHub Flow](https://guides.github.com/introduction/flow/index.html)
