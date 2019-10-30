Excellent
=========

[![Build Status](https://travis-ci.org/simplabs/excellent.png)](https://travis-ci.org/simplabs/excellent)

Excellent **finds the nasty lines in your code**. It implements a comprehensive set of checks for possibly
buggy parts of your app that would **otherwise make it into your repo and eventually to the production server**.

See the API documentation at [http://docs.github.com/simplabs/excellent](http://docs.github.com/simplabs/excellent)
and the Wiki at [http://wiki.github.com/simplabs/excellent](http://wiki.github.com/simplabs/excellent).

Installation
------------

Simply install it with Ruby Gems:

```bash
gem install excellent
```

Example
-------

Assuming you have the following class definition,

```ruby
class ShoppingBasket < ActiveRecord::Base

  def initialize(items = [])
    self.items = items
  end

end
````

Then Excellent will report the problems in this piece of code:

```bash
$ excellent shopping_basket.rb

  Excellent result:

  test.rb
    * Line   1: ShoppingBasket does not validate any attributes.
    * Line   1: ShoppingBasket defines initialize method.
    * Line   1: ShoppingBasket does not specify attr_accessible.

  Found 3 warnings.
```

To analyse all the models in your Rails application, just do:

```bash
excellent app/models
```

in your `RAILS_ROOT`. You can also invoke analysation through the `Simplabs::Excellent::Runner` class.
Excellent can also produce HTML output. To get a formatted HTML report, just specify `html:<filename>`:

```bash
excellent -o out.html app/models
```

You can also use Excellent in a Rake task:

```ruby
require 'simplabs/excellent/rake'

Simplabs::Excellent::Rake::ExcellentTask.new(:excellent) do |t|
  t.html  = 'doc/excellent.html' # optional, if you don't specify html, output will be written to $stdout
  t.paths = %w(app lib)
end
```

Configuration
-------------

You can configure which checks to run and which thresholds etc. to use. Simply place a `.excellent.yml` in the
root directory of you project (the directory that you will be starting excellent from). You can enable/disable
by using the check name as hash key and specifying a truthy/falsy value:

```yaml
AbcMetricMethodCheck: true
AssignmentInConditionalCheck: false
```

By default all checks are enabled so you would usually only switch off certain checks you're not interested in.
Some checks also take cofngigurations like thresholds, patterns etc. You can configure those by simply defining
nested hashes in the YAML:

```yaml
ClassLineCountCheck:
  threshold: 500
MethodNameCheck:
  pattern: '^[a-z].*'
```

This would for example only report classes with more than 500 lines and require that all method names start
with a lower case letter.

You can get a list of the enabled checks and their configurations by running:

```bash
excellent --checks
```

You can also place a `.excellent.yml` file in your home directory that contains default settings you always
want to apply. Settings in project-specific configuration files will override these default settings.

Excellent now also supports ignore paths. Simple place a `.excellentignore` file in the root directory of
your project and these directories will be ignored, e.g.:

```
vendor
some/specific/file.rb
```

Static analysis
---------------

A few words regarding static code analysis: Static code analysis tools like Excellent can never really
understand the code. They just search for patterns that *might* inidicate problematic code. The word **might**
really has to be stressed here since static analysis will usually return a reasonable number of false
positives. For example, there might be pretty good reasons for empty +rescue+ blocks that suppress all
errors (Excellent itself does it). So, don't try and code with the aim of passing Excellent with zero warnings.
That will most likely make your code a mess. Instead use Excellent as a helper to find **potentially**
problematic code early.

Author
------

Copyright (c) 2009-2018 simplabs GmbH ([http://simplabs.com](http://simplabs.com)) and contributors, released under the MIT license.

Excellent was inspired by roodi ([https://github.com/martinjandrews/roodi](https://github.com/martinjandrews/roodi)), reek ([https://github.com/troessner/reek](https://github.com/troessner/reek)) and flog ([https://github.com/seattlerb/flog](https://github.com/seattlerb/flog)).
