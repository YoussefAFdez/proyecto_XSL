<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/taller">
		<html>
			<head>
				<title>Taller de Youssef</title>
			</head>
			<body bgcolor="#ABE1E6">
				<h1 align="center"><xsl:value-of select="nombre"/></h1>
				<h2>PROYECTOS</h2>
				<table border="5" style="border-collapse;" cellspacing="10px" bordercolor="black" bgcolor="white">
					<xsl:for-each select="proyectos/proyecto">
						<tr bgcolor="#FFC05F">						
							<td style="padding: 5px;">
							<h2>Proyecto: <xsl:value-of select="nombre"/></h2>
							<h4>Valor de venta: <xsl:apply-templates select="precioVenta"/></h4>
							<table border="4" width="80%" bgcolor="#FFFFFF" style="border-collapse;" bordercolor="black">
								<tr bgcolor="#0D73BD" style="color: white;">
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
									<td><img alt="foto_proyecto" src="{imagen}" width="60%" align="center"/></td>
								</tr>
							</table>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				<h1>Almacen de materiales</h1>
				<table border="1" bgcolor="white" bordercolor="black">
					<tr bgcolor="#0D73BD" style="color: white;">
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
					<xsl:choose>
						<xsl:when test="unidades = 0">
							<tr bgcolor="#979797" style="font-style: italic;">
								<td><xsl:value-of select="nombre"/></td>
								<td><xsl:value-of select="./@tipo"/></td>
								<td><xsl:value-of select="tamanio"/></td>
								<td><xsl:value-of select="unidades"/></td>
								<td><xsl:value-of select="cantidadMax"/></td>
								<td><xsl:value-of select="precioUnidad"/></td>
								<td><xsl:apply-templates select="." mode="operacion"/></td>
							</tr>
						</xsl:when>
						<xsl:when test="unidades * 100 div cantidadMax &lt; 25">
							<tr bgcolor="red">
								<td><xsl:value-of select="nombre"/></td>
								<td><xsl:value-of select="./@tipo"/></td>
								<td><xsl:value-of select="tamanio"/></td>
								<td><xsl:value-of select="unidades"/></td>
								<td><xsl:value-of select="cantidadMax"/></td>
								<td><xsl:value-of select="precioUnidad"/></td>
								<td><xsl:apply-templates select="." mode="operacion"/></td>
							</tr>
						</xsl:when>
						<xsl:when test="unidades * 100 div cantidadMax &gt; 24 and unidades * 100 div cantidadMax &lt; 50">
							<tr bgcolor="#E8FA38">
								<td><xsl:value-of select="nombre"/></td>
								<td><xsl:value-of select="./@tipo"/></td>
								<td><xsl:value-of select="tamanio"/></td>
								<td><xsl:value-of select="unidades"/></td>
								<td><xsl:value-of select="cantidadMax"/></td>
								<td><xsl:value-of select="precioUnidad"/></td>
								<td><xsl:apply-templates select="." mode="operacion"/></td>
							</tr>
						</xsl:when>
						<xsl:when test="unidades * 100 div cantidadMax &gt; 49 and unidades * 100 div cantidadMax &lt; 75">
							<tr bgcolor="#38FA76">
								<td><xsl:value-of select="nombre"/></td>
								<td><xsl:value-of select="./@tipo"/></td>
								<td><xsl:value-of select="tamanio"/></td>
								<td><xsl:value-of select="unidades"/></td>
								<td><xsl:value-of select="cantidadMax"/></td>
								<td><xsl:value-of select="precioUnidad"/></td>
								<td><xsl:apply-templates select="." mode="operacion"/></td>
							</tr>
						</xsl:when>
						<xsl:when test="unidades * 100 div cantidadMax &gt; 74">
							<tr bgcolor="#38D7FA">
								<td><xsl:value-of select="nombre"/></td>
								<td><xsl:value-of select="./@tipo"/></td>
								<td><xsl:value-of select="tamanio"/></td>
								<td><xsl:value-of select="unidades"/></td>
								<td><xsl:value-of select="cantidadMax"/></td>
								<td><xsl:value-of select="precioUnidad"/></td>
								<td><xsl:apply-templates select="." mode="operacion"/></td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr bgcolor="#FFFFFF">
								<td><xsl:value-of select="nombre"/></td>
								<td><xsl:value-of select="./@tipo"/></td>
								<td><xsl:value-of select="tamanio"/></td>
								<td><xsl:value-of select="unidades"/></td>
								<td><xsl:value-of select="cantidadMax"/></td>
								<td><xsl:value-of select="precioUnidad"/></td>
								<td><xsl:apply-templates select="." mode="operacion"/></td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>	
					</xsl:for-each>
					<tr bgcolor="#0D73BD" style="color: white;">
						<td><b>TOTAL DE OBJETOS</b></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>
							<b><xsl:value-of select="count(inventario/objeto)"/></b>
						</td>
					</tr>
				</table>
				<table bgcolor="white" style="margin-top: 20px; margin-bottom: 20px;">
					<legend>Leyenda Colores</legend>
					<tr>
						<th></th>
						<th bgcolor="#979797" style="color: white;">Negro</th>
						<th bgcolor="red">Rojo</th>
						<th bgcolor="#E8FA38">Amarillo</th>
						<th bgcolor="#38FA76">Verde</th>
						<th bgcolor="#38D7FA">Azul</th>
					</tr>
					<tr>
						<td bgcolor="#0D73BD" style="color: white;">% de existencias</td>
						<td>0 Unidades</td>
						<td>1% a 24%</td>
						<td>25% a 49%</td>
						<td>50% a 74%</td>
						<td>75% a 100%</td>
					</tr>
				</table>
				<h2>Futuros proyectos en mente: 
				<xsl:for-each select="futurosProyectos/nombre">
					<xsl:if test="position() != last()">
						<xsl:value-of select="."/><xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:if test="position() = last()">
						<xsl:value-of select="."/><xsl:text>.</xsl:text>
					</xsl:if>
				</xsl:for-each>
				</h2>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="material" mode="nombre">
		<xsl:choose>
			<xsl:when  test="tipo = 'tornillos'">
				<!-- <li><xsl:value-of select="nombre"/> Tamanio: <xsl:value-of select="tamanio"/></li> -->
				<li><xsl:value-of select="concat(nombre,'. Tamanio: ', tamanio)"/></li>
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
				<xsl:value-of select="format-number($total, '#.00')"/> Euros			
			</xsl:when>
			<xsl:otherwise>
				No aplicable
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
