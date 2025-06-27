<script type="text/javascript">
var datosBD = {$modeloDatos};
</script>
{literal}
<script type="text/javascript">
var dataGrid = null;
var dataRow = null;
var dataRowIndex = null;
var crudAction = "create";
var urlBase = window.location.href;
var dataForm = {
    "nombre": "",
    "estado": ""
};

jQuery(document).ready(function() {
    /*--BEGIN::INIT--*/
    dataGrid = $('#gridMain').DataTable( {
        "data": datosBD.data,
        "columns": [
            { "data": "Actions" },
            { "data": "itemId" },
            { "data": "nombre" },
            { "data": "estado" }
        ],
        "columnDefs": [
            {
                "targets": 0,
                "title": "Acción",
                "orderable": false,
                "render": function (data, type, row, meta) {
                    return fnGenerarMenuRegistroGrilla();
                }
            }
        ],
        "responsive": true,
        "language": {"url": "language/datatable.spanish.json"},
        "lengthMenu": [5, 10, 25, 50],
        "order": [[ 1, "asc" ]]
    } );

    $("#ventanaFormulario").removeClass("win-active");
    $("#ventanaGrilla").removeClass("win-active");
    fnOcultarVentanaFormulario();
    /*--END::INIT--*/

    /*--BEGIN::GRID--*/
    $("#btnNuevo").click(function() {
        crudAction = "create";
        fnInicializarFormulario("Crear");
        fnOcultarVentanaGrilla();
        fnMostrarVentanaFormulario();
    });

    $("body").on("click", "a#lnkEditarRegistro", function() {
        crudAction = "update";
        fnInicializarFormulario("Modificar");
        fnRecuperarRegistroGrilla(this);
        fnAsignarDatosFormulario(dataRow);
        fnOcultarVentanaGrilla();
        fnMostrarVentanaFormulario();
        return false;
    });

    $("body").on("click", "a#lnkAuxEditarRegistro", function() {
        crudAction = "update";
        fnInicializarFormulario("Modificar");
        fnRecuperarRegistroGrilla(this);
        fnAsignarDatosFormulario();
        fnOcultarVentanaGrilla();
        fnMostrarVentanaFormulario();
        return false;
    });

    $("body").on("click", "a#lnkEliminarRegistro", function() {
        crudAction = "delete";
        fnRecuperarRegistroGrilla(this);
        fnMostrarAdvertenciaEliminar(dataRow.itemId);
        return false;
    });

    $("body").on("click", "a#lnkImprimirRegistro", function() {
        alert("Imprimiendo...");
        return false;
    });
    /*--END::GRID--*/

    /*--BEGIN::FORM--*/
    $("#formMain").submit(function(event) {
        var form = $("form#formMain");
        var url = fnConstruirUrl();
        if (crudAction === "create") {
            fnCrearRegistroBD(url, form);
        } else if(crudAction === "update") {
            fnActualizarRegistroBD(url, form);
        }
        event.preventDefault();
        return false;
    });

    $("#btnReiniciar").click(function() {
        if (crudAction == "create") {
            fnReiniciarFormulario();
        } else {
            fnInicializarFormulario("Crear");
            fnOcultarVentanaFormulario();
            fnMostrarVentanaGrilla();
        }
    });

    $("body").on("click", "a#lnkGuardarBorrador", function() {
        fnGuardarBorrador();
        return false;
    });

    $("body").on("click", "a#lnkRecuperarBorrador", function() {
        fnRecuperarBorrador();
        return false;
    });

    $("body").on("click", "a#lnkEliminarBorrador", function() {
        fnEliminarBorrador();
        return false;
    });
    /*--END::FORM--*/

    /*--BEGIN::TAB--*/
    $(".tab-pane").hide();
    $("ul.nav li.nav-item:first").addClass("active").show();
    $("ul.nav li.nav-item:first a").addClass("active").show();
    $(".tab-pane:first").show();

    $("ul.nav li.nav-item").click(function() {
        $("ul.nav li").removeClass("active");
        $("ul.nav li.nav-item a").removeClass("active");
        $(this).addClass("active");
        $(this).find("a").addClass("active");
        $(".tab-pane").hide();
        $($(this).find("a").attr("href")).fadeIn();
        return false;
    });

    $("#btnCerrarTab").click(function() {
        fnOcultarVentanaFormulario();
        fnMostrarVentanaGrilla();
    });
    /*--END::TAB--*/
});

