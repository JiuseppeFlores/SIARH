/**
 *  FUNCION PARA REGISTRAR LOS LOGS DE LOS SISTEMAS
 */
var Logs = {
  create: async function (datos) {
    data = {
      sistema_id: datos.sistema_id ? datos.sistema_id : null,
      recurso_id: datos.recurso_id ? datos.recurso_id : null,
      nombre: datos.nombre ? datos.nombre : "Sin definir",
      descripcion: datos.descripcion ? datos.descripcion : "",
      path: datos.path ? datos.path : window.location.href,
      base_datos: datos.base_datos ? datos.base_datos : "Sin definir",
      userCreate: datos.userCreate ? datos.userCreate : null,
    };
    let status = 200;
    let msg = "";

    await $.ajax({
      url: "https://konga.mmaya.gob.bo:8443/api/reportes/datos",
      type: "post",
      data: data,
      headers: {
        Accept: "application/json",
        Authorization:
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImlzcyI6Iml1ZjlYZURibjloamRWUHlYVmtIQXBhYUJLbGpnSHIwIn0.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.0tP83tai3YKEocYHowjY5tGl_K60waaNt9YAmZNowxI",
      },
      success: function (data) {
        status = 201;
        msg = "Log Registrado";
      },
      error: function (error) {
        (status = 500), (msg = "Error al registrar el log");
      },
    });

    return {
      status,
      msg,
    };
  },

  // create : async function( datos ) {
  //     data = {
  //         'sistema_id': datos.sistema_id ? datos.sistema_id : null,
  //         'recurso_id': datos.recurso_id ? datos.recurso_id : null,
  //         'nombre': datos.nombre ? datos.nombre : "Sin definir",
  //         'descripcion': datos.descripcion ? datos.descripcion : '',
  //         'path': datos.path ? datos.path : window.location.href,
  //         'base_datos': datos.base_datos ? datos.base_datos : 'Sin definir',
  //         'userCreate': datos.userCreate ? datos.userCreate : null
  //     };

  //     // var response = await $.post("http://localhost:3000/reportes/datos",data, Logs.getHeader());
  //     var response = await $.post("https://konga.mmaya.gob.bo:8443/api/reportes/datos",data, Logs.getHeader());
  //     console.log(response)
  //     if (response.itemId) {
  //         return {
  //             status: 201
  //         }
  //     }
  //     return {
  //         status: 500
  //     };
  // },
  // getHeader: function() {
  //     return {
  //         headers: {
  //             Accept: "application/json",
  //             //Authorization:
  //         }
  //     };
  // }
};

// console.log("Inicio script hacerModalArrastrable INICIO");

// $(document).ready(function () {
//   let isDragging = false;
//   let offset = { x: 0, y: 0 };
//   console.log("Inicio script cargando DOM");
//   $(".modal").on("shown.bs.modal", function () {
//     // const $dialog = $(this).find('.modal-dialog');

//     // // Asegurar estilo necesario
//     // $dialog.css({
//     //     position: 'absolute',
//     //     margin: 0 // evita que Bootstrap lo centre
//     // });

//     const $dialog = $(this).find(".modal-dialog");

//     // ✅ CENTRAR EL MODAL en la pantalla
//     const windowWidth = $(window).width();
//     const windowHeight = $(window).height();
//     const dialogWidth = $dialog.outerWidth();
//     const dialogHeight = $dialog.outerHeight();

//     const left = (windowWidth - dialogWidth) / 2;
//     const top = (windowHeight - dialogHeight) / 2;

//     $dialog.css({
//       position: "absolute",
//       margin: 0,
//       top: top + "px",
//       left: left + "px",
//     });

//     const $handle = $dialog.find(".modal-header");

//     $handle.css("cursor", "move").on("mousedown", function (e) {
//       isDragging = true;
//       offset.x = e.clientX - $dialog.offset().left;
//       offset.y = e.clientY - $dialog.offset().top;

//       $(document).on("mousemove.draggable", function (e) {
//         if (isDragging) {
//           $dialog.offset({
//             top: e.clientY - offset.y,
//             left: e.clientX - offset.x,
//           });
//         }
//       });

