USE [master]
GO
/****** Object:  Database [web]    Script Date: 2/1/2025 3:05:24 PM ******/
CREATE DATABASE [web]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'web', FILENAME = N'C:\Users\htb\web.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'web_log', FILENAME = N'C:\Users\htb\web_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [web] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [web].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [web] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [web] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [web] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [web] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [web] SET ARITHABORT OFF 
GO
ALTER DATABASE [web] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [web] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [web] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [web] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [web] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [web] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [web] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [web] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [web] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [web] SET  DISABLE_BROKER 
GO
ALTER DATABASE [web] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [web] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [web] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [web] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [web] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [web] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [web] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [web] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [web] SET  MULTI_USER 
GO
ALTER DATABASE [web] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [web] SET DB_CHAINING OFF 
GO
ALTER DATABASE [web] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [web] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [web] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [web] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [web] SET QUERY_STORE = OFF
GO
USE [web]
GO
/****** Object:  User [dali]    Script Date: 2/1/2025 3:05:24 PM ******/
CREATE USER [dali] FOR LOGIN [dali] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[admin]    Script Date: 2/1/2025 3:05:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](100) NULL,
	[password] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 2/1/2025 3:05:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2/1/2025 3:05:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[OrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2/1/2025 3:05:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[quantity] [int] NULL,
	[price] [decimal](10, 2) NULL,
	[filename] [varchar](20) NULL,
	[country] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admin] ON 

INSERT [dbo].[admin] ([ID], [username], [password]) VALUES (1, N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[admin] OFF
GO
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (1, N'United States')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (2, N'Canada')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (3, N'United Kingdom')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (4, N'Australia')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (5, N'India')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (6, N'Germany')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (7, N'France')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (8, N'Italy')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (9, N'Japan')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (10, N'Brazil')
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [ProductID], [Quantity], [OrderDate]) VALUES (3, 3003, 1, CAST(N'2025-02-01T08:08:51.003' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [ProductID], [Quantity], [OrderDate]) VALUES (4, 3003, 1, CAST(N'2025-02-01T08:09:16.827' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [ProductID], [Quantity], [OrderDate]) VALUES (5, 3003, 1, CAST(N'2025-02-01T08:09:44.600' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [description], [quantity], [price], [filename], [country]) VALUES (3003, N'GTX 1050', N'1050', 1, CAST(100.00 AS Decimal(10, 2)), N'xxx.jpg', N'1         ')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([id])
GO
/****** Object:  StoredProcedure [dbo].[Add_Product]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Add_Product]
	-- Add the parameters for the stored procedure here
	@name VARCHAR(255),
	@DESCRIPTION TEXT,
	@quantity INT,
	@price DECIMAL(10,2),
	@filename VARCHAR(20),
	@country VARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO web.dbo.Product (name, description, quantity, price,filename,country)
    VALUES (@name, @description, @quantity, @price,@filename,@country);
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Product]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Delete_Product]
	-- Add the parameters for the stored procedure here
	@ID varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE  FROM Product where id=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetProducts]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ID,name from Product;
END
GO
/****** Object:  StoredProcedure [dbo].[Login_admin]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Login_admin]
	-- Add the parameters for the stored procedure here

	@username varchar(100),
	@password varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from admin
	where username=@username and  password=@password
END
GO
/****** Object:  StoredProcedure [dbo].[SearchProducts]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SearchProducts]
	@searchTerm varchar(100)
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from web.dbo.Product where Product.name LIKE '%'+@searchTerm
END
GO
/****** Object:  StoredProcedure [dbo].[Show_Products]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Show_Products]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from web.dbo.Product
END
GO
/****** Object:  StoredProcedure [dbo].[SubmitOrder]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubmitOrder]
    @id INT,        
    @Quantity INT   
AS
BEGIN
    DECLARE @AvailableQuantity INT;
    
    SELECT @AvailableQuantity = Quantity
    FROM Product
    WHERE id = @id;

    

    IF @Quantity > @AvailableQuantity
    BEGIN
		select 'Error quantity exced ' as 'result'
        RETURN;  
    END


    BEGIN

        INSERT INTO Orders (ProductID, Quantity)
        VALUES (@id, @Quantity);


        UPDATE Product
        SET Quantity = Quantity - @Quantity
        WHERE id = @id;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Product]    Script Date: 2/1/2025 3:05:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Update_Product]
	-- Add the parameters for the stored procedure here
	@ID varchar(10),
	@name VARCHAR(255),
	@quantity INT,
	@price VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Product set price=@price ,quantity=@quantity , name=@name
	where id=@ID
END
GO
USE [master]
GO
ALTER DATABASE [web] SET  READ_WRITE 
GO