/**
 * BEGIN::FUNCIONES
 */
/*--BEGIN::GRILLA--*/
function fnGenerarRegistroGrilla(id) {
    return {
        "Actions": id, 
        "itemId": id, 
        "nombre": dataForm.nombre, 
        "estado": dataForm.estado
    };
}

function fnRecuperarRegistroGrilla(registroSeleccionado) {
    dataRow = dataGrid.row($(registroSeleccionado).parents("tr")).data();
    dataRowIndex = dataGrid.row($(registroSeleccionado).parents("tr")).index();
}

function fnAgregarRegistroGrilla(datos) {
    dataGrid.row.add(datos).draw(false);
}

function fnActualizarRegistroGrilla(datos) {
    dataGrid.row(dataRowIndex).data(datos).draw(false);
}

function fnEliminarRegistroGrilla(){
    dataGrid.row(dataRowIndex).remove().draw(false);
}

function fnGenerarMenuRegistroGrilla() {
    return '<a href="#" class="m-portlet__nav-link btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" title="Modificar" id="lnkEditarRegistro"><i class="la la-edit"></i></a><span class="dropdown"><a href="#" class="btn m-btn m-btn--hover-brand m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-expanded="true"><i class="la la-ellipsis-h"></i></a><div class="dropdown-menu dropdown-menu-left"><a class="dropdown-item" href="#" id="lnkAuxEditarRegistro"><i class="la la-edit"></i> Editar</a><a class="dropdown-item" href="#" id="lnkEliminarRegistro"><i class="la la-trash"></i> Borrar</a><a class="dropdown-item" href="#" id="lnkImprimirRegistro"><i class="la la-print"></i> Imprimir</a></div></span>';
}
/*--END::GRILLA--*/

/*--BEGIN::URL--*/
function fnConstruirUrl() {
    var url = urlBase;
    if (crudAction === "create") {
        url += "&accion=" + crudAction;
    } else {
        url += "&accion=" + crudAction + "&id=" + dataRow.itemId;
    }
    return url;
}
/*--END::URL--*/

/*--BEGIN::FORMULARIO--*/
function fnInicializarFormulario(labelButton) {
    fnReiniciarFormulario();
    $("#btnGuardar").html(labelButton);
}

function fnRecuperarDatosFormulario() {
    for (clave in dataForm) {
        dataForm[clave] = $("#" + clave).val();
    }
}

function fnAsignarDatosFormulario() {
    for (clave in dataForm) {
        $("#" + clave).val(dataRow[clave]);
    }
}

function fnReiniciarFormulario() {
    $("#formMain")[0].reset();
}
/*--END::FORMULARIO--*/

/*--BEGIN::BASE DE DATOS--*/
function fnEliminarRegistroBD(url) {
    $.get(url)
        .done(function(respuesta) {
            if(respuesta.res == 1){
                fnEliminarRegistroGrilla();
                swal('Eliminado!','El registro fue eliminado','success');
            }else if(respuesta.res == 2){
                swal("Ocurrió un error!", respuesta.msg, "error");
            }else{
                swal("ocurrió un error!", respuesta.msg, "error");
            }
        })
        .fail(function() {
            swal("ocurrió un error!", "Error en el servidor", "error");
        });
        /*
        .always(function() {
            swal("ocurrió un error!", "Procesando...", "error");
        });*/
}

