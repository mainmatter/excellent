require 'simplabs/excellent/formatters/base'
require 'rubygems'

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
          				background: #faf834;
          			}

          			dd span.lineNumber {
          				background: #ccc;
          				font-weight: bold;
          				padding: 3px;
          				display: inline-block;
          				margin: 0 10px 0 0;
          			}

          			dd span.number {
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

                .af { color:#00C }
                .an { color:#007 }
                .at { color:#f08 }
                .av { color:#700 }
                .aw { color:#C00 }
                .bi { color:#509; font-weight:bold }
                .c  { color:#888; }

                .ch { color:#04D }
                .ch .k { color:#04D }
                .ch .dl { color:#039 }

                .cl { color:#B06; font-weight:bold }
                .co { color:#036; font-weight:bold }
                .cr { color:#0A0 }
                .cv { color:#369 }
                .df { color:#099; font-weight:bold }
                .di { color:#088; font-weight:bold }
                .dl { color:black }
                .do { color:#970 }
                .dt { color:#34b }
                .ds { color:#D42; font-weight:bold }
                .e  { color:#666; font-weight:bold }
                .en { color:#800; font-weight:bold }
                .er { color:#F00; background-color:#FAA }
                .ex { color:#F00; font-weight:bold }
                .fl { color:#60E; font-weight:bold }
                .fu { color:#06B; font-weight:bold }
                .gv { color:#d70; font-weight:bold }
                .hx { color:#058; font-weight:bold }
                .i  { color:#00D; font-weight:bold }
                .ic { color:#B44; font-weight:bold }

                .il { background: #eee; color: black }
                .il .il { background: #ddd }
                .il .il .il { background: #ccc }
                .il .idl { font-weight: bold; color: #777 }

                .im { color:#f00; }
                .in { color:#B2B; font-weight:bold }
                .iv { color:#33B }
                .la { color:#970; font-weight:bold }
                .lv { color:#963 }
                .oc { color:#40E; font-weight:bold }
                .of { color:#000; font-weight:bold }
                .op { }
                .pc { color:#038; font-weight:bold }
                .pd { color:#369; font-weight:bold }
                .pp { color:#579; }
                .ps { color:#00C; font-weight: bold; }
                .pt { color:#349; font-weight:bold }
                .r, .kw  { color:#080; font-weight:bold }

                .ke { color: #808; }
                .ke .dl { color: #606; }
                .ke .ch { color: #80f; }
                .vl { color: #088; }

                .rx { background-color:#fff0ff }
                .rx .k { color:#808 }
                .rx .dl { color:#404 }
                .rx .mod { color:#C2C }
                .rx .fu  { color:#404; font-weight: bold }

                .s { background-color:#fff0f0; color: #D20; }
                .s .s { background-color:#ffe0e0 }
                .s .s  .s { background-color:#ffd0d0 }
                .s .k { }
                .s .ch { color: #b0b; }
                .s .dl { color: #710; }

                .sh { background-color:#f0fff0; color:#2B2 }
                .sh .k { }
                .sh .dl { color:#161 }

                .sy { color:#A60 }
                .sy .k { color:#A60 }
                .sy .dl { color:#630 }

                .ta { color:#070 }
                .tf { color:#070; font-weight:bold }
                .ts { color:#D70; font-weight:bold }
                .ty { color:#339; font-weight:bold }
                .v  { color:#036 }
                .xt { color:#444 }

                .ins { background: #afa; }
                .del { background: #faa; }
                .chg { color: #aaf; background: #007; }
                .head { color: #f8f; background: #505 }

                .ins .ins { color: #080; font-weight:bold }
                .del .del { color: #800; font-weight:bold }
                .chg .chg { color: #66f; }
                .head .head { color: #f4f; }
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
          <dd>
            <span class="lineNumber">Line <span class="number">{{line_number}}</span></span>{{message}}
          </dd>
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
