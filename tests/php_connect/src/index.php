<?php
$cona = mysqli_connect($_SERVER['MYSQL1_HOST'],$_SERVER['MYSQL1_USER'],$_SERVER['MYSQL1_PASS']);
if (!$cona)
  {
  die('Could not connect: ' . mysqli_error());
  }
  
mysqli_select_db($cona, $_SERVER['MYSQL1_NAME']);
$result1 = mysqli_query($cona, "SELECT value FROM core_config_data WHERE path = 'web/cookie/cookie_lifetime' AND scope = 'default' AND scope_id = 0");
$result2 = mysqli_query($cona, "SELECT value FROM core_config_data WHERE path='atb/stores/store_ip'");
echo "Test Succeeded\n";
mysqli_close($cona);
$conb = mysqli_connect($_SERVER['MYSQL2_HOST'],$_SERVER['MYSQL2_USER'],$_SERVER['MYSQL2_PASS']);
if (!$conb)
  {
  die('Could not connect: ' . mysqli_error());
  }
  
mysqli_select_db($conb, $_SERVER['MYSQL2_NAME']);
$result1 = mysqli_query($conb, "SELECT value FROM core_config_data WHERE path = 'web/cookie/cookie_lifetime' AND scope = 'default' AND scope_id = 0");
$result2 = mysqli_query($conb, "SELECT value FROM core_config_data WHERE path='atb/stores/store_ip'");
echo "Test Succeeded\n";
mysqli_close($conb);
?>