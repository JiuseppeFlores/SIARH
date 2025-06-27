{literal}
<style>
/*--BEGIN::FONTS--*/
 body {
 	font-family: 'Roboto', sans-serif;
 }
/*--END::FONTS--*/

/*--BEGIN::FORM--*/
select:required:invalid {
	color: #999;
}

option[value=””][disabled] {
	display: none;
}

option {
	color: #000;
}

.control-label {
	text-align: left;
	font-weight: 500;
}

.form-control {
	border: solid 1px #CED4DA;
	background-color: #fbfbfb;
}

.form-control:focus {
	background-color: #EEFFE8;
	border: solid 1px #58AAC6;
	/*text-transform: uppercase;*/
}

.m-portlet__body {
	background-color: #ffffff;
}

select.form-control option {
	background-color: #ffffff;
	color: #575962;
}

.line-separator {
	padding-top: 10px;
	padding-bottom: 5px;
	color: #01579B;
	border-bottom: solid 1px #2B6DDA;
	border-bottom-style: dashed;
}

.btn-default-custom {
	background-color: #6C757D;
	color: #ffffff;
}

.btn-default-custom:hover {
	background-color: #5A6268;
	border: solid 1px #545B62;
}
/*--END::FORM--*/

/*--BEGIN::MODAL--*/

/*--END::MODAL--*/

/*--BEGIN::MEDIA QUERY--*/
@media(max-width: 480px) {
	form label.control-label {
		display: none;
	}

	h5 {
		font-size: 14px;
	}

	.btn-block-custom {
		width: 100%;
		margin-bottom: 5px;
		display: block; 
	}

	.btn-default-custom {
		width: 100%;
		display: block;
	}
}

@media(min-width: 481px) {
	form label.control-label {
		display: none;
	}

	h5 {
		font-size: 14px;
	}

	.line-separator {
		padding-top: 5px;
		padding-bottom: 2px;
		color: #01579B;
		border-bottom: solid 1px #2B6DDA;
		border-bottom-style: dashed;
	}
}

@media(min-width: 768px) {
	form label.control-label {
		display: block;
	}

	h5 {
		font-size: 15px;
	}

	.line-separator {
		padding-top: 5px;
		padding-bottom: 2px;
		color: #01579B;
		border-bottom: solid 1px #2B6DDA;
		border-bottom-style: dashed;
	}
}

@media(min-width: 992px) {
	h5 {
		font-size: 16px;
	}
}

@media(min-width:1200px){
	h5 {
		font-size: 16px;
	}
}
/*--END::MEDIA QUERY--*/
</style>
{/literal}