//       $(document).on("mouseup.draggable", function () {
//         isDragging = false;
//         $(document).off(".draggable");
//       });
//     });
//   });
// });

// $(document).on("shown.bs.modal", ".modal", function () {
//   const $dialog = $(this).find(".modal-dialog");
//   const $header = $dialog.find(".modal-header");
//   // Solo calcular la posición si no fue movido manualmente antes
//   if (!$dialog.data("manuallyMoved")) {
//     const windowWidth = $(window).width();
//     const windowHeight = $(window).height();
//     const dialogWidth = $dialog.outerWidth();
//     const dialogHeight = $dialog.outerHeight();
//     const left = (windowWidth - dialogWidth) / 2;
//     let top = (windowHeight - dialogHeight) / 2;
//     if (top < 0) {
//       top = 10; // Fallback si el modal es muy alto
//     }
//     $dialog.css({
//       position: "absolute",
//       margin: 0,
//       top: top + "px",
//       left: left + "px"
//     });
//   }
//   // Evitar redimensionamiento automático
//   $dialog.css({
//     width: $dialog.width(),
//     height: $dialog.height()
//   });
//   // Hacer arrastrable
//   $header.css("cursor", "move");
//   let isDragging = false;
//   let offset = { x: 0, y: 0 };
//   $header.off("mousedown").on("mousedown", function (e) {
//     isDragging = true;
//     offset.x = e.clientX - $dialog.offset().left;
//     offset.y = e.clientY - $dialog.offset().top;
//     // Marcar que se movió manualmente
//     $dialog.data("manuallyMoved", true);
//     $(document).on("mousemove.modaldrag", function (e) {
//       if (isDragging) {
//         $dialog.offset({
//           top: e.clientY - offset.y,
//           left: e.clientX - offset.x
//         });
//       }
//     });
//     $(document).on("mouseup.modaldrag", function () {
//       isDragging = false;
//       $(document).off(".modaldrag");
//     });
//   });
// });


// Almacena las posiciones de modales por ID
const modalPositions = {};

$(document).on("shown.bs.modal", ".modal", function () {
  const $modal = $(this);
  const $dialog = $modal.find(".modal-dialog");
  const $header = $dialog.find(".modal-header");

  const modalId = $modal.attr("id");

  // Si ya se movió antes, usa la posición guardada
  if (modalPositions[modalId]) {
    $dialog.css({
      position: "absolute",
      margin: 0,
      top: modalPositions[modalId].top + "px",
      left: modalPositions[modalId].left + "px"
    });
  } else {
    // Primera vez: centrar
    const windowWidth = $(window).width();
    const windowHeight = $(window).height();
    const dialogWidth = $dialog.outerWidth();
    const dialogHeight = $dialog.outerHeight();
    const left = (windowWidth - dialogWidth) / 2;
    let top = (windowHeight - dialogHeight) / 2;
    if (top < 0) top = 10;

    $dialog.css({
      position: "absolute",
      margin: 0,
      top: top + "px",
      left: left + "px"
    });

    // Guardar posición inicial
    modalPositions[modalId] = { top: top, left: left };
  }

  // Fijar el tamaño actual para evitar redimensionamiento
  $dialog.css({
    width: $dialog.width(),
    height: $dialog.height()
  });

  // Hacer arrastrable
  $header.css("cursor", "move");

  let isDragging = false;
  let offset = { x: 0, y: 0 };

  $header.off("mousedown").on("mousedown", function (e) {
    isDragging = true;
    offset.x = e.clientX - $dialog.offset().left;
    offset.y = e.clientY - $dialog.offset().top;

    $(document).on("mousemove.modaldrag", function (e) {
      if (isDragging) {
        const newTop = e.clientY - offset.y;
        const newLeft = e.clientX - offset.x;

        $dialog.offset({ top: newTop, left: newLeft });

        // Guardar nueva posición
        modalPositions[modalId] = { top: newTop, left: newLeft };
      }
    });

    $(document).on("mouseup.modaldrag", function () {
      isDragging = false;
      $(document).off(".modaldrag");
    });
  });
});
