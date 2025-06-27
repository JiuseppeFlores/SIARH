<div class="row">
    <div class="col-lg-12">
        <!--BEGIN::FORM PANEL-->
        <div class="m-portlet">
            <!--BEGIN::FORM TITLE-->
            <div class="m-portlet__head">
                <div class="m-portlet__head-caption">
                    <div class="m-portlet__head-title">
						<span class="m-portlet__head-icon m--hide">
						<i class="la la-gear"></i>
						</span>
                        <h3 class="m-portlet__head-text">{$modeloEtiquetas.tituloForm}</h3>
                    </div>
                </div>
            </div>
            <!--END::FORM TITLE-->
            <!--BEGIN::FORM-->

            <form class="m-form" method="POST" action="{$getModule}" id="formMain" autocomplete="on">
                <div class="m-portlet__body">

                    <div class="row">
                        <div class="form-group col-lg-6">
                            <label class="control-label">Nombre</label>
                            <input class="form-control" type="text" name="datosForm[nombre]" id="nombre" value="" maxlength="60" placeholder="Nombre" required>
                        </div>

                        <div class="form-group col-lg-6">
                            <label class="control-label">Estado</label>
                            <select class="form-control" name="datosForm[estado]" id="estado" required>
                                <option value="" selected>Estado</option>
                                <option value="ACTIVO">ACTIVO</option>
                                <option value="INACTIVO">INACTIVO</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-lg-12">
                            <h5></h5>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-lg-12">
                            <button type="submit" class="btn btn-success btn-block-custom" id="btnGuardar">
                                <span><i class="la la-check"></i><span>&nbsp;Guardar</span></span>
                            </button>
                            <button type="reset" class="btn btn-danger btn-block-custom" id="btnReiniciar">Cancelar</button>
                            <div class="btn-group">
                                <button class="btn btn-primary dropdown-toggle btn-block-custom" data-toggle="dropdown" haspopup="true" aria-expanded="false">
                                    <span><i class="fa fa-database"></i><span></span></span>&nbsp;Borrador
                                    <span class="cared"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#" id="lnkGuardarBorrador">Guardar</a></li>
                                    <li><a href="#" id="lnkRecuperarBorrador">Recuperar</a></li>
                                    <li><a href="#" id="lnkEliminarBorrador">Eliminar</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </form>
            <!--END::FORM-->
        </div>
        <!--END::FORM PANEL-->
    </div>
</div>