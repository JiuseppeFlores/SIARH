<?php
$CFG->telegram["activo"] = true;

$CFG->telegram["token"] = "1750201080:AAGMhFmM3dgeYYSsiDaH_Az2sy98c4GSFK8";
$CFG->telegram["chat_id"] = "-1001386883755"; // SIARH Monitor

// https://api.telegram.org/bot944234158:AAHJsciLmWeCDsfc90c-Hjlcn3bG5NfvJ2g/getUpdates
$CFG->telegram["parse_mode"] ='HTML';
$CFG->telegram["log"] =true; //enviar logs a telegram
$CFG->telegram["log_modulo"] = true; //enviar logs a telegram
$CFG->telegram["log_login"] = true; //enviar logs a telegram
