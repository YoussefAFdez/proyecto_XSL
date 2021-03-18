<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/taller">
		<html>
			<head>
				<title>Taller de Youssef</title>
			</head>
			<body>
				<h1>PROYECTOS</h1>
				<table border="3" style="border-collapse;" cellspacing="20px">
					<xsl:for-each select="proyectos/proyecto">
						<tr bgcolor="#FFC05F">						
							<td>
							<h2>Proyecto: <xsl:value-of select="nombre"/></h2>
							<h4>Valor de venta: <xsl:apply-templates select="precioVenta"/></h4>
							<table border="1px" width="80%" bgcolor="#FFFFFF" style="border-collapse;">
								<tr>
									<th>Descripcion</th>
									<th width="15%">Lista de materiales</th>
									<th width="10%">Tipo de material</th>
									<th>Cantidad necesaria</th>
									<th width="20%">Lista de herramientas</th>
									<th>Imagen del proyecto</th>
								</tr>
								<tr>
									<td><xsl:value-of select="descripcion"/></td>
									<td>
										<ul>
											<xsl:for-each select="listaMateriales/material">
												<xsl:apply-templates select="." mode="nombre"/>
											</xsl:for-each>
										</ul>
									</td>
									<td>
										<ul>
											<xsl:for-each select="listaMateriales/material">
												<xsl:apply-templates select="." mode="tipo"/>
											</xsl:for-each>
										</ul>
									</td>
									<td>
										<ul>
											<xsl:for-each select="listaMateriales/material">
												<xsl:apply-templates select="." mode="cantidad"/>
											</xsl:for-each>
										</ul>
									</td>
									<td>
										<ul>
											<xsl:for-each select="herramientasNecesarias/nomHerramienta">
												<xsl:apply-templates select="."/>
											</xsl:for-each>
										</ul>
									</td>
									<td><img alt="foto_proyecto" src="{imagen}" width="60%"/></td>
								</tr>
							</table>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				<h1>Almacen de materiales</h1>
				<table border="1">
					<tr>
						<th>Nombre</th>
						<th>Tipo</th>
						<th>Tamanio</th>
						<th>Cantidad</th>
						<th>Capacidad Maxima</th>
						<th>Precio Unidad</th>
						<th>Coste reabastecimiento</th>
					</tr>
					<xsl:for-each select="inventario/objeto">
					<xsl:sort select="./@tipo" order="descending"/>
						<tr>
							<td><xsl:value-of select="nombre"/></td>
							<td><xsl:value-of select="./@tipo"/></td>
							<td><xsl:value-of select="tamanio"/></td>
							<td><xsl:value-of select="unidades"/></td>
							<td><xsl:value-of select="cantidadMax"/></td>
							<td><xsl:value-of select="precioUnidad"/></td>
							<td><xsl:apply-templates select="." mode="operacion"/></td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="material" mode="nombre">
		<xsl:choose>
			<xsl:when  test="tipo = 'tornillos'">
				<li><xsl:value-of select="nombre"/> Tamanio: <xsl:value-of select="tamanio"/></li>
			</xsl:when>
			<xsl:otherwise><li><xsl:value-of select="nombre"/></li></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		<xsl:template match="material" mode="tipo">
		<li><xsl:value-of select="tipo"/></li>
	</xsl:template>
	<xsl:template match="material" mode="cantidad">
		<li><xsl:value-of select="cantidad"/></li>
	</xsl:template>
	<xsl:template match="nomHerramienta">
		<li><xsl:value-of select="."/></li>
	</xsl:template>
	<xsl:template match="precioVenta">
		<xsl:value-of select="."/><xsl:value-of select="./@moneda"/>
	</xsl:template>
	<xsl:template match="/taller/inventario/objeto" mode="operacion">
		<xsl:call-template name="realizarCuentas">
			<xsl:with-param name="cantidad" select="unidades"/>
			<xsl:with-param name="cantidadMax" select="cantidadMax"/>
			<xsl:with-param name="precioUd" select="precioUnidad"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="realizarCuentas">
		<xsl:param name="cantidad"/>
		<xsl:param name="cantidadMax"/>
		<xsl:param name="precioUd"/>
		<xsl:param name="restantes" select="$cantidadMax - $cantidad"/>
		<xsl:param name="total" select="$restantes * $precioUd"/>
		<xsl:choose>
			<xsl:when test="$cantidadMax != ''">
				<xsl:value-of select="$total"/> Euros			
			</xsl:when>
			<xsl:otherwise>
				No aplicable
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
