I18n.translations || (I18n.translations = {});
I18n.translations["en"] = I18n.extend((I18n.translations["en"] || {}), {"activerecord":{"errors":{"messages":{"record_invalid":"Validation failed: %{errors}","restrict_dependent_destroy":{"has_many":"Cannot delete record because dependent %{record} exist","has_one":"Cannot delete record because a dependent %{record} exists"}}}},"client":{"confirm":{"product_not_exits":"Product does not exist, redirect to Home page ?"}},"controller":{"order":{"approve_success":"You have successfully appreved, an email has been sent to the customer to inform them","not_found":"Order not found","rejecte_success":"You have successfully rejected, an email has been sent to the customer to inform them"},"session":{"invalid_em_pw":"Invalid email/password","login_success":"Login Success","login_w_admin":"Success with admin","login_w_user":"Success with user","logout":"Success Logout","not_permission":"you do not have permission to this action"}},"date":{"abbr_day_names":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"abbr_month_names":[null,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"day_names":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"formats":{"default":"%Y-%m-%d","long":"%B %d, %Y","short":"%b %d"},"month_names":[null,"January","February","March","April","May","June","July","August","September","October","November","December"],"order":["year","month","day"]},"datetime":{"distance_in_words":{"about_x_hours":{"one":"about 1 hour","other":"about %{count} hours"},"about_x_months":{"one":"about 1 month","other":"about %{count} months"},"about_x_years":{"one":"about 1 year","other":"about %{count} years"},"almost_x_years":{"one":"almost 1 year","other":"almost %{count} years"},"half_a_minute":"half a minute","less_than_x_minutes":{"one":"less than a minute","other":"less than %{count} minutes"},"less_than_x_seconds":{"one":"less than 1 second","other":"less than %{count} seconds"},"over_x_years":{"one":"over 1 year","other":"over %{count} years"},"x_days":{"one":"1 day","other":"%{count} days"},"x_minutes":{"one":"1 minute","other":"%{count} minutes"},"x_months":{"one":"1 month","other":"%{count} months"},"x_seconds":{"one":"1 second","other":"%{count} seconds"}},"prompts":{"day":"Day","hour":"Hour","minute":"Minute","month":"Month","second":"Seconds","year":"Year"}},"errors":{"array?":"must be an array","attr?":"is missing","bool?":"must be boolean","connection_refused":"Oops! Failed to connect to the Web Console middleware.\nPlease make sure a rails development server is running.\n","date?":"must be a date","date_time?":"must be a date time","decimal?":"must be a decimal","empty?":"must be empty","eql?":"must be equal to %{left}","even?":"must be even","excluded_from?":{"arg":{"default":"must not be one of: %{list}","range":"must not be one of: %{list_left} - %{list_right}"}},"excludes?":"must not include %{value}","exclusion?":"must not be one of: %{list}","false?":"must be false","filled?":"must be filled","float?":"must be a float","format":"%{attribute} %{message}","format?":"is in invalid format","gt?":"must be greater than %{num}","gteq?":"must be greater than or equal to %{num}","hash?":"must be a hash","included_in?":{"arg":{"default":"must be one of: %{list}","range":"must be one of: %{list_left} - %{list_right}"}},"includes?":"must include %{value}","inclusion?":"must be one of: %{list}","int?":"must be an integer","key?":"is missing","lt?":"must be less than %{num}","lteq?":"must be less than or equal to %{num}","max_size?":"size cannot be greater than %{num}","messages":{"accepted":"must be accepted","blank":"can't be blank","confirmation":"doesn't match %{attribute}","empty":"can't be empty","equal_to":"must be equal to %{count}","even":"must be even","exclusion":"is reserved","greater_than":"must be greater than %{count}","greater_than_or_equal_to":"must be greater than or equal to %{count}","in_between":"must be in between %{min} and %{max}","inclusion":"is not included in the list","invalid":"is invalid","less_than":"must be less than %{count}","less_than_or_equal_to":"must be less than or equal to %{count}","model_invalid":"Validation failed: %{errors}","not_a_number":"is not a number","not_an_integer":"must be an integer","odd":"must be odd","other_than":"must be other than %{count}","present":"must be blank","required":"must exist","spoofed_media_type":"has contents that are not what they are reported to be","taken":"has already been taken","too_long":{"one":"is too long (maximum is 1 character)","other":"is too long (maximum is %{count} characters)"},"too_short":{"one":"is too short (minimum is 1 character)","other":"is too short (minimum is %{count} characters)"},"wrong_length":{"one":"is the wrong length (should be 1 character)","other":"is the wrong length (should be %{count} characters)"}},"min_size?":"size cannot be less than %{num}","none?":"cannot be defined","not_eql?":"must not be equal to %{left}","number?":"must be a number","odd?":"must be odd","or":"or","size?":{"arg":{"default":"size must be %{size}","range":"size must be within %{size_left} - %{size_right}"},"value":{"string":{"arg":{"default":"length must be %{size}","range":"length must be within %{size_left} - %{size_right}"}}}},"str?":"must be a string","time?":"must be a time","true?":"must be true","type?":"must be %{type}","unacceptable_request":"A supported version is expected in the Accept header.\n","unavailable_session":"Session %{id} is no longer available in memory.\n\nIf you happen to run on a multi-process server (like Unicorn or Puma) the process\nthis request hit doesn't store %{id} in memory. Consider turning the number of\nprocesses/workers to one (1) or using a different server in development.\n"},"helpers":{"page_entries_info":{"entry":{"one":"entry","other":"entries","zero":"entries"},"more_pages":{"display_entries":"Displaying %{entry_name} \u003cb\u003e%{first}\u0026nbsp;-\u0026nbsp;%{last}\u003c/b\u003e of \u003cb\u003e%{total}\u003c/b\u003e in total"},"one_page":{"display_entries":{"one":"Displaying \u003cb\u003e1\u003c/b\u003e %{entry_name}","other":"Displaying \u003cb\u003eall %{count}\u003c/b\u003e %{entry_name}","zero":"No %{entry_name} found"}}},"select":{"prompt":"Please select"},"submit":{"create":"Create %{model}","submit":"Save %{model}","update":"Update %{model}"}},"layout":{"cart":{"check_out":"Check Out","continue_shopping":"Continue Shopping","description":"Description","order":"Order","product":"Product","qty":"Qty","total":"Total","total_product":"Total products:","unit_price":"Unit price"},"home":{"add_to_cart":"Add to cart","already_account":"Already have an account?","contact_us":"Contact us","copyright":"Copyright © 2018 From Bootstrap Ecommerce Shopping Template","history":"The standard chunk of Lorem Ipsum used since the 1500s is reproduced below forthose interested. Sections 1.10.32 and 1.10.33 from 'de Finibus Bonorum etMalorum' by Cicero are also reproduced in their exact original form,accompanied by English versions from the 1914 translation by H. Rackham.","history_title":"The standard chunk of Lorem","home":"Home","item":"Item","list_product":"List Product","manufactures":"Manufactures","my_account":"My Account","quick_view":"QUICK VIEW","register":"Free Register","search":"Search","support":"Support (24/7) :  0800 1234 678","title":"Ecommerce 45","trend_product":"Trend Products","view":"VIEW"},"order":{"address":"Address","approve":"Approve","date":"Order Date","details":"Details","email":"Email","header_index":"Orders Tables","name":"Name","name_address_email":"Name, Address, Email","order_details":"Order Details","order_fails":"Can not order, please check again !","order_infor":"Order Information","order_some_fails":"Some product can not order","order_success":"Order_success","phone_number":"Phone Number","price":"Price","product":"Product","quantity":"Quantity","reject":"Reject","search":"Search","status":"Status","total":"Total"},"session":{"close":"Close","email":"Email address","forget_password":"Forget the password ?","keep_login":"keep me logged-in","login":"Login","logout":"Logout","password":"Password","sign_in":"Sign in"}},"model":{"order":{"status":{"approved":"Approved","pending":"Pending","rejected":"Rejected"}}},"number":{"currency":{"format":{"delimiter":",","format":"%u%n","precision":2,"separator":".","significant":false,"strip_insignificant_zeros":false,"unit":"$"}},"format":{"delimiter":",","precision":3,"separator":".","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":"Billion","million":"Million","quadrillion":"Quadrillion","thousand":"Thousand","trillion":"Trillion","unit":""}},"format":{"delimiter":"","precision":3,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"eb":"EB","gb":"GB","kb":"KB","mb":"MB","pb":"PB","tb":"TB"}}},"percentage":{"format":{"delimiter":"","format":"%n%"}},"precision":{"format":{"delimiter":""}}},"support":{"array":{"last_word_connector":", and ","two_words_connector":" and ","words_connector":", "}},"time":{"am":"am","formats":{"default":"%a, %d %b %Y %H:%M:%S %z","long":"%B %d, %Y %H:%M","short":"%d %b %H:%M"},"pm":"pm"},"views":{"pagination":{"first":"\u0026laquo; First","last":"Last \u0026raquo;","next":"Next \u0026rsaquo;","previous":"\u0026lsaquo; Prev","truncate":"\u0026hellip;"}}});
