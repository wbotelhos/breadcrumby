# Breadcrumby

[![Build Status](https://travis-ci.org/wbotelhos/breadcrumby.svg)](https://travis-ci.org/wbotelhos/breadcrumby)
[![Gem Version](https://badge.fury.io/rb/breadcrumby.svg)](https://badge.fury.io/rb/breadcrumby)

A solid Breadcrumb for Rails.
You do not need to dirty your controllers with a bunch of code.
Breadcrumby is a really relational breadcrumb.

## Install

Add the following code on your `Gemfile` and run `bundle install`:

```ruby
gem 'breadcrumby'
```

## Usage

With the following example of `ActiveRecord` relations:

```ruby
class School
  def show_path
    "/schools/#{id}"
  end
end
```

```ruby
class Course
  belongs_to :school

  def show_path
    "/courses/#{id}"
  end
end
```

Let's make it know about the breadcrumb path:

```ruby
class School
  breadcrumby

  def show_path
    "/schools/#{id}"
  end
end
```

Now school knows how to buid the breadcrumb but since it has no `path` it will be the last item.

So, we need to teach the Course class how to follow the path until School:

```ruby
class Course
  breadcrumby path: :school

  belongs_to :school

  def show_path
    "/courses/#{id}"
  end
end
```

Now Breadcrumby know how to fetch the path, using the `belongs_to` relation.

## View

With a instance of Course that has a relation with School, we can build the breadcrumb:

```ruby
<%= breadcrumby @course %>
```

And the result will be: `Home / School / Course`

## HTML

Breadcrumby uses the [semantic Breadcrumb HTML from Google](https://developers.google.com/search/docs/data-types/breadcrumbs):

```html
<ol class="breadcrumby" itemscope itemtype="http://schema.org/BreadcrumbList">
  <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
    <a itemprop="item" itemscope itemtype="http://schema.org/Thing" title="{name}" href="{show_path}">
      <span itemprop="name">{name}</span>
    </a>

    <meta content="1" itemprop="position">
  </li>
</ol>
```

- `name`: Fetched from method `name` of the model;
- `show_path`: Fetched from method `show_path` of the model.

> [I18n](I18n) configuration will always has priority over the model method.

## Home

As you could see, the Home crumb was generated automatically.
You can customize the name with `I18n` and the `show_path` will be `root_path` or `/` by default.

## Action

You can add one last path on breadcrumb to indicate the current action you are doing, like a edition:

```ruby
class School
  breadcrumby action: :edit
end
```

It generates a muted link on the end: `Home / School / Edition`

```ruby
<ol class="breadcrumby" itemscope itemtype="http://schema.org/BreadcrumbList">
  <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
    <a itemprop="item" itemscope itemtype="http://schema.org/Thing" title="Edition" href="javascript:void(0);">
      <span itemprop="name">Edition</span>
    </a>

    <meta content="3" itemprop="position">
  </li>
</ol>
```

All actions without `actions` option will try to follow `path` options.
If it is a new object, it will have no relation and will raise error.

### Custom Action Path

For actions like `new` where the object will be a `new_record`, we can customize the candidate to represent the self object.
This way we can build a minimum path, not just `Home / New`.
Let's say you have `Unit` on session and wants to set it on breadcrumb to say you are creating a `Course` on that unit of your school:

```ruby
class Course
  breadcrumby actions: {
    new: -> (view) { Unit.find(view.session[:current_school][:id])
  }
end
```

Now the `self` object will be the `new` call result and the output will be:

```ruby
Home / School / Unit / Courses / New
```

As you can see, the path will be completed from the `self` (new result) object.
Plus, since the new object is not `Unit`, we need a context. It will be related with original model with value of `index_path` as path:

```ruby
<a itemprop="item" itemscope="itemscope" itemtype="http://schema.org/Thing" title="List Courses" href="/courses">
  <span itemprop="name">Turmas</span>
</a>
```

Now it is possible to navigate to collection of items you want to create a new one.

## I18n

You can customize some attributes via I18n to be fast and global:

```yaml
en-US:
  breadcrumby:
    home:
      name: Home
      title: Home Page

    school:
      name: School
      title: "School: %{name}"

      actions:
        edit: # new / index / method_name ...
          name: Edition
          title: "Editing: %{name}"
```

- `actions`: Properties to change the actions crumb;
- `name`: The name of the crumb item;
- `title`: The title of the crum item with possibility of to use the name `%{name}`.

You can change the model key name, since the default search is the class method name:

```ruby
class School
  breadcrumby i18n_key: :school_key
end
```

And now use:

```yaml
en-US:
  breadcrumby:
    school_key:
      name: School
```

To make translations more generic just take it of inside the model name and it will be used for all models:

```yaml
en-US:
  breadcrumby:
    actions:
      edit:
        name: Edition
```

## Love it!

Via [PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=X8HEP2878NDEG&item_name=breadcrumby) or [Gittip](http://www.gittip.com/wbotelhos). Thanks! (:
