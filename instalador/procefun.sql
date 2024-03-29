USE [PuntoVentaSysSoftDBDesarrollo]
GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Banco_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Banco_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdBanco from Banco)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdBanco,'BA',''),'','')AS INT)) from Banco)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'BA000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'BA00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'BA0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'BA'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'BA0001'
					end
			end
			return @CodGenerado
		end













GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Caja_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Caja_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdCaja from CajaTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdCaja,'CJ',''),'','')AS INT)) from CajaTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'CJ000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'CJ00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'CJ0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'CJ'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'CJ0001'
					end
			end
			return @CodGenerado
		end


















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Cambiar_Estado_Compra]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Cambiar_Estado_Compra](@IdCompra varchar(12))  returns varchar(10)
as
	begin
		declare @TotalCompra smallint,@NumeroTotalCompra smallint,@Estado varchar(10)
		set @TotalCompra = (select count(*) from CompraCreditoTB where IdCompra = @IdCompra)
		set @NumeroTotalCompra = (select count(*) from CompraCreditoTB where IdCompra = @IdCompra and Estado = 1)
		if(@TotalCompra = @NumeroTotalCompra)
			begin
				set @Estado = 'completado'
			end
		else
			begin
				set @Estado = 'falta'
			end		
		return @Estado
	end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Cliente_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Cliente_Codigo_Alfanumerico]()  returns varchar(12)
	as
		begin
		declare @Length int,@Incremental int,@ValorActual varchar(12),@ValorNuevo varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdCliente from ClienteTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdCliente,'CL',''),'','')AS INT)) from ClienteTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'CL000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'CL00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'CL0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'CL'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'CL0001'
					end
			end
			return @CodGenerado
		end























GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Compra_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Compra_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Length int,@Incremental int,@ValorActual varchar(12),@ValorNuevo varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdCompra from CompraTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdCompra,'CP',''),'','')AS INT)) from CompraTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1

						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'CP000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'CP00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'CP0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'CP'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'CP0001'
					end
			end
			return @CodGenerado
		end



















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Compra_Credito_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Compra_Credito_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdCompraCredito from CompraCreditoTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdCompraCredito,'CC',''),'','')AS INT)) from CompraCreditoTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'CC000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'CC00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'CC0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'CC'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'CC0001'
					end
			end
			return @CodGenerado
		end



GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Cotizacion_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Cotizacion_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdCotizacion from CotizacionTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdCotizacion,'',''),'','')AS INT)) from CotizacionTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						set @CodGenerado = CONVERT(VARCHAR,@Incremental)
					end
				else
					begin
						set @CodGenerado = '1'
					end
			end
			return @CodGenerado
		end









GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Empleado_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Empleado_Codigo_Alfanumerico]()  returns varchar(12)
	as
		begin
		declare @Length int,@Incremental int,@ValorActual varchar(12),@ValorNuevo varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdEmpleado from EmpleadoTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdEmpleado,'EM',''),'','')AS INT)) from EmpleadoTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'EM000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'EM00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'EM0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'EM'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'EM0001'
					end
			end
			return @CodGenerado
		end























