{* Smarty *}
[PHP]

short_open_tag = Off
max_execution_time = {$smarty.env.PHP_MAX_EXECUTION_TIME}
max_input_time = {$smarty.env.PHP_MAX_INPUT_TIME}
{* This next variable required in the base php.ini before we run anything else *}
variables_order = "EGPCS"
memory_limit = {$smarty.env.PHP_MEMORY_LIMIT}

error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
display_errors = {$smarty.env.PHP_DISPLAY_ERRORS}
display_startup_errors = {$smarty.env.PHP_DISPLAY_STARTUP_ERRORS}
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = On
ignore_repeated_source = Off
track_errors = Off
allow_url_fopen = On
allow_url_include = Off

[curl]
curl.cainfo=/etc/cacert.crt

[openssl]
openssl.cafile=/etc/cacert.crt