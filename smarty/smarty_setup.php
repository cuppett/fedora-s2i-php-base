<?php
include('/usr/local/src/smarty/vendor/autoload.php');

$smarty = new Smarty();

$templatePath = '/usr/local/src/smarty/templates/';

$smarty->setTemplateDir($templatePath);
$smarty->setConfigDir('/usr/local/src/smarty/configs/');
$smarty->setCompileDir('/usr/local/src/smarty/templates_c/');
$smarty->setCacheDir('/usr/local/src/smarty/cache/');