GO
/****** Object:  UserDefinedFunction [dbo].[Fc_GuiaRemision_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_GuiaRemision_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdGuiaRemision from GuiaRemisionTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdGuiaRemision,'GR',''),'','')AS INT)) from GuiaRemisionTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'GR000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'GR00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'GR0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'GR'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'GR0001'
					end
			end
			return @CodGenerado
		end








GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Insumo_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_Insumo_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdInsumo from InsumoTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdInsumo,'IN',''),'','')AS INT)) from InsumoTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'IN000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'IN00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'IN0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'IN'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'IN0001'
					end
			end
			return @CodGenerado
		end




GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Mantenimiento_Generar_Codigo]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Mantenimiento_Generar_Codigo]() returns varchar(10)
	as
		begin
			declare @Codigo varchar(10),@NewCodigo varchar(10)
				if exists(select IdMantenimiento from MantenimientoTB)
					begin
						set @Codigo = (select MAX(IdMantenimiento) from MantenimientoTB)
						set @Codigo = CONVERT(INT,@Codigo) +1
						IF(@Codigo  <= 9)
							BEGIN 
								SET @NewCodigo='000'+CONVERT(VARCHAR,@Codigo)							
							END
						ELSE IF(@Codigo >= 10 AND @Codigo <= 99)
							BEGIN
								SET @NewCodigo='00'+CONVERT(VARCHAR,@Codigo)					
							END
						ELSE IF(@Codigo >= 100 AND @Codigo <= 999)
							BEGIN 
								SET @NewCodigo='0'+CONVERT(VARCHAR,@Codigo)
							END
						ELSE
							BEGIN
								SET @NewCodigo=''+CONVERT(VARCHAR,@Codigo)
							END
					end
				else 
					begin
						set @Codigo =  '0001'
						set @NewCodigo = @Codigo
					end

		return @NewCodigo
		end


























GO
/****** Object:  UserDefinedFunction [dbo].[Fc_MovimientoInventario_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_MovimientoInventario_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdMovimientoInventario from MovimientoInventarioTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdMovimientoInventario,'IN',''),'','')AS INT)) from MovimientoInventarioTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'IN000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'IN00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'IN0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'IN'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'IN0001'
					end
			end
			return @CodGenerado
		end


















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_NotaCredito_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_NotaCredito_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdNotaCredito from NotaCreditoTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdNotaCredito,'NC',''),'','')AS INT)) from NotaCreditoTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'NC000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'NC00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'NC0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'NC'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'NC0001'
					end
			end
			return @CodGenerado
		end


GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Abreviatura_Moneda]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Abreviatura_Moneda]
	(
	 @IdMoneda int
	)
	RETURNS VARCHAR(10)
	AS
	BEGIN
		DECLARE @Result VARCHAR(10)
			BEGIN
				SET @Result = (SELECT Abreviado FROM MonedaTB WHERE IdMoneda = @IdMoneda)	
			END
			RETURN @Result
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Apellidos_Empleado]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Apellidos_Empleado]
(
@idProveedor varchar(12)
) returns varchar(100)

as
	begin
		declare @datos varchar(100)
		set @datos=	(select Apellidos from EmpleadoTB where IdEmpleado = @idProveedor)
		return @datos
	end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Datos_Cliente]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Datos_Cliente]
(
@idCliente varchar(12)
) returns varchar(100)

as
	begin
		declare @datos varchar(100)
		set @datos=	(select Informacion from ClienteTB where IdCliente = @idCliente)
		return @datos
	end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Datos_Empleado]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Datos_Empleado]
(
@idProveedor varchar(12)
) returns varchar(100)

as
	begin
		declare @datos varchar(100)
		set @datos=	(select Nombres+' '+Apellidos from EmpleadoTB where IdEmpleado = @idProveedor)
		return @datos
	end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Datos_Plazos]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[Fc_Obtener_Datos_Plazos]
(
@IdPlazos int
) returns varchar(15)
as
	begin
		declare @datos varchar(15)
		if exists(select Nombre from PlazosTB where IdPlazos = @IdPlazos)
			begin
				set @datos= (select Nombre from PlazosTB where IdPlazos = @IdPlazos)
			end
		else 
			begin
				set @datos= 'DATOS NO ENCONTRADOS'
			end
		return @datos
	end













GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Datos_Proveedor]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Datos_Proveedor]
(
@idProveedor varchar(12)
) returns varchar(100)

as
	begin
		declare @datos varchar(100)
		set @datos=	(select RazonSocial from ProveedorTB where IdProveedor = @idProveedor)
		return @datos
	end


















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Departamento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Departamento]
	(
	 @IdUbigeo int
	)
	RETURNS VARCHAR(60)
	AS
	BEGIN
		DECLARE @Result VARCHAR(60),@TmpResult varchar(60)
			BEGIN
				SET @TmpResult = (SELECT Departamento FROM UbigeoTB WHERE IdUbigeo = @IdUbigeo)
				SET @Result = ISNULL(@TmpResult,'')
			END
			RETURN @Result
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Distrito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Distrito]
	(
	 @IdUbigeo int
	)
	RETURNS VARCHAR(60)
	AS
	BEGIN
		DECLARE @Result VARCHAR(60),@TmpResult varchar(60)
			BEGIN
				SET @TmpResult = (SELECT Distrito FROM UbigeoTB WHERE IdUbigeo = @IdUbigeo)	
				SET @Result = ISNULL(@TmpResult,'')
			END
			RETURN @Result
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombre_Detalle]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Nombre_Detalle]
	(
	@IdDetalle int,
	@IdMantenimiento varchar(10)
	)
	RETURNS VARCHAR(80)
	AS
	BEGIN
		DECLARE @Result VARCHAR(80)
			BEGIN
				SET @Result = (SELECT Nombre FROM DetalleTB 
				WHERE IdDetalle=@IdDetalle and IdMantenimiento=@IdMantenimiento)	
			END
			RETURN isnull(@Result,'')
	END








GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombre_Detalle_IdAuxiliar]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Nombre_Detalle_IdAuxiliar]
	(
	@IdDetalle int,
	@IdMantenimiento varchar(10)
	)
	RETURNS VARCHAR(80)
	AS
	BEGIN
		DECLARE @Result VARCHAR(80)
			BEGIN
				SET @Result = (SELECT IdAuxiliar FROM DetalleTB 
				WHERE IdDetalle=@IdDetalle and IdMantenimiento=@IdMantenimiento)	
			END
			RETURN ISNULL(@Result,'')
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombre_Impuesto]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Nombre_Impuesto]
	(
	 @IdImpuesto int
	)
	RETURNS VARCHAR(50)
	AS
	BEGIN
		DECLARE @Result VARCHAR(50)
			BEGIN
				SET @Result = (SELECT Nombre FROM ImpuestoTB WHERE IdImpuesto = @IdImpuesto)	
			END
			RETURN @Result
	END




















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombre_Moneda]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Nombre_Moneda]
	(
	 @IdMoneda int
	)
	RETURNS VARCHAR(10)
	AS
	BEGIN
		DECLARE @Result VARCHAR(10)
			BEGIN
				SET @Result = (SELECT Nombre FROM MonedaTB WHERE IdMoneda = @IdMoneda)	
			END
			RETURN @Result
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombre_Rol]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_Obtener_Nombre_Rol]
	(
	@IdRol int
	)
	RETURNS VARCHAR(60)
	AS
	BEGIN
		DECLARE @Result VARCHAR(60)
			BEGIN
				SET @Result = (SELECT Nombre FROM RolTB WHERE IdRol=@IdRol)	
			END
			RETURN @Result
	END

















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombre_Tipo_Documento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Fc_Obtener_Nombre_Tipo_Documento]
	(
	 @IdTipoDocumento int
	)
	RETURNS VARCHAR(100)
	AS
	BEGIN
		DECLARE @Result VARCHAR(100)
			BEGIN
				SET @Result = (SELECT Nombre FROM TipoDocumentoTB WHERE IdTipoDocumento = @IdTipoDocumento)	
			END
			RETURN @Result
	END













GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Nombres_Empleado]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Nombres_Empleado]
(
@idProveedor varchar(12)
) returns varchar(100)

as
	begin
		declare @datos varchar(100)
		set @datos=	(select Nombres from EmpleadoTB where IdEmpleado = @idProveedor)
		return @datos
	end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_NumeroDocumento_Cliente]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_Obtener_NumeroDocumento_Cliente]
(
@idCliente varchar(12)
) returns varchar(100)

as
	begin
		declare @datos varchar(20)
		set @datos=	(select NumeroDocumento from ClienteTB where IdCliente = @idCliente)
		return @datos
	end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Provincia]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Provincia]
	(
	 @IdUbigeo int
	)
	RETURNS VARCHAR(60)
	AS
	BEGIN
		DECLARE @Result VARCHAR(60),@TmpResult varchar(60)
			BEGIN
				SET @TmpResult = (SELECT Provincia FROM UbigeoTB WHERE IdUbigeo = @IdUbigeo)	
				SET @Result = ISNULL(@TmpResult,'')
			END
			RETURN @Result
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Simbolo_Moneda]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fc_Obtener_Simbolo_Moneda]
	(
	 @IdMoneda int
	)
	RETURNS VARCHAR(10)
	AS
	BEGIN
		DECLARE @Result VARCHAR(10)
			BEGIN
				SET @Result = (SELECT Simbolo FROM MonedaTB WHERE IdMoneda = @IdMoneda)	
			END
			RETURN @Result
	END




















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Obtener_Ubigeo]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Obtener_Ubigeo]
	(
	 @IdUbigeo int
	)
	RETURNS VARCHAR(10)
	AS
	BEGIN
		DECLARE @Result VARCHAR(10),@TmpResult varchar(10)
			BEGIN
				SET @TmpResult = (SELECT Ubigeo FROM UbigeoTB WHERE IdUbigeo = @IdUbigeo)	
				set @Result = ISNULL(@TmpResult,'')
			END
			RETURN @Result
	END










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Produccion_Nrm_Orden_Numerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fc_Produccion_Nrm_Orden_Numerico] ()  returns int
	as
		begin
		declare @Incremental int,@ValorActual int,@CodGenerado int
			begin
				if EXISTS(select NumeroOrden from ProduccionTB)
					begin					
						set @ValorActual = (select MAX(NumeroOrden) from ProduccionTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1						
						set @CodGenerado = @Incremental
					end
				else
					begin
						set @CodGenerado = 1
					end
			end
			return @CodGenerado
		end




GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Producir_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_Producir_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdProduccion from ProduccionTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdProduccion,'PR',''),'','')AS INT)) from ProduccionTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'PR000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'PR00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'PR0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'PR'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'PR0001'
					end
			end
			return @CodGenerado
		end




GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Proveedor_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Proveedor_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Length int,@Incremental int,@ValorActual varchar(12),@ValorNuevo varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdProveedor from ProveedorTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdProveedor,'PR',''),'','')AS INT)) from ProveedorTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'PR000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'PR00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'PR0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'PR'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'PR0001'
					end
			end
			return @CodGenerado
		end

























GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Rol_Generar_Codigo]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_Rol_Generar_Codigo] ()returns int
as
	begin 
		declare @NewCodigo int,@CodGenerado int
		if exists(select * from RolTB)
			begin
				set @NewCodigo = (select Max(IdRol) from RolTB)				
				set @CodGenerado=@NewCodigo+1					
			end		
		else
			begin
				set @CodGenerado = 1
			end
		return @CodGenerado
	end
















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Serie_Numero]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Fc_Serie_Numero]( @IdTipoDocumento int) returns varchar(50)
as
	begin
		declare @Serie varchar(50),@Numeracion int,@ResultNumeracion varchar(16)
		declare @AuxNumeracion varchar(16),@Aumentado int
		set @Serie = (select Serie from TipoDocumentoTB where IdTipoDocumento = @IdTipoDocumento)		
		if exists(select * from ComprobanteTB where Serie = @Serie)
			begin
				set @AuxNumeracion = (select MAX(CAST(REPLACE(REPLACE(Numeracion,'',''),'','')AS INT))  from ComprobanteTB  where Serie = @Serie)
				set @Aumentado = CONVERT(INT,@AuxNumeracion) +1
				set @ResultNumeracion =  convert(varchar, @Aumentado)		
			end
		else
			begin
			   set @Numeracion = (select Numeracion from TipoDocumentoTB where IdTipoDocumento = @IdTipoDocumento)
			   
				set @ResultNumeracion = convert(varchar, @Numeracion)
			end
		return @Serie+'-'+@ResultNumeracion
	end







GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Suministro_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fc_Suministro_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdSuministro from SuministroTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdSuministro,'SM',''),'','')AS INT)) from SuministroTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'SM000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'SM00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'SM0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'SM'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'SM0001'
					end
			end
			return @CodGenerado
		end

















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Ticket_Codigo_Numerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Ticket_Codigo_Numerico] ()  returns int
	as
		begin
		declare @Incremental int,@ValorActual  int,@CodGenerado int
			begin
				if EXISTS(select idTicket from TicketTB)
					begin					
						set @ValorActual = (select MAX(idTicket) from TicketTB)
						set @Incremental = @ValorActual +1						
						set @CodGenerado = @Incremental
						
					end
				else
					begin
						set @CodGenerado = 1
					end
			end
			return @CodGenerado
		end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Transaccion_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Transaccion_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdTransaccion from TransaccionTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdTransaccion,'TA-',''),'','')AS INT)) from TransaccionTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'TA-000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'TA-00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'TA-0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'TA-'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'TA-0001'
					end
			end
			return @CodGenerado
		end










GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Venta_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Fc_Venta_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdVenta from VentaTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdVenta,'VT',''),'','')AS INT)) from VentaTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'VT000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'VT00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'VT0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'VT'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'VT0001'
					end
			end
			return @CodGenerado
		end


















GO
/****** Object:  UserDefinedFunction [dbo].[Fc_Venta_Credito_Codigo_Alfanumerico]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fc_Venta_Credito_Codigo_Alfanumerico] ()  returns varchar(12)
	as
		begin
		declare @Incremental int,@ValorActual varchar(12),@CodGenerado varchar(12)
			begin
				if EXISTS(select IdVentaCredito from VentaCreditoTB)
					begin					
						set @ValorActual = (select MAX(CAST(REPLACE(REPLACE(IdVentaCredito,'VC',''),'','')AS INT)) from VentaCreditoTB)
						set @Incremental = CONVERT(INT,@ValorActual) +1
						if(@Incremental <= 9)
							begin
								set @CodGenerado = 'VC000'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=10 and @Incremental<=99)
							begin
								set @CodGenerado = 'VC00'+CONVERT(VARCHAR,@Incremental)
							end
						else if(@Incremental>=100 and @Incremental<=999)
							begin
								set @CodGenerado = 'VC0'+CONVERT(VARCHAR,@Incremental)
							end
						else
							begin
								set @CodGenerado = 'VC'+CONVERT(VARCHAR,@Incremental)
							end
					end
				else
					begin
						set @CodGenerado = 'VC0001'
					end
			end
			return @CodGenerado
		end




GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Obtener_Cliente_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Fx_Obtener_Cliente_By_Id]
(
@Cliente varchar(12)
) returns varchar(60)

as
	begin
		declare @datos varchar(60)
		set @datos=	(select Informacion from ClienteTB where IdCliente = @Cliente)
		return @datos
	end






















GO
/****** Object:  StoredProcedure [dbo].[ListarProduccion]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[ListarProduccion]
as
begin
SELECT
                    p.IdProduccion,
                    p.FechaProduccion,
                    p.HoraProduccion,
					p.FechaInicio,
					p.FechaTermino,
                    p.IdSuministro,
                    p.NumeroOrden,
                    p.Estado,
                    p.TipoOrden,
                    s.Clave,
                   s.NombreMarca
                    FROM ProduccionTB AS p INNER JOIN SuministroTB AS s ON p.IdSuministro = s.IdSuministro
end




GO
/****** Object:  StoredProcedure [dbo].[Sp_Compra_For_Editar]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Compra_For_Editar]
@IdCompra varchar(12)
as
	begin
		select IdCompra,Proveedor,
		dbo.Fc_Obtener_Datos_Proveedor(Proveedor)as DatosProveedor,
		FechaCompra,Serie,Numeracion,TipoMoneda,Observaciones,Notas 
		from CompraTB WHERE IdCompra = @IdCompra
	end













GO
/****** Object:  StoredProcedure [dbo].[Sp_Crud_Detalle]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Crud_Detalle]
@IdDetalle int,
@IdMantenimiento varchar(10),
@IdAuxiliar varchar(10),
@Nombre varchar(60),
@Descripcion varchar(100),
@Estado char(1),
@UsuarioRegistro varchar(15),
@Message varchar(20) out
as

	begin
		begin try
			begin transaction
				if exists(select IdDetalle,IdMantenimiento from DetalleTB where IdDetalle=@IdDetalle and IdMantenimiento=@IdMantenimiento)
					begin
						if exists(select IdDetalle,IdMantenimiento from DetalleTB where IdDetalle<>@IdDetalle and IdMantenimiento=@IdMantenimiento and Nombre = @Nombre)
							begin
								rollback
								set @Message = 'duplicate'
							end
						else
							begin
								update DetalleTB set IdAuxiliar=UPPER(@IdAuxiliar),Nombre=UPPER(@Nombre),Descripcion=UPPER(@Descripcion),Estado=@Estado
								where IdDetalle =@IdDetalle and IdMantenimiento = @IdMantenimiento
								commit
								set @Message = 'updated'
							end
					end
				else
					begin
						if exists(select Nombre from DetalleTB where IdMantenimiento = @IdMantenimiento and Nombre = @Nombre)
							begin
								rollback
								set @Message = 'duplicate'
							end
						else
							begin
								insert into DetalleTB(IdDetalle,IdMantenimiento,IdAuxiliar,Nombre,Descripcion,Estado,UsuarioRegistro)
								values(dbo.Fc_Detalle_Generar_Codigo(@IdMantenimiento),@IdMantenimiento,UPPER(@IdAuxiliar),UPPER(@Nombre),UPPER(@Descripcion),@Estado,@UsuarioRegistro)
								commit
								set @Message = 'registered'
							end
					end
		end try

		begin catch
			rollback
			set @Message='error'
		end catch
		
	end




















GO
/****** Object:  StoredProcedure [dbo].[Sp_Crud_Directorio]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Crud_Directorio]
@IdDirectorio bigint,
@Atributo int,
@Valor varchar(100),
@IdPersona varchar(12),
@Message varchar(20) out
as
	begin
		begin try
			begin transaction
				if exists(select * from DirectorioTB where IdDirectorio = @IdDirectorio)
					begin
						update DirectorioTB set Atributo =@Atributo,
						Valor=@Valor				
						where IdDirectorio = @IdDirectorio
						commit 
						set @Message = 'updated'
					end
				else
					begin
						insert into DirectorioTB(Atributo,Valor,IdPersona)
						values(@Atributo,@Valor,@IdPersona)
						commit
						set @Message = 'registered'
					end
		end try

		begin catch
			rollback
			set @Message='error'
		end catch

	end

























GO
/****** Object:  StoredProcedure [dbo].[Sp_Crud_Mantenimiento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Crud_Mantenimiento]
@IdMantenimiento varchar(10),
@Nombre varchar(100),
@Estado char(1),
@UsuarioRegistro varchar(15),
@Message varchar(20) out
as
	begin
		begin try
			begin tran	
				if exists(select IdMantenimiento from MantenimientoTB where IdMantenimiento = @IdMantenimiento)
					begin
						if exists(select Nombre,IdMantenimiento from MantenimientoTB where IdMantenimiento <> @IdMantenimiento and Nombre = @Nombre)
							begin								
								rollback
								set @Message = 'duplicate'
							end
						else
							begin
								update MantenimientoTB set Nombre=UPPER(@Nombre) where IdMantenimiento = @IdMantenimiento
								commit
								set @Message = 'updated'
							end
					end
				else
					begin
						if exists(select Nombre,IdMantenimiento from MantenimientoTB where IdMantenimiento <> @IdMantenimiento and Nombre = @Nombre)
							begin
								rollback
								set @Message = 'duplicate'
							end
						else
							begin
								insert into MantenimientoTB(IdMantenimiento,Nombre,Estado,UsuarioRegistro,FechaRegistro)
								values(dbo.Fc_Mantenimiento_Generar_Codigo(),UPPER(@Nombre),@Estado,@UsuarioRegistro,GETDATE())
								commit
								set @Message = 'registered'
							end

						
					end						
		end try

		begin catch
			rollback
			set @Message='error'
		end catch
	end

























GO
/****** Object:  StoredProcedure [dbo].[Sp_Detalle_Compra_For_Editar]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Detalle_Compra_For_Editar]
@IdCompra varchar(12)
as
	begin
		select d.IdArticulo,s.Clave,s.NombreMarca,d.Cantidad,d.PrecioCompra,
		d.Descuento,d.Importe,d.IdImpuesto,d.NombreImpuesto,d.ValorImpuesto,d.Descripcion 
		from DetalleCompraTB as d inner join SuministroTB as s on d.IdArticulo = s.IdSuministro 
		where d.IdCompra = @IdCompra
	end













GO
/****** Object:  StoredProcedure [dbo].[Sp_Generar_Excel_Ventas]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Generar_Excel_Ventas]
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@Facturado int
AS
SELECT td.Nombre,v.Serie,v.Numeracion,v.FechaVenta,
            dbo.Fc_Obtener_Nombre_Detalle(c.TipoDocumento,'0003') TipoDocumento,
            c.NumeroDocumento,c.Informacion as Cliente,	
            dbo.Fc_Obtener_Nombre_Detalle(v.Tipo,'0015') Tipo,
            dbo.Fc_Obtener_Nombre_Detalle(v.Estado,'0009') EstadoName,
            dbo.Fc_Obtener_Simbolo_Moneda(v.Moneda) as Simbolo,
            v.Estado,v.Total 
            from VentaTB as v
            inner join TipoDocumentoTB as td on v.Comprobante = td.IdTipoDocumento
            inner join ClienteTB as c on v.Cliente = c.IdCliente
            inner join EmpleadoTB as e on v.Vendedor = e.IdEmpleado
            where
            @Facturado = 1 and FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.Facturacion = 1 
            or 
            @Facturado = 0 and FechaVenta BETWEEN @FechaInicial AND @FechaFinal




GO
/****** Object:  StoredProcedure [dbo].[Sp_Generar_Listardo_CodBar]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Generar_Listardo_CodBar] 
@UnidadVenta tinyint,
@Categoria int
as
	begin
		SELECT Clave,ClaveAlterna,NombreMarca,UnidadVenta,Categoria
         FROM ArticuloTB
		 WHERE (@UnidadVenta = 0 and @Categoria = 0) 
		 or 
		 (UnidadVenta = @UnidadVenta and @Categoria = 0) 
		 or
		 (UnidadVenta = @UnidadVenta and Categoria = @Categoria) 
		 or
		 (@UnidadVenta = 0 and Categoria = @Categoria) 
	end




















GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Cliente_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Cliente_By_Id]
@IdCliente varchar(12)
as
	begin
		select ci.IdCliente,ci.TipoDocumento,ci.NumeroDocumento,ci.Informacion,
		ci.Telefono,ci.Celular,ci.Email,ci.Direccion,ci.Representante,ci.Estado
		from ClienteTB as ci
		where ci.IdCliente = @IdCliente
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Detalle_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Detalle_Id]
@IdMantenimiento varchar(10)
as
	begin
		select IdDetalle,Nombre from DetalleTB where IdMantenimiento = @IdMantenimiento order by Nombre asc
	end


















GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Detalle_IdNombre]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Detalle_IdNombre]
@Opcion char(1),
@IdMantenimiento varchar(10),
@Nombre varchar(60)
as
	begin
		if(@Opcion = '1')
			begin
				select IdDetalle,Nombre from DetalleTB where IdMantenimiento = @IdMantenimiento and Nombre <> @Nombre
			end
		else if(@Opcion = '2')
			begin
				select IdDetalle,Nombre from DetalleTB where IdMantenimiento = @IdMantenimiento
			end
		else if(@Opcion = '3')
			begin
				select IdDetalle,Nombre,Descripcion from DetalleTB where IdMantenimiento = @IdMantenimiento
			end
		else if(@Opcion = '4')
			begin
				select IdDetalle,Nombre,Descripcion from DetalleTB
				 where (IdMantenimiento = @IdMantenimiento and @Nombre = '')
				 or
				 (IdMantenimiento = @IdMantenimiento and Nombre like '%'+@Nombre+'%') 
			end
		else
			begin
				select IdDetalle,Nombre from DetalleTB where IdMantenimiento = @IdMantenimiento and Nombre = @Nombre
			end
		
	end























GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Directorio_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Get_Directorio_By_Id]
@IdPersona varchar(12)
as
	begin
		select IdDirectorio,Atributo,dbo.Fc_Obtener_Nombre_Detalle(Atributo,'0002')as Nombre,Valor,IdPersona
		 from DirectorioTB
		where IdPersona=@IdPersona
	end

























GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Movimiento_Inventario_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Movimiento_Inventario_By_Id]
@idMovimientoInventario varchar(12)
as
	select UPPER(tm.Nombre) as TipoMovimiento,mv.Fecha, mv.Hora, mv.TipoAjuste, mv.TipoMovimiento as TipoMovimientoId,
	UPPER(mv.Observacion) as Observacion,
	case
		when mv.Estado = 0 then 'EN PROCESO'
		when mv.Estado = 1 then 'COMPLETADO'
		when mv.Estado = 2 then 'CANCELADO'
	end as Estado,
	isnull(mv.CodigoVerificacion,'') as CodigoVerificacion
	from MovimientoInventarioTB mv inner join TipoMovimientoTB as tm on mv.TipoMovimiento = tm.IdTipoMovimiento
	where mv.IdMovimientoInventario = @idMovimientoInventario 







GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Proveedor_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Proveedor_By_Id]
@NumeroDocumento varchar(20)
as
	begin
		select IdProveedor,TipoDocumento,NumeroDocumento,RazonSocial,NombreComercial,Ambito,Estado,
		Telefono,Celular,Email,PaginaWeb,Direccion,Representante
		 from ProveedorTB where NumeroDocumento = @NumeroDocumento
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Suministro_For_Asignacion_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Suministro_For_Asignacion_By_Id]
@IdSuministro varchar(12)
as
	begin
		select IdSuministro,Clave,NombreMarca,Cantidad,dbo.Fc_Obtener_Nombre_Detalle(UnidadCompra,'0013') as UnidadCompraNombre,
		PrecioCompra,PrecioVentaGeneral
		from SuministroTB
		where IdSuministro = @IdSuministro
	end


















GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Suministro_For_Movimiento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Get_Suministro_For_Movimiento]
@IdSuministro varchar(12)
as
	begin
		select IdSuministro,Clave,NombreMarca,StockMinimo,Cantidad,
		dbo.Fc_Obtener_Nombre_Detalle(UnidadCompra,'0013') as UnidadCompraNombre,
		dbo.Fc_Obtener_Nombre_Detalle(Marca,'0007') AS MarcaNombre,
		PrecioCompra,Impuesto,PrecioVentaGeneral,
		Inventario,ValorInventario 
		from SuministroTB
		where IdSuministro = @IdSuministro
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_List_Table_Detalle]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_List_Table_Detalle]
@IdMantenimiento varchar(10),
@Nombre varchar(60)
as
	begin
		select IdDetalle,IdAuxiliar,Nombre,Descripcion,Estado from DetalleTB 
		where (IdMantenimiento = @IdMantenimiento and @Nombre = '') or (IdMantenimiento = @IdMantenimiento and Nombre like @Nombre+'%')
	end




















GO
/****** Object:  StoredProcedure [dbo].[Sp_List_Table_Matenimiento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_List_Table_Matenimiento]
@Nombre varchar(100)
as
	begin
		select IdMantenimiento,Nombre,Validar from MantenimientoTB 
		where 
		(Nombre like @Nombre+'%' and Estado <> '0')
		 or (@Nombre = '' and Estado <> '0')
	end




















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Banco_Historial]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Banco_Historial]
@IdBanco varchar(12)
as
	begin
		select IdBanco,[dbo].Fc_Obtener_Datos_Empleado(IdEmpleado) as Empleado,Descripcion,Fecha,Hora,Entrada,Salida from BancoHistorialTB where IdBanco = @IdBanco
	end













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Bancos]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Listar_Bancos]
@search varchar(100)
AS
	BEGIN
	   SELECT 
	   IdBanco
      ,NombreCuenta
      ,NumeroCuenta
      ,dbo.Fc_Obtener_Simbolo_Moneda(IdMoneda) as Simbolo
      ,SaldoInicial
      ,Descripcion
	  ,Sistema
	  ,FormaPago
	  FROM Banco
	  WHERE 
	  (@search = '')
	  or
	  (NombreCuenta like @search +'%' )
	  or 
	  (NumeroCuenta like @search +'%')

	END













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ciudad]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ciudad] 
@PaisCodigo char(3)
as
	begin
		select IdCiudad,Departamento from CiudadTB where PaisCodigo = @PaisCodigo order by Departamento
	end
























GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Clientes]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Clientes]
@search varchar(55)
as
select ci.IdCliente,ci.NumeroDocumento,ci.Informacion,ci.Telefono,
ci.Celular,ci.Direccion,ci.Representante,dbo.Fc_Obtener_Nombre_Detalle(ci.Estado,'0001') as Estado,
ci.Predeterminado
from ClienteTB as ci 
where
	(@search = '')  
	or 
	(ci.NumeroDocumento like @search+'%')
	OR
	(ci.Informacion LIKE @search+'%')
	













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Clientes_Venta]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Clientes_Venta]
@search varchar(55)
as
select ci.IdCliente,dbo.Fc_Obtener_Nombre_Detalle(TipoDocumento,'0003') as Documento,ci.NumeroDocumento,
ci.Informacion,ci.Direccion
from ClienteTB as ci
where 
	(@search = '')  
	or 
	(ci.NumeroDocumento like @search+'%')
	or 
	(ci.Informacion LIKE @search+'%')













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Compras]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Compras]
@Opcion bigint,
@Search varchar(100),
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@EstadoCompra int
as
select c.IdCompra,p.IdProveedor,
			c.FechaCompra,c.HoraCompra,
			c.Serie,c.Numeracion,
			p.NumeroDocumento,p.RazonSocial,
			c.TipoCompra,
			dbo.Fc_Obtener_Nombre_Detalle(c.TipoCompra,'0015') Tipo,
			c.EstadoCompra,
			dbo.Fc_Obtener_Nombre_Detalle(c.EstadoCompra,'0009') Estado,
			dbo.Fc_Obtener_Simbolo_Moneda(c.TipoMoneda) as Simbolo,sum(d.Importe) as'Total'
			from CompraTB as c inner join ProveedorTB as p			
			on c.Proveedor = p.IdProveedor
			inner join DetalleCompraTB as d on d.IdCompra = c.IdCompra
			where (@Search = '' and @Opcion = 0)
				or (c.Serie like @Search+'%' and @Opcion = 0) 
				or (c.Numeracion like @Search+'%' and @Opcion = 0) 
				or (p.NumeroDocumento like @Search+'%' and @Opcion = 0) 
				or (p.RazonSocial like '%'+@Search+'%' and @Opcion = 0)
				or (CAST(c.FechaCompra as Date) BETWEEN @FechaInicial and @FechaFinal and @Opcion = 1)
				or (CAST(c.FechaCompra as Date) BETWEEN @FechaInicial and @FechaFinal and c.EstadoCompra = @EstadoCompra and @Opcion = 2) 
				group by c.IdCompra,p.IdProveedor,
			c.FechaCompra,c.HoraCompra,
			c.Serie,c.Numeracion,
			p.NumeroDocumento,p.RazonSocial,
			c.TipoCompra,c.EstadoCompra,c.TipoMoneda
	order by c.FechaCompra desc,c.HoraCompra desc










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Compras_Credito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Compras_Credito]
@Search varchar(100),
@FechaInicio varchar(20),
@FechaFinal varchar(20),
@Opcion tinyint
as
	select
			c.IdCompra,p.IdProveedor,
			c.FechaCompra,c.HoraCompra,
			c.Serie,c.Numeracion,
			p.NumeroDocumento,p.RazonSocial,
			c.EstadoCompra,
			dbo.Fc_Obtener_Nombre_Detalle(c.EstadoCompra,'0009') Estado,
			dbo.Fc_Obtener_Simbolo_Moneda(c.TipoMoneda) as Simbolo,
			sum(d.Importe) as MontoTotal,(select isnull(sum(cc.Monto),0) from CompraCreditoTB as cc where cc.IdCompra = c.IdCompra) as MontoPagado
			from CompraTB as c 
			inner join ProveedorTB as p on c.Proveedor = p.IdProveedor	
			inner join DetalleCompraTB as d on d.IdCompra = c.IdCompra
			where
			 (@Opcion = 0 and c.TipoCompra = 2 and @Search = '') 
			 or 
			 (@Opcion = 0 and c.TipoCompra = 2 and p.NumeroDocumento like @Search+'%' )
			 or 
			 (@Opcion = 0 and c.TipoCompra = 2 and p.RazonSocial like @Search+'%' )
			 or 
			 (@Opcion = 0 and c.TipoCompra = 2 and c.Serie like @Search+'%' )
			 or 
			 (@Opcion = 0 and c.TipoCompra = 2 and c.Numeracion like @Search+'%' )
			  or 
			 (@Opcion = 0 and c.TipoCompra = 2 and CONCAT(c.Serie,'-',c.Numeracion) like @Search+'%' )
			 or 
			 (@Opcion = 1 and c.TipoCompra = 2 and c.FechaCompra between @FechaInicio and @FechaFinal )
			 group by c.IdCompra,p.IdProveedor,
			c.FechaCompra,c.HoraCompra,
			c.Serie,c.Numeracion,c.EstadoCompra,
			p.NumeroDocumento,p.RazonSocial,
			c.EstadoCompra,c.TipoMoneda
	order by c.FechaCompra desc,c.HoraCompra desc










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Compras_For_Movimiento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Compras_For_Movimiento] 
@Search varchar(120),
@fecha varchar(20),
@Opcion tinyint
as
	select c.IdCompra,c.FechaCompra,c.HoraCompra,
	c.Numeracion,p.RazonSocial,
	dbo.Fc_Obtener_Simbolo_Moneda(c.TipoMoneda) as Simbolo,
	sum(d.Importe) as Total
	from CompraTB as c inner join ProveedorTB as p 
	on c.Proveedor = p.IdProveedor
	inner join DetalleCompraTB as d
	on d.IdCompra = c.IdCompra
	where 
	(@Search = '' and @fecha = '' and c.EstadoCompra != 3)
	or (c.Numeracion like @Search+'%' and @Opcion = 0 and c.EstadoCompra != 3) 
	or (p.NumeroDocumento like @Search+'%' and @Opcion = 0 and c.EstadoCompra != 3) 
	or (p.RazonSocial like '%'+@Search+'%' and @Opcion = 0 and c.EstadoCompra != 3)
	or (cast(c.FechaCompra as date) = @fecha and @Opcion = 1 and c.EstadoCompra != 3)
	group by c.IdCompra,c.FechaCompra,c.HoraCompra,
	c.Numeracion,p.RazonSocial,c.TipoMoneda
	order by c.FechaCompra desc,c.HoraCompra desc


















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Cotizacion]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Cotizacion]
@Opcion tinyint,
@Buscar varchar(100),
@FechaInicial varchar(20),
@FechaFinal varchar(20)
as
	begin
		select co.IdCotizacion,co.FechaCotizacion,co.HoraCotizacion,
		em.Apellidos,em.Nombres,cl.Informacion,
		dbo.Fc_Obtener_Simbolo_Moneda(co.IdMoneda) as SimboloMoneda,co.Total
		from CotizacionTB as co 
		inner join ClienteTB as cl on co.IdCliente = cl.IdCliente
		inner join EmpleadoTB as em on co.IdVendedor=em.IdEmpleado
		where 
		@Opcion = 1  and FechaCotizacion = cast(getdate() as date)
		or
		@Opcion = 2 and @Buscar <> '' and @Buscar like co.IdCotizacion+'%'
		or
		@Opcion = 3 and FechaCotizacion between @FechaInicial and @FechaFinal
		order by co.FechaCotizacion desc,co.HoraCotizacion desc
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Detalle_Compra]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Detalle_Compra]
@IdCompra varchar(12)
as
select s.IdSuministro,
s.Clave,s.NombreMarca,dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') as UnidadCompra,s.UnidadVenta,
d.Cantidad,d.PrecioCompra,d.Descuento,d.IdImpuesto,d.ValorImpuesto
from DetalleCompraTB as d inner join SuministroTB as s
on d.IdArticulo = s.IdSuministro
where d.IdCompra = @IdCompra













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Detalle_Compra_By_IdCompra]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Detalle_Compra_By_IdCompra]
@IdCompra varchar(12)
as
	begin
		SELECT s.IdSuministro,s.Clave,s.NombreMarca,s.Cantidad,
		dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') as UnidadCompraNombre,
		s.PrecioCompra,s.PrecioVentaGeneral,
		dbo.Fc_Obtener_Nombre_Detalle(s.Categoria,'0006') as Categoria,
		dbo.Fc_Obtener_Nombre_Detalle(s.Estado,'0001') as Estado,
		s.Inventario,s.ValorInventario 
		FROM DetalleCompraTB as d INNER JOIN SuministroTB AS s ON d.IdArticulo = s.IdSuministro 
		WHERE d.IdCompra = @IdCompra
	end


















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Detalle_Compra_Credito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Listar_Detalle_Compra_Credito]
@IdCompra varchar(12)
as
	begin
		select c.IdCompraCredito,c.FechaPago,c.HoraPago,c.Estado,isnull(c.Observacion,'') as Observacion,c.Monto,
		isnull(e.NumeroDocumento,'') as NumeroDocumento,isnull(e.Apellidos,'') as Apellidos,isnull(e.Nombres,'') as Nombres
		from CompraCreditoTB as c left join EmpleadoTB as e on e.IdEmpleado = c.IdCompra
		where c.IdCompra = @IdCompra
	end



GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Detalle_Venta_Credito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Detalle_Venta_Credito]
@IdVenta varchar(12)
as
	begin
		select v.IdVentaCredito,v.FechaPago,v.HoraPago,v.Estado,v.Observacion,v.Monto,
		isnull(e.NumeroDocumento,'') as NumeroDocumento,isnull(e.Apellidos,'') as Apellidos,isnull(e.Nombres,'') as Nombres
		from VentaCreditoTB as v left join EmpleadoTB as e on v.IdUsuario = e.IdEmpleado
		where v.IdVenta = @IdVenta
	end




GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Directorio]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Directorio]
@search varchar(50)
as
	begin
		(select pe.IdPersona as Codigo,dbo.Fc_Obtener_Nombre_Detalle(pe.TipoDocumento,'0003') as Tipo,pe.NumeroDocumento as Documento,CONCAT(pe.ApellidoPaterno,' ',pe.ApellidoMaterno,' ',pe.PrimerNombre,' ',pe.SegundoNombre) as Datos
		 from PersonaTB as pe inner join DirectorioTB as di
		on pe.IdPersona = di.IdPersona

		where (@search = '') or (pe.NumeroDocumento like @search+'%')
		)
		union
		(select pr.IdProveedor as Codigo,dbo.Fc_Obtener_Nombre_Detalle(pr.TipoDocumento,'0003') as Tipo,pr.NumeroDocumento as Documento,pr.RazonSocial as Datos 
		from ProveedorTB as pr inner join DirectorioTB as di
		on pr.IdProveedor = di.IdPersona
		where (@search = '') or (pr.NumeroDocumento like @search+'%')
		)
	end























GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Distrito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Listar_Distrito]
@IdProvincia int
as
	begin
		select IdDistrito,Distrito from DistritoTB where IdProvincia = @IdProvincia order by Distrito
	end
























GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Empleados]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Empleados]
@search varchar(55)
as
select ROW_NUMBER() over( order by IdEmpleado desc) as Filas,IdEmpleado,
NumeroDocumento,Apellidos,Nombres,Telefono,Celular,
dbo.Fc_Obtener_Nombre_Detalle(Puesto,'0012') as Puesto,
dbo.Fc_Obtener_Nombre_Rol(Rol) as Rol,
dbo.Fc_Obtener_Nombre_Detalle(Estado,'0001') as Estado
 from EmpleadoTB 
where (@search = '')  or (NumeroDocumento like @search+'%')
or (
			(Apellidos LIKE @search+'%')
			or
			(Nombres LIKE @search+'%')
			or
			(CONCAT(Apellidos,' ',Nombres) LIKE @search+'%')
		)














GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Etiquetas_By_Type]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Listar_Etiquetas_By_Type]
@type int
as
	begin
		select et.idEtiqueta,et.nombre,td.nombre as nombretipo,et.predeterminado,et.medida,et.ruta,et.imagen 
		from EtiquetaTB as et inner join TipoEtiquetaTB as td on et.tipo = td.idTipoEtiqueta
		where (@type = 0) or (et.tipo = @type)
	end



















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_GuiaRemision]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_GuiaRemision]
@Opcion tinyint,
@Buscar varchar(100),
@FechaInicial varchar(20),
@FechaFinal varchar(20)
as
	begin
		select gui.IdGuiaRemision,
		em.NumeroDocumento as NumeroDocumentoVendedor,
		em.Apellidos as ApellidosVendedor,em.Nombres as NombresVendedor,
		gui.Serie,gui.Numeracion,gui.FechaTraslado,gui.HoraTraslado,
		cl.NumeroDocumento,cl.Informacion
		from GuiaRemisionTB as gui 
		inner join ClienteTB as cl on gui.IdCliente = cl.IdCliente
		inner join EmpleadoTB as em on gui.IdVendedor = em.IdEmpleado
		where 
		@Opcion = 1  and gui.FechaTraslado = cast(getdate() as date)
		or
		@Opcion = 2 and @Buscar <> '' and @Buscar like gui.Serie+'%'
		or
		@Opcion = 2 and @Buscar <> '' and @Buscar like gui.Numeracion+'%'
		or
		@Opcion = 2 and @Buscar <> '' and @Buscar like concat(gui.Serie,'-',gui.Numeracion)+'%'
		or
		@Opcion = 3 and gui.FechaTraslado between @FechaInicial and @FechaFinal
		order by gui.FechaTraslado desc,gui.HoraTraslado desc
	end








GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_GuiaRemision_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_GuiaRemision_ById] 
@IdGuiaRemision varchar(12)
as
	begin
		select gui.IdGuiaRemision,gui.Serie,gui.Numeracion,
		cl.NumeroDocumento,cl.Informacion,cl.Celular,cl.Email,cl.Direccion,
		dbo.Fc_Obtener_Nombre_Detalle(gui.IdMotivoTraslado,'0017') as MotivoTraslado,
		dbo.Fc_Obtener_Nombre_Detalle(gui.IdModalidadTraslado,'0018') as ModalidadTraslado,
		gui.FechaTraslado,gui.HoraTraslado,gui.Peso,gui.NumeroBultos,gui.NumeroDocumentoConductor,
		gui.NombresConductor,gui.TelefonoConducto,gui.NumeroPlaca,gui.MarcaVehiculo,
		gui.DireccionPartida,
		concat(ub1.Departamento,' - ',ub1.Provincia,' - ',ub1.Distrito) as UbigeoPartida,
		gui.DireccionLlegada,
		concat(ub2.Departamento,' - ',ub2.Provincia,' - ',ub2.Distrito) as UbigeoLlegada,
		dbo.Fc_Obtener_Nombre_Detalle(gui.IdTipoComprobante,'0003') as ComprobanteAsociado,
		gui.SerieFactura,gui.NumeracionFactura
		from GuiaRemisionTB  as gui inner join ClienteTB as cl on gui.IdCliente = cl.IdCliente
		inner join UbigeoTB as ub1 on gui.IdUbigeoLlegada  = ub1.IdUbigeo
		inner join UbigeoTB as ub2 on gui.IdUbigeoPartida = ub2.IdUbigeo
		where IdGuiaRemision = @IdGuiaRemision
	end








GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Impuesto_Calculo]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Impuesto_Calculo]
as
begin
select IdImpuesto,dbo.Fc_Obtener_Nombre_Detalle(Operacion,'0010') as OperacionNombre,Operacion,Nombre,Valor,Predeterminado,Sistema from [dbo].[ImpuestoTB]
end












GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Impuestos]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Impuestos]
as
begin
select IdImpuesto,dbo.Fc_Obtener_Nombre_Detalle(Operacion,'0010') as Operacion,
Nombre,Valor,Predeterminado,Codigo,Sistema 
from [dbo].[ImpuestoTB]
end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Insumo]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Insumo] 
@Buscar varchar(100)
as
SELECT
                    i.IdInsumo,
                    i.Clave,
                    i.ClaveAlterna,
                    i.NombreMarca,
                    isnull(m.Nombre,'SIN UNIDAD') as Medida,
                    isnull(c.Nombre,'SIN CATEGORIA') as Categoria,
                    i.Cantidad,
                    i.Costo
                    FROM InsumoTB as i
                    left outer join DetalleTB as m on i.Medida = m.IdDetalle and m.IdMantenimiento = '0013'
                    left outer join DetalleTB as c on i.Categoria = c.IdDetalle and c.IdMantenimiento = '0006'
					WHERE @Buscar = ''
					 OR (@Buscar <> ''  AND Clave LIKE @Buscar+'%' )
					 OR (@Buscar <> '' AND NombreMarca LIKE @Buscar+'%')




GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Inventario_Articulos]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Inventario_Articulos]
as
	select
	IdArticulo,Clave,NombreMarca,PrecioCompra,
	Cantidad,
	dbo.Fc_Obtener_Nombre_Detalle(UnidadCompra,'0013') as UnidadCompra,
	dbo.Fc_Obtener_Nombre_Detalle(Estado,'0001') as Estado,
	(PrecioCompra*Cantidad) as Total 
	from ArticuloTB 
	where Inventario = 1 order by Total desc




















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Inventario_Suministros]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Inventario_Suministros]
@Producto varchar(45),
@Existencia tinyint,
@NombreMarca varchar(120),
@opcion tinyint,
@Categoria int,
@Marca int,
@PosicionPagina smallint,
@FilasPorPagina smallint
as
	begin
		select
		IdSuministro,Clave,ClaveAlterna,NombreMarca,PrecioCompra,
		PrecioVentaGeneral,Cantidad,
		dbo.Fc_Obtener_Nombre_Detalle(UnidadCompra,'0013') as UnidadCompra,
		dbo.Fc_Obtener_Nombre_Detalle(Estado,'0001') as Estado,
		(PrecioCompra*Cantidad) as Total,
		StockMinimo,StockMaximo,
		dbo.Fc_Obtener_Nombre_Detalle(Categoria,'0006') as Categoria,
		dbo.Fc_Obtener_Nombre_Detalle(Marca,'0007') as Marca,
		Inventario,Estado
		from SuministroTB 
		where
		(@Producto = '' and @NombreMarca = '' and @Existencia = 0  and @opcion = 0)
		-------------------------------------------------------------------------------------------------------------
		or (Clave <> '' and Clave = @Producto and @opcion = 1)
		or (ClaveAlterna <> '' and ClaveAlterna = @Producto and @opcion = 1)
		-------------------------------------------------------------------------------------------------------------
		or (NombreMarca like '%'+@NombreMarca+'%' and @opcion = 2)
		-------------------------------------------------------------------------------------------------------------
		or ( @Existencia = 1 and Cantidad <= 0 and @opcion = 3)
		or ( @Existencia = 2 and Cantidad > 0 and Cantidad < StockMinimo and @opcion = 3)
		or ( @Existencia = 3 and Cantidad >= StockMinimo  and Cantidad < StockMaximo and @opcion = 3)
		or ( @Existencia = 4 and Cantidad >= StockMaximo and @opcion = 3)
		------------------------------------------------------------------------------------------------------------- 
		or ( Categoria = @Categoria and @opcion = 4)
		-------------------------------------------------------------------------------------------------------------
		or ( Marca = @Marca and @opcion = 5)
		
		order by IdSuministro asc offset @PosicionPagina rows fetch next @FilasPorPagina rows only
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Inventario_Suministros_Count]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Inventario_Suministros_Count]
@Producto varchar(45),
@Existencia tinyint,
@NombreMarca varchar(120),
@opcion tinyint,
@Categoria int,
@Marca int
as
	begin
		select count(*) as Total from SuministroTB where  
		(@Producto = '' and @NombreMarca = '' and @Existencia = 0  and @opcion = 0)
		-------------------------------------------------------------------------------------------------------------
		or (Clave <> '' and Clave = @Producto and @opcion = 1)
		or (ClaveAlterna <> '' and ClaveAlterna = @Producto and @opcion = 1)
		-------------------------------------------------------------------------------------------------------------
		or (NombreMarca like '%'+@NombreMarca+'%' and @opcion = 2)
		-------------------------------------------------------------------------------------------------------------
		or ( @Existencia = 1 and Cantidad <= 0 and @opcion = 3)
		or ( @Existencia = 2 and Cantidad > 0 and Cantidad < StockMinimo and @opcion = 3)
		or ( @Existencia = 3 and Cantidad >= StockMinimo  and Cantidad < StockMaximo and @opcion = 3)
		or ( @Existencia = 4 and Cantidad >= StockMaximo and @opcion = 3)
		------------------------------------------------------------------------------------------------------------- 
		or ( Categoria = @Categoria and @opcion = 4)
		-------------------------------------------------------------------------------------------------------------
		or ( Marca = @Marca and @opcion = 5)
	end








GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Kardex_Suministro_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Kardex_Suministro_By_Id] 
@opcion tinyint,
@idArticulo varchar(45),
@fechaInicio varchar(15),
@fechaFinal varchar(15)
--@PosicionPagina smallint,
--@FilasPorPagina smallint
as
SELECT k.IdSuministro,k.Fecha,k.Hora,k.Tipo,t.Nombre,
k.Detalle,k.Cantidad,k.Costo,k.Total
FROM KardexSuministroTB AS k INNER JOIN SuministroTB AS a ON k.IdSuministro = a.IdSuministro
inner join TipoMovimientoTB AS t ON k.Movimiento = t.IdTipoMovimiento
WHERE 
	(a.IdSuministro = @idArticulo and @fechaInicio = '' and @fechaFinal = '' and @opcion = 0)
	or
	(a.IdSuministro = @idArticulo and k.Fecha between @fechaInicio and @fechaFinal and @opcion = 1)

	order by k.Fecha asc , k.Hora asc
	--order  by k.Fecha asc , k.Hora asc offset @PosicionPagina rows fetch next @FilasPorPagina rows only










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Lote]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Lote]
@opcion bigint,
@search varchar(60)
as
select ROW_NUMBER() over( order by lo.IdLote desc) as Filas, lo.IdLote,lo.NumeroLote,ar.Clave,ar.NombreMarca,lo.FechaCaducidad,lo.ExistenciaInicial,lo.ExistenciaActual
		from LoteTB as lo inner join SuministroTB as ar
		on lo.IdArticulo = ar.IdSuministro
		where (@search = '' and @opcion = 0)
		 or (lo.NumeroLote like @search+'%' and @opcion = 0) 
		 or (ar.Clave like @search+'%' and @opcion = 0) 
		 or (ar.NombreMarca like '%'+@search+'%' and @opcion = 0)
		 or (GETDATE() <= lo.FechaCaducidad and DATEDIFF(day, GETDATE(), lo.FechaCaducidad)<=15 and @opcion = 1)
		 or	(lo.FechaCaducidad <= CAST(GETDATE() AS DATE) and @opcion = 2)
				 
		 order by lo.FechaCaducidad asc 













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Monedas]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Listar_Monedas]
as
	begin
		select IdMoneda,Nombre,Abreviado,Simbolo,TipoCambio,Predeterminado from MonedaTB
	end





















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Movimiento_Caja_By_IdCaja]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Movimiento_Caja_By_IdCaja]
@IdCaja varchar(12)
as
select format(FechaMovimiento,'dd/MM/yyyyy') as 'FechaMovimiento',
	convert(varchar,cast(HoraMovimiento as time),22) as 'HoraMovimiento',
	Comentario, 
	case TipoMovimiento 
		when 1 then 'MONTO INICIAL' 
		when 2 then 'VENTA CON EFECTIVO'
		when 3 then 'VENTA CON TARJETA'
		when 4 then 'INGRESO DE DINERO'
		when 5 then 'SALIDAS DE DINERO'
	end as 'Concepto',TipoMovimiento,Monto as 'Ingresos' 
	from MovimientoCajaTB where IdCaja = @IdCaja










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Movimiento_Inventario]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Movimiento_Inventario]
@init bit,
@opcion tinyint,
@movimiento int,
@fechaInicial varchar(50),
@fechaFinal varchar(50),
@PosicionPagina smallint,
@FilasPorPagina smallint
as
	select mv.IdMovimientoInventario, mv.Fecha, mv.Hora, mv.TipoAjuste, UPPER(tm.Nombre) as TipoMovimiento, UPPER(mv.Observacion) as Observacion,
	case 
		when mv.Suministro = 1 then 'MOVIMIENTO DE PRODUCTOS'
		when mv.Suministro = 0 then 'MOVIMIENTO DE ARTÍCULOS'
	end as Informacion,
	case
		when mv.Estado = 0 then 'EN PROCESO'
		when mv.Estado = 1 then 'COMPLETADO'
		when mv.Estado = 2 then 'CANCELADO'
	end as Estado
	from MovimientoInventarioTB mv inner join TipoMovimientoTB as tm on mv.TipoMovimiento = tm.IdTipoMovimiento
	where 
		 (@opcion = 1 and @init = 0)
		 or
		 (@opcion = 1 and mv.Fecha between cast(@fechaInicial as date) and cast(@fechaFinal as date) and @movimiento = 0)
		 or
		 (@opcion = 1 and mv.Fecha between cast(@fechaInicial as date) and cast(@fechaFinal as date) and mv.TipoMovimiento = @movimiento)
		
	
	order by mv.Fecha desc,mv.Hora desc
	offset @PosicionPagina rows fetch next @FilasPorPagina rows only








GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Movimiento_Inventario_Count]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Movimiento_Inventario_Count]
@init bit,
@opcion tinyint,
@movimiento int,
@fechaInicial varchar(50),
@fechaFinal varchar(50)
as
	select count(*) as Total
	from MovimientoInventarioTB mv inner join TipoMovimientoTB as tm on mv.TipoMovimiento = tm.IdTipoMovimiento
	where 

		 (@opcion = 1 and @init = 0)
		 or
		 (@opcion = 1 and mv.Fecha between cast(@fechaInicial as date) and cast(@fechaFinal as date) and @movimiento = 0)
		 or
		 (@opcion = 1 and mv.Fecha between cast(@fechaInicial as date) and cast(@fechaFinal as date) and mv.TipoMovimiento = @movimiento)
		
	








GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Movimiento_Inventario_Detalle_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Listar_Movimiento_Inventario_Detalle_By_Id]
@idMovimientoInventario varchar(12)
as
	begin
		SELECT m.IdMovimientoInventario,m.IdSuministro,
		s.Clave,s.NombreMarca,m.Cantidad,m.Costo,m.Precio 
        FROM MovimientoInventarioDetalleTB AS m 
		INNER JOIN SuministroTB AS s ON m.IdSuministro = s.IdSuministro
        WHERE m.IdMovimientoInventario = @idMovimientoInventario
	end








GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Pais]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[Sp_Listar_Pais]
as
	begin
		select PaisCodigo,PaisNombre from PaisTB order by PaisNombre
	end

























GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Precios_By_IdSuministro]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Precios_By_IdSuministro]
@IdSuministro varchar(12)
as
SELECT IdPrecios,Nombre,Valor,Factor FROM PreciosTB  where IdSuministro= @IdSuministro and Valor > 0
UNION  
select 0,'PRECIO GENERAL',PrecioVentaGeneral,1 from SuministroTB  where IdSuministro= @IdSuministro




GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Proveedor]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Proveedor]
@search varchar(100)
as
	begin
		select IdProveedor,dbo.Fc_Obtener_Nombre_Detalle(TipoDocumento,'0003') as Documento,NumeroDocumento,RazonSocial,NombreComercial,dbo.Fc_Obtener_Nombre_Detalle(Estado,'0001') as Estado,
		Telefono,Celular,FechaRegistro as FRegistro,Representante
		 from ProveedorTB where (@search = '') or (NumeroDocumento like @search+'%')
		or (
			(NombreComercial LIKE @search+'%')
			or
			(RazonSocial LIKE @search+'%')
		)
	end


















GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Provincia]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Listar_Provincia]
@IdCiudad int
as
	begin
		select IdProvincia,Provincia from ProvinciaTB where IdCiudad = @IdCiudad order by Provincia
	end
























GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Suministro_By_Search]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Suministro_By_Search]
@search varchar(60)
as
	begin
		select s.IdSuministro,s.Clave,s.NombreMarca,dbo.Fc_Obtener_Nombre_Detalle(s.Marca,'0007') as Marca,
		dbo.Fc_Obtener_Nombre_Detalle(s.Presentacion,'0008') as Presentacion,
		s.Cantidad,s.PrecioCompra,s.PrecioVentaGeneral,
		dbo.Fc_Obtener_Nombre_Detalle(UnidadCompra,'0013') as UnidadCompra,
		s.UnidadVenta,s.Lote,s.Inventario,
		i.Operacion,s.Impuesto,i.Nombre as ImpuestoNombre,i.Valor,
		s.ValorInventario		
		from SuministroTB as s inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto
		where (@search <> '' and Clave<>'' and Clave = @search) or (@search <> '' and ClaveAlterna <> '' and ClaveAlterna = @search )
	end







GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Suministros]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Suministros]
@Opcion tinyint,
@Clave varchar(45),
@NombreMarca varchar(120),
@Categoria int,
@Marca int,
@PosicionPagina smallint,
@FilasPorPagina smallint
as
	begin	
		select s.IdSuministro,s.Clave,s.ClaveAlterna,s.NombreMarca,
		s.NombreGenerico,s.StockMinimo,s.StockMaximo,s.Cantidad,
		dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') as UnidadCompraNombre,
		dbo.Fc_Obtener_Nombre_Detalle(s.Marca,'0007') as Marca,
		s.PrecioCompra,s.PrecioVentaGeneral,
		dbo.Fc_Obtener_Nombre_Detalle(s.Categoria,'0006') as Categoria,
		dbo.Fc_Obtener_Nombre_Detalle(s.Estado,'0001') as Estado,
		s.Inventario,s.ValorInventario,s.Imagen,s.NuevaImagen,
		i.Nombre as ImpuestoNombre,i.Valor
		from SuministroTB as s inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto
		where
		(@Clave = '' and @NombreMarca = '' and @Categoria = 0 and @Marca = 0 and @Opcion = 0)
		-------------------------------------------------------------------------------------------------------------
		or (s.Clave <> '' and s.Clave = @Clave and @opcion = 1)
		or (s.ClaveAlterna <> '' and s.ClaveAlterna = @Clave and @opcion = 1)
		-------------------------------------------------------------------------------------------------------------
		or (s.NombreMarca like @NombreMarca+'%' and @opcion = 2)
		-------------------------------------------------------------------------------------------------------------
		or (s.Categoria = @Categoria and s.Inventario = 1 and @opcion = 3)
		-------------------------------------------------------------------------------------------------------------
		or (s.Marca = @Marca and s.Inventario = 1 and @opcion = 4)
		order by IdSuministro asc offset @PosicionPagina rows fetch next @FilasPorPagina rows only
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Suministros_Count]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Suministros_Count]
@Opcion tinyint,
@Clave varchar(45),
@NombreMarca varchar(120),
@Categoria int,
@Marca int
as
	begin	
		select count(*) as Total from SuministroTB as s inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto
		where
		(@Clave = '' and @NombreMarca = '' and @Categoria = 0 and @Marca = 0 and @Opcion = 0)
		-------------------------------------------------------------------------------------------------------------
		or (s.Clave <> '' and s.Clave = @Clave and @opcion = 1)
		or (s.ClaveAlterna <> '' and s.ClaveAlterna = @Clave and @opcion = 1)
		-------------------------------------------------------------------------------------------------------------
		or (s.NombreMarca like @NombreMarca+'%' and @opcion = 2)
		-------------------------------------------------------------------------------------------------------------
		or (s.Categoria = @Categoria and s.Inventario = 1 and @opcion = 3)
		-------------------------------------------------------------------------------------------------------------
		or (s.Marca = @Marca and s.Inventario = 1 and @opcion = 4)
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Suministros_Lista_View]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Suministros_Lista_View] 
@opcion smallint,
@search varchar(100),
@PosicionPagina smallint,
@FilasPorPagina smallint
as
	begin
		select s.IdSuministro,s.Clave,s.NombreMarca,
		dbo.Fc_Obtener_Nombre_Detalle(s.Categoria,'0006') as Categoria,
		dbo.Fc_Obtener_Nombre_Detalle(s.Marca,'0007') as Marca,
		s.Cantidad,s.PrecioCompra,
		s.PrecioVentaGeneral,
		dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') as UnidadCompra,
		s.UnidadVenta,s.Inventario,
		i.Operacion,s.Impuesto,i.Nombre as ImpuestoNombre,i.Valor,
		s.Lote,s.ValorInventario,s.Imagen,NuevaImagen
		from SuministroTB as s inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto
		where 
		(@opcion = 0 and s.Estado = 1) 
		or 
		(@opcion = 1 and s.Clave = @search and s.Estado = 1)
		or
		(@opcion = 1 and s.ClaveAlterna = @search and s.Estado = 1)
		or
		(@opcion = 1 and s.NombreMarca like @search+'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 2 and dbo.Fc_Obtener_Nombre_Detalle(s.Categoria,'0006') like @search +'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 3 and dbo.Fc_Obtener_Nombre_Detalle(s.Marca,'0007') like @search +'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 4 and dbo.Fc_Obtener_Nombre_Detalle(s.Presentacion,'0008') like @search +'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 5 and dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') like @search +'%' and s.Estado = 1)

		order by s.IdSuministro asc offset @PosicionPagina rows fetch next @FilasPorPagina rows only
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Suministros_Lista_View_Count]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Sp_Listar_Suministros_Lista_View_Count]
@opcion smallint,
@search varchar(100)
as
	begin
		select count(*) as Total 
		from SuministroTB as s inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto 
		where 
		(@opcion = 0 and s.Estado = 1) 
		or 
		(@opcion = 1 and s.Clave = @search and s.Estado = 1)
		or
		(@opcion = 1 and s.ClaveAlterna = @search and s.Estado = 1)
		or
		(@opcion = 1 and s.NombreMarca like @search+'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 2 and dbo.Fc_Obtener_Nombre_Detalle(s.Categoria,'0006') like @search +'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 3 and dbo.Fc_Obtener_Nombre_Detalle(s.Marca,'0007') like @search +'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 4 and dbo.Fc_Obtener_Nombre_Detalle(s.Presentacion,'0008') like @search +'%' and s.Estado = 1)
		-----------------------------------------------------------------------------------------------------------
		or
		(@opcion = 5 and dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') like @search +'%' and s.Estado = 1)

	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ticket_By_Tipo_Opcion]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ticket_By_Tipo_Opcion]
@Tipo int,
@Opcion bit
as
	begin
		SELECT * FROM TicketTB WHERE (tipo <> 0 and @Opcion = 1) or (tipo = @Tipo and @Opcion = 0)
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Total_Banco]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Listar_Total_Banco]
@IdBanco varchar(12)
as
	begin
		SELECT dbo.Fc_Obtener_Simbolo_Moneda(IdMoneda) as Simbolo,SaldoInicial FROM Banco WHERE IdBanco = @IdBanco
	end













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Utilidad]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_Listar_Utilidad]
@fechaInicial Date,
@fechaFinal Date,
@idSuministro varchar(12),
@idCategoria int,
@idMarca int,
@idPresentacion int
as
	begin
		select a.IdSuministro, a.Clave, a.NombreMarca,v.Estado,dbo.Fc_Obtener_Nombre_Detalle(a.UnidadCompra,'0013') as UnidadCompraNombre,
		case
			when a.ValorInventario = 1 then dv.Cantidad
			when a.ValorInventario = 2 then dv.Cantidad
			when a.ValorInventario = 3 then dv.Cantidad
		end as Cantidad, 
		dv.CostoVenta as Costo,
		case
			when a.ValorInventario = 1 then dv.Cantidad * dv.CostoVenta
			when a.ValorInventario = 2 then dv.Cantidad * dv.CostoVenta
			when a.ValorInventario = 3 then dv.Cantidad * dv.CostoVenta
		end as CostoTotal,
		dv.PrecioVenta as Precio, 
		case 
			when a.ValorInventario = 1 then dv.Cantidad * dv.PrecioVenta
			when a.ValorInventario = 2 then dv.Cantidad * dv.PrecioVenta
			when a.ValorInventario = 3 then dv.Cantidad * dv.PrecioVenta
		end as PrecioTotal,
		case
			when a.ValorInventario = 1 then (dv.Cantidad * dv.PrecioVenta)- (dv.Cantidad * dv.CostoVenta )
			when a.ValorInventario = 2 then (dv.Cantidad * dv.PrecioVenta )- (dv.Cantidad * dv.CostoVenta )
			when a.ValorInventario = 3 then (dv.Cantidad * dv.PrecioVenta )- (dv.Cantidad * dv.CostoVenta )
		end as Utilidad,a.ValorInventario, m.Simbolo
				from DetalleVentaTB as dv
				inner join SuministroTB as a on dv.IdArticulo = a.IdSuministro 
				inner join VentaTB as v on v.IdVenta = dv.IdVenta
				inner join MonedaTB as m on m.IdMoneda = v.Moneda
				where 
				(v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and @idCategoria = 0 and @idMarca = 0 and @idPresentacion = 0)
				or
				(
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and @idMarca = 0 and @idPresentacion = 0
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and @idMarca = 0 and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and @idMarca = 0 and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and @idMarca = 0 and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				)
				or
				(
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and @idMarca = 0 and @idPresentacion = 0
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and @idMarca = 0 and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and @idMarca = 0 and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and @idMarca = 0 and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				)
				or
				(
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and @idCategoria = 0 and a.Marca = @idMarca and @idPresentacion = 0
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and @idCategoria = 0 and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and @idPresentacion = 0
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				)
				or
				(
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and @idCategoria = 0 and @idMarca = 0 and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and @idMarca = 0 and a.Presentacion = @idPresentacion
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and @idMarca = 0 and a.Presentacion = @idPresentacion
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and @idCategoria = 0 and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and @idMarca = 0 and a.Presentacion = @idPresentacion
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and @idCategoria = 0 and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and @idSuministro = '' and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					or
					v.Estado <> 3 and cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal and a.IdSuministro = @idSuministro and a.Categoria = @idCategoria and a.Marca = @idMarca and a.Presentacion = @idPresentacion
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				)
				--where ( cast(v.FechaVenta as date)  between @fechaInicial and @fechaFinal ) and (a.Clave like @busqueda+'%' or a.NombreMarca like @busqueda+'%')				
			
		order by a.NombreMarca asc
	end













GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas]
@opcion smallint,
@search varchar(100),
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@Comprobante int,
@Estado int,
@Vendedor varchar(12),
@PosicionPagina smallint,
@FilasPorPagina smallint
as
	select
		v.IdVenta,
		v.FechaVenta,
		v.HoraVenta,
		e.Apellidos as ApellidosVendedor,
		e.Nombres as NombresVendedor,
		c.NumeroDocumento as DocumentoCliente,
		c.Informacion as Cliente,
		td.CodigoAlterno as TipoComprobante,
		td.Nombre as Comprobante,		
		v.Serie,v.Numeracion,
		dbo.Fc_Obtener_Nombre_Detalle(v.Tipo,'0015') Tipo,
		dbo.Fc_Obtener_Nombre_Detalle(v.Estado,'0009') Estado,
		dbo.Fc_Obtener_Simbolo_Moneda(v.Moneda) as Simbolo,
		dbo.Fc_Obtener_Nombre_Moneda(v.Moneda) as NombreMoneda,
		dbo.Fc_Obtener_Abreviatura_Moneda(v.Moneda) as TipoMoneda,
		v.Total,
		v.Observaciones,
		isnull(v.Xmlsunat,'') as Xmlsunat,
		isnull(v.Xmldescripcion,'') as Xmldescripcion
		from VentaTB as v
		inner join TipoDocumentoTB as td on v.Comprobante = td.IdTipoDocumento
		inner join EmpleadoTB as e on v.Vendedor = e.IdEmpleado
		inner join ClienteTB as c on v.Cliente = c.IdCliente
		where 
		(v.Vendedor = @Vendedor and @search = '' and CAST(v.FechaVenta as date) = CAST(GETDATE() as date) and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND CONCAT(v.Serie,'-',v.Numeracion) LIKE @search+'%' and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND v.Serie LIKE @search+'%' and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND v.Numeracion LIKE @search+'%' and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND dbo.Fc_Obtener_Datos_Cliente(v.Cliente) LIKE @search+'%' and @opcion = 1)
		
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0 AND @Estado = 0 and @opcion = 0)
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante AND v.Estado = @Estado and @opcion = 0)
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante  AND @Estado = 0 and @opcion = 0)
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0  AND v.Estado = @Estado and @opcion = 0)
		
		OR 
		(@search <> '' AND CONCAT(v.Serie,'-',v.Numeracion) LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND v.Serie LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND v.Numeracion LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND dbo.Fc_Obtener_NumeroDocumento_Cliente(v.Cliente) LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND dbo.Fc_Obtener_Datos_Cliente(v.Cliente) LIKE @search+'%' and @opcion = 2)

		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0 AND @Estado = 0 and @opcion = 3)
		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante AND v.Estado = @Estado and @opcion = 3)
		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante  AND @Estado = 0 and @opcion = 3)
		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0  AND v.Estado = @Estado and @opcion = 3)
		--(@search = '' and @opcion = 2)
	--order by v.FechaVenta desc, v.HoraVenta desc descoffset @PosicionPagina rows fetch next @FilasPorPagina rows only
	order by v.FechaVenta desc,v.HoraVenta desc offset @PosicionPagina rows fetch next @FilasPorPagina rows only










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas_10_Primeras]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas_10_Primeras]
as
	select 
		top 10
		v.IdVenta,
		dbo.Fc_Obtener_Datos_Cliente(v.Cliente) as Cliente,
		v.FechaVenta,
		v.HoraVenta,
		v.Serie,
		v.Numeracion,
		dbo.Fc_Obtener_Simbolo_Moneda(v.Moneda) as Simbolo,
		v.Total
		from VentaTB as v
		where v.FechaVenta = cast(GETDATE() as date)		
	    order by v.FechaVenta asc , v.HoraVenta desc










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas_Count]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas_Count]
@opcion smallint,
@search varchar(100),
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@Comprobante int, 
@Estado int,
@Vendedor varchar(12)
as
	select COUNT(*) as Total 
		from VentaTB as v
		inner join TipoDocumentoTB as td on v.Comprobante = IdTipoDocumento
		inner join EmpleadoTB as e on v.Vendedor = e.IdEmpleado
		inner join ClienteTB as c on v.Cliente = c.IdCliente
		where 
		(v.Vendedor = @Vendedor and @search = '' and CAST(v.FechaVenta as date) = CAST(GETDATE() as date) and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND CONCAT(v.Serie,'-',v.Numeracion) LIKE @search+'%' and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND v.Serie LIKE @search+'%' and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND v.Numeracion LIKE @search+'%' and @opcion = 1)
		OR 
		(v.Vendedor = @Vendedor and @search <> '' AND dbo.Fc_Obtener_Datos_Cliente(v.Cliente) LIKE @search+'%' and @opcion = 1)	
			
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0 AND @Estado = 0 and @opcion = 0)
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante AND v.Estado = @Estado and @opcion = 0)
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante  AND @Estado = 0 and @opcion = 0)
		OR
		(v.Vendedor = @Vendedor and CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0  AND v.Estado = @Estado and @opcion = 0)

		OR 
		(@search <> '' AND CONCAT(v.Serie,'-',v.Numeracion) LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND v.Serie LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND v.Numeracion LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND dbo.Fc_Obtener_NumeroDocumento_Cliente(v.Cliente) LIKE @search+'%' and @opcion = 2)
		OR 
		(@search <> '' AND dbo.Fc_Obtener_Datos_Cliente(v.Cliente) LIKE @search+'%' and @opcion = 2)

		OR
		( CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0 AND @Estado = 0 and @opcion = 3)
		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante AND v.Estado = @Estado and @opcion = 3)
		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND v.Comprobante = @Comprobante  AND @Estado = 0 and @opcion = 3)
		OR
		(CAST(v.FechaVenta AS DATE) BETWEEN @FechaInicial AND @FechaFinal AND @Comprobante = 0  AND v.Estado = @Estado and @opcion = 3)










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas_Credito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas_Credito]
@Opcion tinyint,
@Search varchar(100),
@FechaInicio date,
@FechaFinal date,
@PosicionPagina smallint,
@FilasPorPagina smallint
as
	begin
		select v.IdVenta,v.Serie,v.Numeracion,v.FechaVenta,v.HoraVenta,c.NumeroDocumento,c.Informacion,
		v.Estado,m.Simbolo,sum(dv.Importe) as MontoTotal,
		(select isnull(sum(vc.Monto),0) from VentaCreditoTB as vc where vc.IdVenta = v.IdVenta) as MontoCobrado
		from VentaTB as v 
		inner join ClienteTB as c on c.IdCliente = v.Cliente
		inner join MonedaTB as m on  m.IdMoneda = v.Moneda
		inner join DetalleVentaTB as dv on dv.IdVenta = v.IdVenta
		where
		(@Opcion = 0 and v.Tipo = 2) 
		or (@Opcion = 1 and c.NumeroDocumento like @Search+'%' and v.Tipo = 2)
		or (@Opcion = 1 and c.Informacion like @Search+'%' and v.Tipo = 2)
		or (@Opcion = 2 and v.FechaVenta between @FechaFinal and @FechaFinal and v.Tipo = 2)
		group by v.IdVenta,v.Serie,v.Numeracion,v.FechaVenta,v.HoraVenta,c.NumeroDocumento,c.Informacion,
		v.Estado,m.Simbolo
		order by v.FechaVenta desc,v.HoraVenta desc offset @PosicionPagina rows fetch next @FilasPorPagina rows only
	end



GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas_Credito_Count]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas_Credito_Count]
@Opcion tinyint,
@Search varchar(100),
@FechaInicio date,
@FechaFinal date
as
	begin
		select COUNT(*) AS 'Total'
		from VentaTB as v 
		inner join ClienteTB as c on c.IdCliente = v.Cliente
		inner join MonedaTB as m on  m.IdMoneda = v.Moneda
		where (@Opcion = 0 and v.Tipo = 2) 
		or (@Opcion = 1 and c.NumeroDocumento like @Search+'%' and v.Tipo = 2)
		or (@Opcion = 1 and c.Informacion like @Search+'%' and v.Tipo = 2)
		or (@Opcion = 2 and v.FechaVenta between @FechaFinal and @FechaFinal and v.Tipo = 2)
	end



GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas_Detalle_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas_Detalle_By_Id] 
@IdVenta varchar(12)
as
	select /*ROW_NUMBER() over( order by d.IdArticulo desc) as Filas ,*/
	a.IdSuministro,
	a.Clave,
	a.NombreMarca,
	a.Inventario,
	a.ValorInventario,
	a.ClaveSat,
	dbo.Fc_Obtener_Nombre_Detalle_IdAuxiliar(a.UnidadCompra,'0013') as CodigoUnidad,
	dbo.Fc_Obtener_Nombre_Detalle(a.UnidadCompra,'0013') as UnidadCompra,	
	d.Cantidad,
	d.Bonificacion,
	d.CostoVenta,
	d.PrecioVenta,
	d.Descuento,
	d.DescuentoCalculado,
	d.IdImpuesto,
	d.NombreImpuesto,
	d.ValorImpuesto,
	i.Codigo,
	isnull(i.Numeracion,'') as Numeracion,
	isnull(i.NombreImpuesto,'') as NombreImpuesto,
	isnull(i.Letra,'') as Letra,
	isnull(i.Categoria,'') as Categoria,
	d.Importe
	from DetalleVentaTB as d inner join SuministroTB as a on d.IdArticulo = a.IdSuministro
	inner join  ImpuestoTB as i on d.IdImpuesto = i.IdImpuesto
	where d.IdVenta = @IdVenta










