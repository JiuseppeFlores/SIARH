{literal}
<style>
/*--BEGIN::FONTS--*/
 body {
 	font-family: 'Roboto', sans-serif;
 }
/*--END::FONTS--*/

/*--BEGIN::LOAD--*/
.win-active {
	display: none;
}

/*--END::LOAD--*/

/*--BEGIN::TABLE--*/
.table th {
	border-top: 1px solid #e0e0d0;
	border-bottom: 1px solid #e0e0d0;
	background-color: #f5f5f5;
}

th.table-title {
	border-top: none;
	background-color: #ffffff;
}

.table tbody tr:hover {
	background-color: #fcf3cf ;
}

.table tbody tr td {
	border-top: 1px solid #e0e0d0;
}
/*--END::TABLE--*/

/*--BEGIN::TAB--*/
.tab-button-close {
	width: 30px;
	height: 30px;
	float: right;
	border-radius: 100px;
	-moz-border-radius: 100px;
    -webkit-border-radius: 100px;
    background-color: #F78484;
	padding: 1px;
	border: 1px solid #F78484;
	cursor: pointer;
	color: #efefef;
	font-size: 18px;
	font-weight: bold;
}

.tab-button-close:hover {
	background-color: #FF4545;
	color: #ffffff;
}
/*--END::TAB--*/

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
	.tab-button-close {
		position: absolute;
		right: 9px;
		top: 66px;
	}

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

	.btn-block-custom {
		width: 100%;
		margin-bottom: 5px;
		display: block; 
	}

	.btn-group {
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
	.tab-button-close {
		position: absolute;
		right: 9px;
		top: 66px;
	}

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
	.tab-button-close {
		position: absolute;
		right: 9px;
		top: 66px;
	}

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
	.tab-button-close {
		position: absolute;
		right: 45px;
		top: 110px;
	}

	h5 {
		font-size: 16px;
	}
}

@media(min-width:1200px){
	.tab-button-close {
		position: absolute;
		right: 45px;
		top: 110px;
	}

	h5 {
		font-size: 16px;
	}
}
/*--END::MEDIA QUERY--*/
</style>
{/literal}