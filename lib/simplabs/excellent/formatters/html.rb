require 'simplabs/excellent/formatters/base'

module Simplabs

  module Excellent

    module Formatters

      class Html < Base #:nodoc:

        def initialize(stream = $stdout)
          super
        end

        def start
          @stream.write(HEADER_TEMPLATE)
        end

        def file(filename)
          @stream.write(START_FIlE_TAMPLATE.sub('{{filename}}', filename))
          yield self
          @stream.write(END_FIlE_TAMPLATE)
        end

        def warning(warning)
          @stream.write(WARNING_TEMPLATE.sub('{{line_number}}', warning.line_number.to_s).sub('{{message}}', warning.message))
        end

        def end
          @stream.write(FOOTER_TEMPLATE)
        end

        HEADER_TEMPLATE = <<-END
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
          <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
          	<head>
            	<title>Excellent result</title>
            	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            	<style type="text/css">
            		body {
              		margin: 0;
              		padding: 0;
              		background: #fff;
              		font-size: 80%;
          				font-family: "Lucida Grande", Helvetica, sans-serif;
            		}

          			#header {
            			background: #ccc;
          				color: #000;
          				height: 4em;
          			}

          			#header h1 {
          				font-size: 1.8em;
          				margin: 0px 10px 0px 10px;
          				padding: 10px;
          				position: absolute;
          			}

          			#results {
          				margin: 0px 10px 5px;
          			}

          			dt {
          				background: #ccc;
          				padding: 5px;
          				font-weight: bold;
          				margin: 30px 0 0 0;
          			}

          			dd {
          				margin: 5px 0px 5px 20px;
          			}

          			dd.warning {
          				background: #faf834;
          			}

          			dd.warning span.lineNumber {
          				background: #ccc;
          				font-weight: bold;
          				padding: 3px;
          				display: inline-block;
          				margin: 0 10px 0 0;
          			}

          			dd.warning span.number {
          				width: 30px;
          				text-align: right;
          				display: inline-block;
          			}

                #footer {
                  margin: 20px 0 20px 0;
                  padding: 5px;
                  text-align: center;
                }

                #footer a {
                  color: #000;
                  background-color: #ddd;
                  text-decoration: none;
                  padding: 0 2px 0 2px;
                }

                #footer a:active, #footer a:hover {
                  color: #fff;
                  background-color: #222;
                }
            	</style>
          	</head>
          	<body>
          		<div id="header">
           			<div id="label">
             			<h1>Excellent result</h1>
           			</div>
          		</div>
          		<div id="results">
        END

        START_FIlE_TAMPLATE = <<-END
          <div class="file">
     				<dl>
     				  <dt>{{filename}}</dt>
        END

        END_FIlE_TAMPLATE = <<-END
            </dl>
  			  </div>
        END

        WARNING_TEMPLATE = <<-END
          <dd class="warning"><span class="lineNumber">Line <span class="number">{{line_number}}</span></span>{{message}}</dd>
        END

        FOOTER_TEMPLATE = <<-END
              </div>
              <div id="footer">
                <a href="http://github.com/simplabs/excellent" title="Excellent at github">Excellent</a> by <a href="http://simplabs.com" title="simplabs">simplabs</a>
              </div>
      	    </body>
          </html>
        END

      end

    end

  end

end