GO
/****** Object:  StoredProcedure [dbo].[Sp_Listar_Ventas_Mostrar]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Listar_Ventas_Mostrar]
@Search varchar(100)
as
	select
		v.IdVenta,
		dbo.Fc_Obtener_Datos_Cliente(v.Cliente) as Cliente,
		v.FechaVenta,
		v.HoraVenta,
		v.Serie,
		v.Numeracion,
		dbo.Fc_Obtener_Simbolo_Moneda(v.Moneda) as Simbolo,
		v.Total
		from VentaTB as v
		where 
		@Search <> '' and @Search = v.Serie and v.FechaVenta = cast(GETDATE() as date)
		or
		@Search <> '' and @Search = cast(v.Numeracion as int) and v.FechaVenta = cast(GETDATE() as date)
		or
		@Search <> '' and @Search = v.Serie+'-'+cast(v.Numeracion as int) and v.FechaVenta = cast(GETDATE() as date)
		or
		@Search <> '' and @Search like dbo.Fc_Obtener_Datos_Cliente(v.Cliente)+'%' and v.FechaVenta = cast(GETDATE() as date)
	   order by v.FechaVenta desc , v.HoraVenta asc










GO
/****** Object:  StoredProcedure [dbo].[Sp_ListarCajasAperturadas]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_ListarCajasAperturadas]
@FechaInicial varchar(15),
@FechaFinal varchar(15)
as
	begin
		select a.IdCaja,a.FechaApertura,a.HoraApertura,a.FechaCierre,
		a.HoraCierre,a.Estado,a.Contado,a.Calculado,
		a.Diferencia,e.Apellidos,e.Nombres 
		from CajaTB as a inner join EmpleadoTB as e
		on a.IdUsuario = e.IdEmpleado
		where 
		(a.FechaApertura between @FechaInicial and @FechaFinal)
		
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_ListarCajasAperturadasPorUsuario]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_ListarCajasAperturadasPorUsuario]
@Usuario varchar(12)
as
	begin
		select a.IdCaja,a.FechaApertura,a.HoraApertura,a.FechaCierre,a.HoraCierre,a.Estado,a.Contado,a.Calculado,a.Diferencia,e.Apellidos,e.Nombres 
		from CajaTB as a inner join EmpleadoTB as e
		on a.IdUsuario = e.IdEmpleado
		where 
		e.IdEmpleado = @Usuario
		order by a.FechaApertura desc,a.HoraApertura desc
	end


















GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Caja_Aperturada_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Caja_Aperturada_By_Id]
@IdCaja varchar(12)
as
	begin
		select a.IdCaja,a.FechaApertura,a.HoraApertura,a.FechaCierre,
		a.HoraCierre,a.Contado,a.Calculado,
		a.Diferencia,e.NumeroDocumento,e.Apellidos,e.Nombres,e.Celular,e.Telefono,e.Direccion
		from CajaTB as a inner join EmpleadoTB as e
		on a.IdUsuario = e.IdEmpleado
		where 
		a.IdCaja = @IdCaja	
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Cliente_Informacion_NumeroDocumento]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Cliente_Informacion_NumeroDocumento]
@opcion tinyint,
@search varchar(100)
as
	begin
		select IdCliente,TipoDocumento,NumeroDocumento,Informacion,Celular,Email,Direccion 
		from ClienteTB 
		where 
		@search = '' and @opcion = 1
		or
		NumeroDocumento = @search and @opcion = 2
		or 
		@search <> ''and Informacion like '%'+@search+'%' and @opcion = 3
		or
		@search <> ''and NumeroDocumento like @search+'%' and @opcion = 4
		or
		@search <> ''and Informacion like '%'+@search+'%' and @opcion = 4
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Compra_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Compra_ById]
@IdCompra varchar(12)
as
	select c.FechaCompra, c.HoraCompra,
	c.Comprobante, c.Serie,c.Numeracion,
	p.NumeroDocumento,p.RazonSocial,p.Telefono,p.Celular,p.Direccion,p.Email,
	m.Nombre,m.Simbolo,
	dbo.Fc_Obtener_Nombre_Detalle(c.TipoCompra,'0015') as Tipo,
	c.EstadoCompra,
	dbo.Fc_Obtener_Nombre_Detalle(c.EstadoCompra,'0009') as Estado,
	c.Observaciones,c.Notas,sum(d.Importe) as Total
	from CompraTB as c inner join MonedaTB as m on c.TipoMoneda = m.IdMoneda
	inner join DetalleCompraTB as d on d.IdCompra = c.IdCompra
	inner join ProveedorTB as p on p.IdProveedor = c.Proveedor
	where c.IdCompra = @IdCompra
	group by  c.FechaCompra, c.HoraCompra,c.Comprobante, c.Serie,c.Numeracion,
	m.Nombre,m.Simbolo,c.EstadoCompra,c.TipoCompra,c.Observaciones,c.Notas,
	p.NumeroDocumento,p.RazonSocial,p.Telefono,p.Celular,p.Direccion,p.Email













GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Compra_ById_For_Credito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Obtener_Compra_ById_For_Credito]
@IdCompra varchar(12)
as
	begin
	select c.FechaCompra, c.HoraCompra,
	c.Serie,c.Numeracion,
	p.NumeroDocumento,p.RazonSocial,p.Telefono,p.Celular,p.Direccion,p.Email,
	m.Simbolo,c.EstadoCompra,
	dbo.Fc_Obtener_Nombre_Detalle(c.EstadoCompra,'0009') as Estado,
	sum(d.Importe) as MontoTotal,
	(select sum(Monto) from CompraCreditoTB where IdCompra = @IdCompra) as MontoPagado
	from CompraTB as c 
	inner join MonedaTB as m on c.TipoMoneda = m.IdMoneda
	inner join ProveedorTB as p on p.IdProveedor = c.Proveedor
	inner join DetalleCompraTB as d on d.IdCompra = c.IdCompra
	where c.IdCompra = @IdCompra
	group by c.FechaCompra, c.HoraCompra,c.Comprobante, c.Serie,c.Numeracion,
	m.Nombre,m.Simbolo,c.EstadoCompra,c.TipoCompra,c.Observaciones,c.Notas,
	p.NumeroDocumento,p.RazonSocial,p.Telefono,p.Celular,p.Direccion,p.Email
	end




GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Cotizacion_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Cotizacion_ById]
@IdCotizacion varchar(12)
as
	begin
		select co.IdCotizacion,cl.IdCliente,cl.TipoDocumento,cl.NumeroDocumento,cl.Informacion,
		cl.Celular,cl.Email,cl.Direccion,co.IdMoneda,co.Observaciones
		from CotizacionTB as co
		inner join ClienteTB as cl on co.IdCliente = cl.IdCliente
		where IdCotizacion = @IdCotizacion
	end








GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Cotizacion_Reporte_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Cotizacion_Reporte_ById]
@IdCotizacion varchar(12)
as
	begin
		select em.Apellidos,em.Nombres,cl.IdCliente,cl.TipoDocumento,cl.NumeroDocumento,cl.Informacion,
		cl.Celular,cl.Telefono,cl.Email,cl.Direccion,co.FechaCotizacion,co.HoraCotizacion,
		m.Nombre,m.Simbolo,co.Observaciones
		from CotizacionTB as co
		inner join ClienteTB as cl on co.IdCliente = cl.IdCliente
		inner join MonedaTB as m on co.IdMoneda = m.IdMoneda
		inner join EmpleadoTB as em on co.IdVendedor=em.IdEmpleado
		where IdCotizacion = @IdCotizacion
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Detalle_Cotizacion_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Detalle_Cotizacion_ById] 
@IdCotizacion varchar(12)
as
	begin
		select s.IdSuministro,s.Clave,s.NombreMarca,d.Cantidad,s.PrecioCompra,
		d.Precio,d.Descuento,s.UnidadVenta,s.Inventario,
		i.Operacion,s.Impuesto,i.Nombre as ImpuestoNombre,i.Valor,
		s.Lote,s.ValorInventario
		from DetalleCotizacionTB as d
		inner join SuministroTB as s on d.IdSuministro = s.IdSuministro
		inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto
		where d.IdCotizacion = @IdCotizacion
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Detalle_Cotizacion_Reporte_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Detalle_Cotizacion_Reporte_ById] 
@IdCotizacion varchar(12)
as
	begin
		select s.IdSuministro,
		dbo.Fc_Obtener_Nombre_Detalle(s.UnidadCompra,'0013') as UnidadCompraNombre,
		s.Clave,s.NombreMarca,d.Cantidad,s.PrecioCompra,
		d.Precio,d.Descuento,s.UnidadVenta,s.Inventario,
		i.Operacion,s.Impuesto,i.Nombre as ImpuestoNombre,i.Valor,
		s.Lote,s.ValorInventario
		from DetalleCotizacionTB as d
		inner join SuministroTB as s on d.IdSuministro = s.IdSuministro
		inner join ImpuestoTB as i on s.Impuesto = i.IdImpuesto
		where d.IdCotizacion = @IdCotizacion
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Empresa]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Empresa]
as
	begin
		select IdEmpresa,GiroComercial,Nombre,Telefono,Celular,PaginaWeb,Email,
		Domicilio,TipoDocumento,NumeroDocumento,RazonSocial,NombreComercial,Image,
		isnull(Ubigeo,0) as IdUbigeo,
		dbo.Fc_Obtener_Ubigeo(Ubigeo) as CodigoUbigeo,
		dbo.Fc_Obtener_Departamento(Ubigeo) as Departamento,
		dbo.Fc_Obtener_Provincia(Ubigeo) as Provincia,
		dbo.Fc_Obtener_Distrito(Ubigeo) as Distrito
		from EmpresaTB
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Insumo_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Obtener_Insumo_ById]
@IdInsumo VARCHAR(12)
AS
SELECT 
                    i.IdInsumo,
                    i.Clave,
                    i.ClaveAlterna,
                    i.NombreMarca,
                    i.Medida,
                    i.Categoria,
                    i.Costo,
                    i.StockMinimo,
                    i.StockMaximo, 
                    isnull(m.Nombre,'SIN UNIDAD') as MedidaName,
                    isnull(c.Nombre,'SIN CATEGORIA') as CategoriaName
                    FROM InsumoTB AS i 
                    LEFT OUTER JOIN DetalleTB as m ON i.Medida = m.IdDetalle and m.IdMantenimiento = '0013'
                    LEFT OUTER JOIN DetalleTB as c ON i.Categoria = c.IdDetalle and c.IdMantenimiento = '0006'
                    WHERE IdInsumo = @IdInsumo




GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Proveedor_By_IdProveedor]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Obtener_Proveedor_By_IdProveedor]
@IdProveedor varchar(12)
as
	begin
		select dbo.Fc_Obtener_Nombre_Detalle(p.TipoDocumento,'0003') as NombreDocumento,
		p.NumeroDocumento,p.RazonSocial,p.Telefono,p.Celular,p.Direccion,p.Email 
        from  ProveedorTB as p
		where p.IdProveedor = @IdProveedor
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Proveedor_For_ComboBox]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Proveedor_For_ComboBox]
@search varchar(100)
as
	SELECT IdProveedor,NumeroDocumento,RazonSocial FROM ProveedorTB
	WHERE (NumeroDocumento LIKE @search+'%') OR (RazonSocial LIKE @search+'%')










GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Ubigeo_BySearch]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Obtener_Ubigeo_BySearch]
@Search varchar(60)
as
	begin
		select IdUbigeo,Ubigeo,Departamento,Provincia,Distrito from UbigeoTB 
		where 
		(Departamento like @Search+'%') 
		or 
		(Provincia like @Search+'%') 
		or 
		(Distrito like @Search+'%')

		or
		CONCAT(Departamento,'-',Provincia,'-',Distrito) like @Search+'%'
		or
		CONCAT(Departamento,' - ',Provincia,' - ',Distrito) like @Search+'%'

		or
		CONCAT(Departamento,'-',Provincia) like @Search+'%'
		or
		CONCAT(Departamento,' - ',Provincia) like @Search+'%'
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Venta_ById]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Venta_ById]
@idVenta varchar(12)
as
	begin
		select v.FechaVenta,v.HoraVenta,
		dbo.Fc_Obtener_Nombre_Detalle(c.TipoDocumento,'0003') as NombreDocumento,
		d.IdAuxiliar,
		c.IdCliente,c.NumeroDocumento,c.Informacion,c.Telefono,c.Celular,c.Email,c.Direccion,
		t.CodigoAlterno,v.Comprobante as IdComprobante,t.Nombre as Comprobante,
		v.Serie,v.Numeracion,v.Observaciones,
		dbo.Fc_Obtener_Nombre_Detalle(v.Tipo,'0015') Tipo,
		v.Estado,
		v.Forma,
		case v.Estado 
		when 3 then 'ANULADO'
		when 2 then 'POR PAGAR'
		else 'PAGADO' end as EstadoName,
		case v.Estado
		when 1 then iif(v.Forma = 1,'EFECTIVO','TARJETA')
		else 'NO ESPECIFICADO' end as FormaName,
		m.Nombre,m.Abreviado,m.Simbolo,v.Efectivo,
		v.Vuelto,v.Tarjeta,v.SubTotal,v.Descuento,v.Impuesto,v.Total,v.Codigo
        from VentaTB as v inner join MonedaTB as m on v.Moneda = m.IdMoneda
		inner join ClienteTB as c on v.Cliente = c.IdCliente
		inner join TipoDocumentoTB as t on v.Comprobante = t.IdTipoDocumento
		inner join DetalleTB as d on c.TipoDocumento = d.IdDetalle and d.IdMantenimiento = '0003'
        where v.IdVenta = @idVenta
	end





GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_Venta_ById_For_Credito]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Obtener_Venta_ById_For_Credito]
@IdVenta varchar(12)
as
	begin
		select v.FechaVenta,v.HoraVenta,
		c.NumeroDocumento,c.Informacion,c.Telefono,c.Celular,c.Email,c.Direccion,
		t.Nombre as Comprobante,v.Serie,v.Numeracion,
		dbo.Fc_Obtener_Nombre_Detalle(v.Tipo,'0015') Tipo,m.Simbolo,
		v.Estado,
		case v.Estado 
		when 3 then 'ANULADO'
		when 2 then 'PENDIENTE'
		else 'PAGADO' end as EstadoName,
		v.Total as MontoTotal,(select isnull(sum(Monto),0)  from VentaCreditoTB where IdVenta = @IdVenta)as MontoCobrado
        from VentaTB as v inner join MonedaTB as m on v.Moneda = m.IdMoneda
		inner join ClienteTB as c on v.Cliente = c.IdCliente
		inner join TipoDocumentoTB as t on v.Comprobante = t.IdTipoDocumento
        where v.IdVenta = @IdVenta
	end



GO
/****** Object:  StoredProcedure [dbo].[Sp_Obtener_VentaCredito_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Obtener_VentaCredito_By_Id]
@IdVentaCredito varchar(12)
as
	begin
		select IdVentaCredito,Monto,FechaPago,HoraPago,Observacion from VentaCreditoTB where IdVentaCredito = @IdVentaCredito
	end




GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_General_Compras]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Reporte_General_Compras]
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@Proveedor varchar(12),
@TipoCompra int
as
	select c.FechaCompra,p.NumeroDocumento,p.RazonSocial as Proveedor,c.Serie,c.Numeracion,
	dbo.Fc_Obtener_Nombre_Detalle(c.TipoCompra,'0015') Tipo,c.EstadoCompra,
	dbo.Fc_Obtener_Nombre_Detalle(c.EstadoCompra,'0009') EstadoName,
	dbo.Fc_Obtener_Simbolo_Moneda(c.TipoMoneda) as Simbolo,sum(d.Importe) as Total 
	from CompraTB as c inner join ProveedorTB as p on c.Proveedor = p.IdProveedor
	inner join DetalleCompraTB as d on d.IdCompra = c.IdCompra
	where
	(FechaCompra BETWEEN @FechaInicial AND @FechaFinal AND @Proveedor ='' AND @TipoCompra = 0)
	or
	(FechaCompra BETWEEN @FechaInicial AND @FechaFinal AND p.IdProveedor = @Proveedor AND @TipoCompra = 0)
	or
	(FechaCompra BETWEEN @FechaInicial AND @FechaFinal AND @Proveedor ='' AND c.TipoCompra = @TipoCompra)
	-----------------------------------------------------------------------------------------------------------------------------------------
	or
	(FechaCompra BETWEEN @FechaInicial AND @FechaFinal AND p.IdProveedor = @Proveedor AND @TipoCompra = 0)
	or
	(FechaCompra BETWEEN @FechaInicial AND @FechaFinal AND @Proveedor = 0 AND c.TipoCompra = @TipoCompra)
	or
	(FechaCompra BETWEEN @FechaInicial AND @FechaFinal AND p.IdProveedor = @Proveedor AND c.TipoCompra = @TipoCompra)
	-----------------------------------------------------------------------------------------------------------------------------------------
	group by  c.FechaCompra,c.HoraCompra,p.NumeroDocumento,p.RazonSocial,c.Serie,c.Numeracion,
	c.TipoCompra,c.EstadoCompra,c.TipoMoneda
	order by c.FechaCompra desc,c.HoraCompra desc














GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_General_Ventas]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Reporte_General_Ventas] 
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@TipoDocumento int,
@Cliente varchar(12),
@Empleado varchar(12)
as
	select td.Nombre,v.Serie,v.Numeracion,v.FechaVenta,
	dbo.Fc_Obtener_Nombre_Detalle(c.TipoDocumento,'0003') TipoDocumento,
	c.NumeroDocumento,c.Informacion as Cliente,	
	dbo.Fc_Obtener_Nombre_Detalle(v.Tipo,'0015') Tipo,
	dbo.Fc_Obtener_Nombre_Detalle(v.Estado,'0009') EstadoName,
	dbo.Fc_Obtener_Simbolo_Moneda(v.Moneda) as Simbolo,
	v.Estado,v.Total 
	from VentaTB as v
	inner join TipoDocumentoTB as td on v.Comprobante = td.IdTipoDocumento
	inner join ClienteTB as c on v.Cliente = c.IdCliente
	inner join EmpleadoTB as e on v.Vendedor = e.IdEmpleado
	where
	(FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND @TipoDocumento = 0 AND @Cliente ='' AND @Empleado = '' )
	or
	(
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND @Cliente ='' AND @Empleado = ''
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND c.IdCliente = @Cliente AND @Empleado = ''
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND @Cliente ='' AND e.IdEmpleado = @Empleado
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND c.IdCliente = @Cliente AND e.IdEmpleado = @Empleado
	)
	or
	(
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND @TipoDocumento = 0 AND c.IdCliente = @Cliente AND @Empleado = ''
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND c.IdCliente = @Cliente AND @Empleado = ''
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND @TipoDocumento = 0 AND c.IdCliente = @Cliente AND e.IdEmpleado = @Empleado
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND c.IdCliente = @Cliente AND e.IdEmpleado = @Empleado
	)
	or
	(
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND @TipoDocumento = 0 AND @Cliente ='' AND e.IdEmpleado = @Empleado  
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND @Cliente ='' AND e.IdEmpleado = @Empleado 
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND @TipoDocumento = 0 AND c.IdCliente = @Cliente AND e.IdEmpleado = @Empleado 
		or
		FechaVenta BETWEEN @FechaInicial AND @FechaFinal AND td.IdTipoDocumento = @TipoDocumento AND c.IdCliente = @Cliente AND e.IdEmpleado = @Empleado 
	)
	order by v.FechaVenta desc,v.HoraVenta desc





--	select * from MantenimientoTB
--	go







GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_Ventas_Sumadas_Por_Fecha]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Reporte_Ventas_Sumadas_Por_Fecha]
@FechaInicial varchar(20),
@FechaFinal varchar(20),
@TipoOrden bit,
@Orden bit
as
select FechaVenta,
 Estado,
 dbo.Fc_Obtener_Simbolo_Moneda(Moneda) as Simbolo,
 Total from VentaTB
where
 FechaVenta BETWEEN @FechaInicial AND @FechaFinal 
ORDER BY 
CASE WHEN @TipoOrden = 0 AND @Orden = 0 THEN FechaVenta END ASC,
CASE WHEN @TipoOrden = 0 AND @Orden = 1 THEN FechaVenta END DESC,
CASE WHEN @TipoOrden = 1 AND @Orden = 0 THEN Total END ASC,
CASE WHEN @TipoOrden = 1 AND @Orden = 1 THEN Total END DESC













GO
/****** Object:  StoredProcedure [dbo].[Sp_Suministro_By_Id]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Suministro_By_Id]
@IdSuministro varchar(45)
as
	begin
		select IdSuministro,Origen,Clave,ClaveAlterna,NombreMarca,NombreGenerico,
		Categoria,dbo.Fc_Obtener_Nombre_Detalle(Categoria,'0006') as CategoriaNombre,
		Marca,dbo.Fc_Obtener_Nombre_Detalle(Marca,'0007') as MarcaNombre,
		Presentacion,dbo.Fc_Obtener_Nombre_Detalle(Presentacion,'0008') as PresentacionNombre,
		UnidadCompra,dbo.Fc_Obtener_Nombre_Detalle(UnidadCompra,'0013') as UnidadCompraNombre,
		UnidadVenta,
		StockMinimo,StockMaximo,Cantidad,PrecioCompra,PrecioVentaGeneral,
		Estado,Lote,Inventario,ValorInventario,Imagen,NuevaImagen,
		Impuesto,dbo.Fc_Obtener_Nombre_Impuesto(Impuesto) as ImpuestoNombre,
		ClaveSat,TipoPrecio
		from SuministroTB
		where IdSuministro=@IdSuministro or Clave = @IdSuministro or ClaveAlterna = @IdSuministro
	end










GO
/****** Object:  StoredProcedure [dbo].[Sp_Validar_Ingreso]    Script Date: 25/01/2021 12:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Validar_Ingreso]
@usuario varchar(100),
@clave varchar(100)
as
SELECT IdEmpleado,Apellidos,Nombres,dbo.Fc_Obtener_Nombre_Rol(Rol) as RolName,Estado,Rol FROM EmpleadoTB
                WHERE Usuario = @usuario and Clave = @clave and Estado = 1













GO