function fnCrearRegistroBD(url, form) {
    $.post(url, form.serialize())
        .done(function(respuesta) {
            if(respuesta.res == 1){
                fnEliminarBorrador();
                fnRecuperarDatosFormulario();
                fnAgregarRegistroGrilla(fnGenerarRegistroGrilla(respuesta.id));
                fnReiniciarFormulario();
                swal('Creado','El registro fue creado.','success');
            }else if(respuesta.res == 2){
                swal("Ocurrió un error!", respuesta.msg, "error");
            }else{
                swal("ocurrió un error!", respuesta.msg, "error");
            }
        })
        .fail(function() {
            swal("ocurrió un error!", "Error en el servidor", "error");
        });
        /*
        .always(function() {
            swal("ocurrió un error!", "Procesando...", "error");
        });*/
}

function fnActualizarRegistroBD(url, form) {
    $.post(url, form.serialize())
        .done(function(respuesta) {
            if(respuesta.res == 1){
                fnEliminarBorrador();
                fnRecuperarDatosFormulario();
                fnActualizarRegistroGrilla(fnGenerarRegistroGrilla(dataRow.itemId));
                fnReiniciarFormulario();
                fnOcultarVentanaFormulario();
                fnMostrarVentanaGrilla();
                swal('Modificado','El registro fue modificado.','success');
            }else if(respuesta.res == 2){
                swal("Ocurrió un error!", respuesta.msg, "error");
            }else{
                swal("ocurrió un error!", respuesta.msg, "error");
            }
        })
        .fail(function() {
            swal("ocurrió un error!", "Error en el servidor", "error");
        });
        /*
        .always(function() {
            swal("ocurrió un error!", "Procesando...", "error");
        });*/
}
/*--END::BASE DE DATOS--*/

/*--BEGIN::MENSAJES--*/
function fnMostrarAdvertenciaEliminar(id) {
    swal({
        title: '¿Está seguro de borrar el registro?',
        text: "Recuerde que el registro se eliminará permanentemente. ID=" + id,
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Si, eliminar',
        cancelButtonText: "No, cancelar"
    }).then(function(respuesta) {
        if (respuesta.value) {
            //fnEliminarRegistroGrilla();
            fnEliminarRegistroBD(fnConstruirUrl());
        }
    });
}
/*--END::MENSAJES--*/

/*--BEGIN::VENTANAS--*/
function fnMostrarVentanaFormulario(){
    $("#ventanaFormulario").fadeIn();
}

function fnOcultarVentanaFormulario(){
    $("#ventanaFormulario").hide();
}

function fnMostrarVentanaGrilla(){
    $("#ventanaGrilla").fadeIn();
}

function fnOcultarVentanaGrilla(){
    $("#ventanaGrilla").hide();
}
/*--END::VENTANAS--*/

/*--BEGIN::CONVERSIONES--*/

/*--END::CONVERSIONES--*/

/*--BEGIN::BORRADOR--*/
function fnGuardarBorrador() {
    if (typeof(Storage) !== "undefined") {
        fnRecuperarDatosFormulario();
        localStorage.setItem("tipo_manantial", JSON.stringify(dataForm));
    } else {
        swal("ocurrió un error!", "No se puede guardar el borrador, navegador incompatible.", "error");
    }
}

function fnRecuperarBorrador() {
    if (typeof(Storage) !== "undefined") {
        if (typeof(localStorage.getItem("tipo_manantial")) != "undefined"){
            dataRow = null;
            dataRow = JSON.parse(localStorage.getItem("tipo_manantial"));
            fnAsignarDatosFormulario();
        }
    } else {
        swal("ocurrió un error!", "No se puede recuperar el borrador.", "error");
    }
}

function fnEliminarBorrador() {
    if (typeof(Storage) !== "undefined") {
        if (typeof(localStorage.getItem("tipo_manantial")) != "undefined"){
            localStorage.removeItem("tipo_manantial");
        }
    } else {
        swal("ocurrió un error!", "No se puede eliminar el borrador.", "error");
    }
}
/*--END::BORRADOR--*/

/**
 * END::FUNCIONES
 */
</script>
{/literal}