<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>SIRH - Sistema de Informaci&oacute;n Ambiental y de Recursos H&iacute;dricos Bolivia</title>
    <meta name="description" content="Sistema de Información Ambiental y de Recursos Hídricos Bolivia" />
    <meta name="keywords" content="sirh,siarh,mmaya,sir,vapsb,vrhr,bolivia,vma" />
    <meta name="author" content="sirh"/>

    <!-- Favicon -->
    <!--
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    -->
    <link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" href="/favicon/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="/favicon/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="/favicon/manifest.json">
    <link rel="mask-icon" href="/favicon/safari-pinned-tab.svg" color="#5bbad5">
    <!-- vector map CSS -->
    <link href="vendors/bower_components/jasny-bootstrap/dist/css/jasny-bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- Custom CSS -->
    <link href="dist/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--Preloader-->
<div class="preloader-it">
    <div class="la-anim-1"></div>
</div>
<!--/Preloader-->

<div class="wrapper theme-1-active pimary-color-blue">
    <header class="sp-header">
        <div class="sp-logo-wrap pull-left">
            <a href="index.html">
                <img class="brand-img mr-10" width="200" height="70"   src="{$templateDir}sirh/images/login/login_titulo.png?id=32" alt="brand"/>
                <span class="brand-text">&nbsp;</span>
            </a>
        </div>
        <div class="form-group mb-0 pull-right">
            <span class="inline-block pr-10">¿No tienes una cuenta?</span>
            <a class="inline-block btn btn-primary  btn-rounded btn-outline" href="#">Solicita</a>
        </div>
        <div class="clearfix"></div>
    </header>

    <!-- Main Content -->
    <div class="page-wrapper pa-0 ma-0 auth-page" id="loginPage">
        <div class="container-fluid">
            <!-- Row -->
            <div class="table-struct full-width full-height">
                <div class="table-cell vertical-align-middle auth-form-wrap">
                    <div class="auth-form  ml-auto mr-auto no-float">
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="mb-30">
                                    <h3 class="text-center txt-dark mb-10">Iniciar sesión en SIARH</h3>
                                    <h6 class="text-center nonecase-font txt-grey">Ingrese sus detalles a continuación</h6>
                                </div>
                                <div class="form-wrap">
                                    <form action="#" onsubmit="sendData();return false;" id="login" method="post">
                                        <div class="form-group">
                                            <label class="control-label mb-10" for="exampleInputEmail_2">Usuario : </label>
                                            <input type="text" class="form-control" required="" id="user" placeholder="Ingrese el usuario">
                                        </div>
                                        <div class="form-group">
                                            <label class="pull-left control-label mb-10" for="exampleInputpwd_2">Contraseña : </label>
                                            {*
                                            <a class="capitalize-font txt-primary block mb-10 pull-right font-12" href="forgot-password.html">Olvidó su contraseña ?</a>
                                            <div class="clearfix"></div>
                                            *}
                                            <input type="password" class="form-control" required="" id="password" placeholder="Ingrese su contraseña">
                                        </div>
                                        <!--
                                        <div class="form-group">
                                            <div class="checkbox checkbox-primary pr-10 pull-left">
                                                <input id="checkbox_2" required="" type="checkbox">
                                                <label for="checkbox_2"> Keep me logged in</label>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                        -->
                                        <div class="form-group text-center">
                                            <button type="submit" class="btn btn-primary  btn-rounded">Entrar</button>
                                        </div>

                                        <div class="form-group text-center">
                                            <br>
                                            <a target="_blank" href="https://www.facebook.com/sirh.bolivia/"><img
                                                        width="30" height="30"
                                                        src="{$templateDir}sirh/images/login/icon/facebook.png?id=32"
                                                        title="Viceministerio de Recursos H&iacute;dricos y Riego" /></a>

                                            <a target="_blank" href="https://twitter.com/sirhbolivia"><img
                                                        width="30" height="30"
                                                        src="{$templateDir}sirh/images/login/icon/twitter.png?id=32"
                                                        title="Viceministerio de Recursos H&iacute;dricos y Riego"/></a>
                                            <!--
                                            <a target="_blank" href="https://www.facebook.com/sirh.bolivia/"><img
                                                        width="30" height="30"
                                                        src="{$templateDir}sirh/images/login/icon/google.png?id=32"
                                                        title="Viceministerio de Recursos H&iacute;dricos y Riego"/></a>
                                                        -->

                                        </div>

                                    </form>
                                </div>

                                <!-- Modal content MSG -->
                                <div id="error-modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                <h5 class="modal-title" id="mySmallModalLabel">Atención</h5>
                                            </div>
                                            <div class="modal-body">
                                                Los datos enviados de autentificación son incorrectos, intente nuevamente
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger text-left" data-dismiss="modal">Cerrar</button>
                                            </div>
                                        </div>
                                        <!-- /.modal-content -->
                                    </div>
                                    <!-- /.modal-dialog -->
                                </div>
                                <!-- /.Modal content MSG -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Row -->
        </div>

    </div>
    <!-- /Main Content -->

</div>
<!-- /#wrapper -->

<!-- JavaScript -->

<!-- jQuery -->
<script src="vendors/bower_components/jquery/dist/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="vendors/bower_components/jasny-bootstrap/dist/js/jasny-bootstrap.min.js"></script>
<!-- Slimscroll JavaScript -->
<script src="vendors/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- Progressbar Animation JavaScript -->
<script src="vendors/bower_components/waypoints/lib/jquery.waypoints.min.js"></script>
<!-- Md5 -->
<script type="text/javascript" src="js/md5.js"></script>
<!-- waiting -->
<script type="text/javascript" src="dist/core/waitingfor.js"></script>

<!-- Init JavaScript -->
<script src="dist/js/init.js"></script>
<script>
    {literal}
    function sendData(){
        waitingDialog.show('Procesando...');
        randomnumber=Math.floor(Math.random()*100);
        $.post("index.php",{action:"login",
            random:randomnumber,
            "user":$("#user").val(),
            "password":hex_md5($("#password").val())
        }, function(data){
            verifyLogin(data);
        });
        return false;
    }

    function verifyLogin(resp){
        if (resp == 1){
            waitingDialog.hide();
            $('#error-modal').modal('show');
        }else if (resp == 0){
            waitingDialog.hide();
            $("#loginPage").slideUp("slow",function() {location="index.php";});
        }
    }
    {/literal}

</script>

</body>
</html>