<div class="m-portlet">
	<table class="table table-responsive table-sm table-bordered">
		<thead>
			<tr>
				<th>Parametro</th>
				{foreach from=$pozos item=po}
				<th>{$po}</th>
				{/foreach}
			</tr>
		</thead>
		<tbody>
			{foreach from=$matriz item=fila}
			<tr>
				{foreach from=$fila item=celda}
				<td>{$celda}</td>
				{/foreach}
			</tr>
			{/foreach}
		</tbody>
	</table>
</div>