simplabs-excellent
==================

Excellent is a source code analysis gem. It detects commonly regarded bad code snippets like empty rescue blocks etc. It combines roodi (http://github.com/martinjandrews/roodi), most checks of reek (http://github.com/kevinrutherford/reek), flog (http://github.com/seattlerb/flog) and also adds some Rails specific checks.

Installation
------------

    gem sources -a http://gems.github.com
    sudo gem install simplabs-excellent

Example
-------

To analyse all the models in your Rails application, just do

    excellent app/models

in your RAILS_ROOT.

Contribute
----------

If you want to contribute, just fork the repo. Also I would appretiate suggestions for more checks (especially Rails specific checks) - simply open a new issue: http://github.com/simplabs/excellent/issues.

Author
------

Copyright (c) 2009 Marco Otte-Witte (http://simplabs.com), released under the MIT license.

Excellent is based on roodi (http://github.com/martinjandrews/roodi), reek (http://github.com/kevinrutherford/reek) and flog (http://github.com/seattlerb/flog).
