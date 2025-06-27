{literal}
<style>
	.mapa {
		position: relative;
		display: block;
		height: calc(100vh - 20vh);
		width: 65%;
		/*border: solid 1px #387ec9;*/
		margin: 0px;
		float: left;
    }
    .mapa_datos {
		position: relative;
		display: block;
		height: 100%;
		width: 35%;
		margin: 0px;
		float: left;
		overflow-y: auto;
		overflow-x: hidden;
	}
    .geovisor_search {
    	position: absolute;
    	top: 0;
    	right: 0;
    	z-index: 2;
    	display: block;
		margin: 0px;
		width: 100%;
		height: 100%;
		background: rgba(40, 40, 40, 0.3);
    }
    .geovisor_search_contenido {
		width: 100%;
		height: 100%;
		background: rgba(255, 255, 255, 0);
	}
	.geovisor_search_titulo {
		width: 100%;
		height: 30px;
		padding-left: 45px;
		padding-top: 4px;
		padding-bottom: 4px;
		font-size: 14px;
		text-align: center;
		color: #ffffff;
		background-color: #4671a6;
	}
	.geovisor_search_cuerpo {
		width: 100%;
		height: 95%;
		padding-top: 15px;
		padding-bottom: 15px;
		overflow-y: auto;
		overflow-x: hidden; 
	}
    .geovisor_info {
    	position: absolute;
    	top: 0;
    	left: 0;
    	display: block;
    	margin: 0px;
    	width: 100%;
		height: 100%;
		background: rgba(255, 255, 255, 0);
		overflow-y: auto;
		overflow-x: hidden;
    }
	.geovisor_info_contenido {
		width: 100%;
		height: 100%;
		background: rgba(255, 255, 255, 0);
	}
	.geovisor_info_titulo {
		width: 100%;
		height: 30px;
		padding-left: 45px;
		padding-top: 4px;
		padding-bottom: 4px;
		font-size: 14px;
		text-align: left;
		color: #ffffff;
		background-color: #4671a6;
	}
	.geovisor_info_cuerpo {
		width: 100%;
		height: 90%;
		padding-top: 15px;
		padding-bottom: 15px;
		overflow-y: auto;
		overflow-x: hidden; 
	}
	.geovisor_menu {
		position: absolute;
    	bottom: 0;
		right: 0;
		z-index: 800;
		display: block;
		margin: 0px;
		height: auto;
		width: 100%;
		text-align: center;
	}
	.geovisor_menu_contenido {
		width: auto;
		height: auto;
		padding-left: 6px;
		padding-right: 6px;
		padding-top: 6px;
		padding-bottom: 6px;
	}
	.geovisor_menu_boton {
		padding-left: 5px;
		padding-right: 5px;
		padding-top: 5px;
		padding-bottom: 5px;
		background: rgba(200, 200, 200, 0.6);
		border-top-left-radius: 28px;
		border-bottom-left-radius: 28px;
		border-top-right-radius: 28px;
		border-bottom-right-radius: 28px;
	}

	.btn-success {
		color: #000000 !important;
	}
	
	.btn-success:hover, .btn-success:focus, .btn-success:active, .btn-success.active, .open > .dropdown-toggle.btn-success {
		color: #000000;
	}

	.geovisor_data {
    	position: absolute;
    	bottom: 0;
    	left: 0;
    	z-index: 2;
    	display: block;
		margin: 0px;
		width: 100%;
		height: auto;
		background: rgba(255, 255, 255, 0.8);
    }

    .geovisor_data_contenido {
		width: 100%;
		height: auto;
	}

	.geovisor_data_cuerpo {
		padding-top: 4px;
		padding-bottom: 3px;
		padding-left: 5px;
		padding-right: 5px;
		color: #000000;
		font-weight: normal;
	}

	.geovisor_busqueda {
    	position: absolute;
    	top: 0;
    	left: 0;
    	z-index: 1;
    	display: block;
    	margin-top: 15px;
		margin-right: 60px;
		margin-left: 60px;
		width: 40%;
		height: auto;
		background: rgba(255, 255, 255, 0);
    }

	.geovisor_botones {
    	position: absolute;
    	/*top: 0;*/
    	left: 0;
    	z-index: 1;
    	display: block;
		margin-top: 100px;
		margin-bottom: 100px;
		width: auto;
		height: auto;
		background: rgba(255, 255, 255, 0);
    }

    .geovisor_botones_contenido {
		width: 100%;
		height: auto;
	}

	.geovisor_botones_cuerpo {
		padding-top: 0px;
		padding-bottom: 3px;
		padding-left: 5px;
		padding-right: 5px;
		color: #000000;
		font-weight: normal;
	}

	.ol-popup {
        position: absolute;
        background-color: white;
        -webkit-filter: drop-shadow(0 1px 4px rgba( 23, 165, 137, 0.2));
        filter: drop-shadow(0 1px 4px rgba( 23, 165, 137, 0.2));
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #76d7c4;
        bottom: 12px;
        left: -50px;
        width: 250px;
        z-index: 5;
	}

    .ol-popup:after, .ol-popup:before {
        top: 100%;
        border: solid transparent;
        content: " ";
        height: 0;
        width: 0;
        position: absolute;
        pointer-events: none;
	}

	.ol-popup:after {
        border-top-color: white;
        border-width: 10px;
        left: 48px;
        margin-left: -10px;
	}

	.ol-popup:before {
        border-top-color: #cccccc;
        border-width: 11px;
        left: 48px;
        margin-left: -11px;
	}

	.ol-popup-closer {
        text-decoration: none;
        position: absolute;
        top: 2px;
        right: 8px;
	}

	.ol-popup-closer:after {
		content: "✖";
	}

	.ol-compassctrl.bottom {
		margin-bottom: 25px;
		margin-right: 35px;
		top: auto;
		left: auto;
		bottom: 0;
		right: 0;
		width: 120px;
		height: 120px;
		-webkit-transform: none;
		transform: none;
	}

	/*--BEGIN::MEDIA QUERY--*/
	@media(max-width: 480px) {
		.mapa {
			position: relative;
			display: block;
			height: 420px;
			width: 100%;
			margin: 0px;
			float: left;
	    }
	    .mapa_datos {
			position: relative;
			height: auto;
			width: 100%;
			margin: 0px;
			float: left;
		}
		.geovisor_info {
			position: relative;
			margin: 0 auto;
			padding-top: 15px;
			padding-bottom: 15px;
			height: auto;
			width: 100%;
			word-wrap: break-word;
		}
		.geovisor_data {
			display: none;
		}
		.geovisor_busqueda {
			width: 70%;
	    }
	}

	@media(min-width: 481px) {
		.mapa {
			position: relative;
			display: block;
			height: 420px;
			width: 100%;
			margin: 0px;
			float: left;
	    }
	    .mapa_datos {
			position: relative;
			height: auto;
			width: 100%;
			margin: 0px;
			float: left;
		}
		.geovisor_info {
			position: relative;
			margin: 0 auto;
			padding-top: 15px;
			padding-bottom: 15px;
			height: auto;
			width: 100%;
			word-wrap: break-word;
		}
		.geovisor_busqueda {
			width: 80%;
	    }
	}

	@media(min-width: 768px) {
		.mapa {
			position: relative;
			display: block;
			height: 420px;
			width: 100%;
			margin: 0px;
			float: left;
	    }
	    .mapa_datos {
			position: relative;
			display: block;
			overflow: hidden;
			height: auto;
			width: 100%;
			margin: 0px;
			float: left;
		}
		.geovisor_busqueda {
			width: 80%;
	    }
	}

	@media(min-width: 992px) {
		.mapa {
			position: relative;
			display: block;
			height: calc(100vh - 20vh);
			width: 65%;
			margin: 0px;
			float: left;
	    }
	    .mapa_datos {
			position: relative;
			display: block;
			height: 100%;
			width: 35%;
			margin: 0px;
			float: left;
		}
	    .geovisor_info {
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	display: block;
	    	margin: 0px;
	    	width: 100%;
			height: 100%;
			background: rgba(255, 255, 255, 0);
			overflow-y: auto;
			overflow-x: hidden;
	    }
	    .geovisor_busqueda {
			width: 80%;
	    }
	}

	@media(min-width:1200px){
		.mapa {
			position: relative;
			display: block;
			height: calc(100vh - 20vh);
			width: 65%;
			margin: 0px;
			float: left;
	    }
	    .mapa_datos {
			position: relative;
			display: block;
			height: 100%;
			width: 35%;
			margin: 0px;
			float: left;
		}
	    .geovisor_info {
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	display: block;
	    	margin: 0px;
	    	width: 100%;
			height: 100%;
			background: rgba(255, 255, 255, 0);
			overflow-y: auto;
			overflow-x: hidden;
	    }
	    .geovisor_busqueda {
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	z-index: 2;
	    	display: block;
	    	margin-top: 15px;
			margin-right: 50px;
			margin-left: 50px;
			width: 50%;
			height: auto;
			background: rgba(255, 255, 255, 0);
	    }
	}
	/*--END::MEDIA QUERY--*/
</style>
{/literal}