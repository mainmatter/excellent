simplabs-excellent
==================

Excellent is a source code analysis gem. It detects commonly regarded bad code snippets
like empty rescue blocks etc.

Installation
------------

    gem sources -a http://gems.github.com
    sudo gem install simplabs-excellent

Example
-------

To analyse all the models in your Rails application, just do

    excellent "app/models/**/*.rb"

in your RAILS_ROOT.

Acknowledgements
----------------

Excellent is based on roodi by Marty Andrews. However, it will get more functionaliy than roodi in the future.

Author
------

Copyright (c) 2009 Marco Otte-Witte (http://simplabs.com), released under the MIT license
