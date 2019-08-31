USE master
GO

/****** Object: Database VieKoreaRestaurant     ******/
IF DB_ID('VieKoreaRestaurant') IS NOT NULL
DROP DATABASE VieKoreaRestaurant

CREATE DATABASE VieKoreaRestaurant
GO

USE VieKoreaRestaurant
GO

/***** Object: Table Category *****/
DROP TABLE IF EXISTS dbo.Categories

CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/***** Object: Table Product *****/
DROP TABLE IF EXISTS dbo.Products

CREATE TABLE [dbo].[Products](
	[id] [int] IDENTITY(1000,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[briefDescription] [nvarchar](max) NOT NULL,
	[fullDescription] [nvarchar](max) NOT NULL,
	[statusCode] [bit] NOT NULL,
	[statusId] [int] NOT NULL,
	[price] [money] NOT NULL,
	[featured] [bit] NOT NULL,
	[categoryId] [int] NOT NULL,
	[imageId] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table dbo.ProductStatus ******/
DROP TABLE IF EXISTS dbo.ProductStatus

CREATE TABLE dbo.ProductStatus(
	id INT IDENTITY NOT NULL,
	status NVARCHAR(50) NOT NULL)
GO


/****** Object:  Table [dbo].[adminLogin] ******/
DROP TABLE IF EXISTS dbo.adminLogin

CREATE TABLE [dbo].[adminLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[password] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_adminLogin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Cart] ******/
DROP TABLE IF EXISTS [dbo].[Cart]

CREATE TABLE [dbo].[Cart](
	[cartUId] [varchar](50) NOT NULL,
	[prodId] [int] NOT NULL,
	[qty] [int] NOT NULL,
	[date] [date] NOT NULL,
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Customers] ******/
DROP TABLE IF EXISTS dbo.Customers

CREATE TABLE [dbo].[Customers](
	[id] [int] IDENTITY(975,1) NOT NULL,
	[userName] [nvarChar](50) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[street] [nvarchar](50) NOT NULL,
	[city] [nvarchar](20) NOT NULL,
	[province] [nvarchar](2) NOT NULL,
	[postalCode] [nvarchar](6) NOT NULL,
	[phone] [nvarchar](10) NOT NULL,
	[password] [nvarchar](15) NOT NULL,
	[birthday] [date] NOT NULL,
	[archived] [bit] NOT NULL,
	[validated] [bit] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[OrderDetails] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderNumber] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[price] [money] NOT NULL,
	[quantity] [int] NOT NULL,
	[subTotal] [money] NOT NULL
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Orders] ******/
DROP TABLE IF EXISTS dbo.Orders

CREATE TABLE [dbo].[Orders](
	[orderNumber] [int] IDENTITY(999,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[orderDate] [date] NOT NULL,
	[tax] [money] NOT NULL,
	[shippingCost] [money] NOT NULL,
	[totalCost] [money] NOT NULL,
	[recipientName] [NVARCHAR](50) NOT NULL,
	[street] [nvarchar](50) NOT NULL,
	[city] [nvarchar](20) NOT NULL,
	[province] [nvarchar](2) NOT NULL,
	[postalCode] [nvarchar](6) NOT NULL,
	[phone] [nvarchar](10) NOT NULL,
	[payment] [nvarchar](50) NOT NULL,
	[creditCardName] [nvarchar](50) NULL,
	[creditNumber] [nvarchar](50) NULL,
	[cvv] [nvarchar](50) NULL
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[orderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SiteImages] ******/
DROP TABLE IF EXISTS dbo.SiteImages

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteImages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[uploadDate] [datetime] NOT NULL,
	[altText] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SiteImages] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_orderDate]  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[SiteImages] ADD  CONSTRAINT [DF_SiteImages_uploadDate]  DEFAULT (getdate()) FOR [uploadDate]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([orderNumber])
REFERENCES [dbo].[Orders] ([orderNumber])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO


/****** Object:  UserDefinedTableType [dbo].[OrderDetail] ******/
CREATE TYPE [dbo].[OrderDetail] AS TABLE(
	[ProductId] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Qty] [int] NOT NULL
)
GO

/****** Object:  StoredProcedure [dbo].[AddToCart] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROC [dbo].[AddToCart]
@CartUId VARCHAR(50),
@ProductId INT,
@Qty INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
IF EXISTS (SELECT * FROM Cart WHERE cartUID=@CartUId AND prodId=@ProductId)
	BEGIN
	UPDATE Cart SET qty=qty+@Qty WHERE cartUID=@CartUId AND prodId=@ProductId
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
ELSE
	BEGIN
	INSERT INTO Cart (cartUID,prodId,qty) VALUES (@CartUId,@ProductId,@Qty)
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert into cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
GO

/****** Object:  StoredProcedure [dbo].[CartCount] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE    PROC [dbo].[CartCount]
@CartUId VARCHAR(50)
AS
SELECT SUM(qty) FROM Cart
WHERE cartUId=@CartUId	
GO

/****** Object:  StoredProcedure [dbo].[CartTotal] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[CartTotal]
@CartUId VARCHAR(50)
AS
BEGIN
	SELECT 
	SUM(p.price * c.qty) as Total 
	FROM Cart c INNER JOIN Products p ON c.prodId = p.Id 
	WHERE c.cartUId = @CartUId
END
GO

/****** Object:  StoredProcedure [dbo].[ClearCart] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ClearCart]
@CartUId VARCHAR(50)
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	DELETE FROM Cart WHERE cartUId=@CartUId
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Delete cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
GO

/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 2019-03-22 11:29:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create   PROC [dbo].DeleteCustomer
@CustomerId INT
AS
	BEGIN
		Delete FROM Customers WHERE id=@CustomerId
	END


/****** Object:  StoredProcedure dbo.deleteCategory ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create   PROC [dbo].[DeleteCategory]
@CategoryID INT
AS
IF EXISTS (SELECT * FROM Products WHERE categoryId = @CategoryID)
			BEGIN
				ROLLBACK TRANSACTION		
				RAISERROR('Cannot delete this product as it exists. Transaction cancelled.',16,1)
				RETURN
			END
ELSE
	BEGIN
		Delete FROM Categories WHERE id=@CategoryID
	END
GO


/****** Object:  StoredProcedure dbo.deleteProduct ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteProduct]
@ProductId INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
		IF EXISTS (SELECT * FROM Cart WHERE prodId=@ProductId)
			BEGIN
				ROLLBACK TRANSACTION		
				RAISERROR('Cannot delete this product as it is currently in a cart. Transaction cancelled.',16,1)
				RETURN
			END

		IF EXISTS (SELECT * FROM OrderDetails WHERE productId = @ProductId)
			BEGIN	
				ROLLBACK TRANSACTION	
				RAISERROR('Cannot delete this product as it is currently in one or more orders. Transaction cancelled.',16,1)
				RETURN
			END
	
		DECLARE @ImageId INT
			
		SET @ImageId = (SELECT imageId FROM Products WHERE id = @ProductId)

		--Ensure this image is not used for other products
		IF NOT EXISTS (SELECT * FROM Products WHERE imageId = @ImageId AND id <> @ProductId)
			BEGIN
				DELETE FROM SiteImages WHERE id = @ImageId

				IF @@Error<>0
					BEGIN
					ROLLBACK TRANSACTION
					RAISERROR('Product deletion error. SiteImage deletion error. Transaction cancelled.',16,1)
					RETURN
					END
			END
		
		DELETE FROM Products WHERE id = @ProductId

		IF @@Error<>0
			BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Product deletion error. Transaction cancelled.',16,1)
			RETURN
			END

	/*
		All clear.
	*/
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END

GO

/****** Object:  StoredProcedure [dbo].[DeleteFromCart] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[DeleteFromCart]
@CartUId VARCHAR(50),
@ProdId INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	Delete FROM Cart 
	WHERE cartUId=@CartUId AND prodId=@ProdId
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update cart error. Transaction cancelled.',16,1)
		RETURN
		END
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
GO


/****** Object:  StoredProcedure [dbo].[InsertCategory] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[InsertCategory]
@CategoryName NVARCHAR(50),
@Description NVARCHAR(MAX) = NULL,
@Id INT OUTPUT
AS
IF EXISTS (SELECT * FROM Categories WHERE [name]=@CategoryName)
	BEGIN	
	RAISERROR('This category already exists. Duplicate not alllowed',16,1)
	RETURN
	END
	
INSERT INTO Categories ([name],[description]) VALUES (@CategoryName,@Description)
SET @Id = @@IDENTITY
GO

/****** Object:  StoredProcedure [dbo].[InsertCustomer] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[InsertCustomer]
@UserName NVARCHAR(50),
@FirstName NVARCHAR(50),
@LastName NVARCHAR(50),
@Email NVARCHAR(50),
@Street NVARCHAR(50),
@City NVARCHAR(20),
@Province NVARCHAR(2),
@PostalCode NVARCHAR(6),
@Phone NVARCHAR(10),
@Password NVARCHAR(15),
@Birth DATE,
@Archived BIT,
@Validated BIT,
@Id INT OUTPUT
AS
IF EXISTS (SELECT * FROM Customers WHERE userName = @UserName)
	BEGIN	
	RAISERROR('This username already exists. Duplicate not alllowed',16,1)
	RETURN
	END
ELSE IF EXISTS (SELECT * FROM Customers WHERE email = @Email)
	BEGIN	
	RAISERROR('This email address already exists. Duplicate not alllowed',16,1)
	RETURN
	END 
ELSE	
	BEGIN
	INSERT INTO Customers (userName, lastName, firstName, email, street, city, province, postalcode, phone, [password], birthday, archived, validated)
	VALUES (@username, @lastname, @firstname, @email, @street, @city, @province, @PostalCode, @phone, @Password, @Birth, @Archived, @Validated)

	SET @Id = @@IDENTITY
	END
GO

/****** Object:  StoredProcedure [dbo].[InsertOrder] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[InsertOrder]
@CustomerId INT,
@OrderDate DATE,
@CartUId VARCHAR(50),
@Tax MONEY,
@ShippingCost MONEY,
@TotalCost MONEY,
@RecipientName NVARCHAR(50),
@Street NVARCHAR(50),
@City NVARCHAR(20),
@Province NVARCHAR(2),
@PostalCode NVARCHAR(6),
@Phone NVARCHAR(10),
@Payment NVARCHAR(50),
@CreditCardName NVARCHAR(50) = NULL,
@CreditNumber NVARCHAR(50) = NULL,
@Cvv NVARCHAR(50) = NULL,
@OrderNo INT OUTPUT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN
	
	/*
		The OrderDetails Table Type variable for Holding my Cart Items
	*/
	DECLARE @OrderDetails AS OrderDetail 

	/*
		The PK generated from inserting into Order. Needed in OrderDetails 
	*/
	DECLARE @OrderNumber INT 
	
    INSERT INTO @OrderDetails
	SELECT c.prodId,
		   c.qty,
		   p.price
	FROM Cart c INNER JOIN Products p ON c.prodId = p.id
	WHERE cartUId = @CartUId

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Cart into OrderDetail TVP error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		Transaction Good. Order Details retrieved from Cart and inserted into OrdeDetails TVP. 
		Keep Going
	*/

	/*
		Insert the Order Header Record
	*/
	INSERT INTO Orders (CustomerId,orderDate,tax, shippingCost, totalCost, recipientName, street, city, province, postalCode, phone, payment, creditCardName, creditNumber, cvv) 
	VALUES(@CustomerId,@OrderDate,@Tax,@ShippingCost,@TotalCost,@RecipientName,@Street,@City,@Province,@PostalCode,@Phone,@Payment,@CreditCardName,@CreditNumber,@Cvv)

	--Get the Orders PK from the insert
	SET @OrderNumber = @@IDENTITY

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Order Header error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All Good
		Insert Order Details using the Order Number and TVP
	*/

	INSERT INTO OrderDetails
	SELECT @OrderNumber,
		   ProductId,
		   Price,
		   Qty,
		   (Price * Qty)
	FROM @OrderDetails

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Order Details error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All Good
		Delete the Cart
	*/
	DELETE FROM Cart WHERE cartUId = @CartUId

	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Cart Deletion error. Transaction cancelled.',16,1)
		RETURN
		END

	SET @OrderNo = @OrderNumber

	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
GO

/****** Object:  StoredProcedure dbo.insertProduct ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[InsertProduct]
@ProductName NVARCHAR(50),
@ProductBriefDesc NVARCHAR(MAX),
@ProductFullDesc NVARCHAR(MAX),
@StatusCode BIT,
@StatusId INT,
@ProductPrice MONEY,
@Featured BIT,
@CategoryId INT,
@ImageName NVARCHAR(50),
@ImageUploadDate DATETIME,
@AltText NVARCHAR(50),
@Id INT OUTPUT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN

	/*
		SiteImages PK Variable for Image Insert
	*/
	DECLARE @ImageID INT

	INSERT INTO SiteImages
	([name],uploadDate,altText)
	VALUES
	(@ImageName,@ImageUploadDate,@AltText)
	
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert Site Image error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear. Insert the product	
		Get the SiteImages PK
	*/
	SET @ImageID = @@IDENTITY
	
	INSERT INTO Products 
	([name],briefDescription,fullDescription,statusCode,statusId,price,featured,categoryId,imageId)
	VALUES (@ProductName,@ProductBriefDesc,@ProductFullDesc,@StatusCode,@StatusId,@ProductPrice,@Featured,@CategoryId,@ImageID)	
		
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Insert product error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear. Set the return @Id with the newly created productId
	*/
	SET @Id = @@IDENTITY
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
	END
GO

/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 2/14/2019 7:56:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Login]
@UserName NVARCHAR(50),
@Password NVARCHAR(50)
AS
BEGIN
	SELECT userName from Customers WHERE userName = @UserName and password = @Password


	IF @@rowcount = 0 
		BEGIN
			RAISERROR('Username or password incorrect', 15, 0)
		END
END
GO

/****** Object:  StoredProcedure [dbo].[RemoveFromCart] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[RemoveFromCart]
@CartUId VARCHAR(50),
@ProdId INT
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN

		DELETE FROM Cart WHERE cartUId = @CartUId AND prodId = @ProdId
		IF @@Error<>0
			BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Update cart error. Transaction cancelled.',16,1)
			RETURN
			END

		IF @@Error=0
			BEGIN
			COMMIT TRANSACTION
			END
	END
GO

/****** Object:  StoredProcedure [dbo].[SearchProducts] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[SearchProducts]
@MatchAllWords BIT,
@CategoryId INT = NULL,
@Keyword1 NVARCHAR(50)=NULL,
@Keyword2 NVARCHAR(50)=NULL,
@Keyword3 NVARCHAR(50)=NULL,
@Keyword4 NVARCHAR(50)=NULL,
@Keyword5 NVARCHAR(50)=NULL,
@StatusCode BIT = NULL 
AS
BEGIN
	IF @MatchAllWords = 0
		BEGIN
			SELECT 
			p.id
			,p.[name]
			,p.price
			,p.briefDescription
			,p.fullDescription
			,i.[name]
			,p.statusCode
			,p.featured
			,(
				SELECT c.[name] FROM Categories c WHERE c.id = p.categoryId 
			) as CategoryName
			FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%')
			OR (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%')
			OR (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%')
			OR (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%')
			OR (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%')
			AND 
			(@StatusCode IS NULL OR p.statusCode = @StatusCode)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.price,p.CategoryId
		END
	ELSE
		BEGIN
			SELECT 
			p.id
			,p.[name]
			,p.price
			,p.briefDescription
			,p.fullDescription
			,i.[name]
			,p.statusCode
			,p.featured
			,(
				SELECT c.[name] FROM Categories c WHERE c.id = p.categoryId 
			) as CategoryName
			FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%')
			AND (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%')
			AND (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%')
			AND (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%')
			AND (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%')
			AND 
			(@StatusCode IS NULL OR p.statusCode = @StatusCode)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.[name],p.price,p.CategoryId
		END
END
GO

/****** Object:  StoredProcedure [dbo].[SelectCart]    Script Date: 2/14/2019 7:56:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[SelectCart]
@CartUId VARCHAR(50),
@CartProdID INT = NULL
AS
BEGIN
	
	SELECT 
	c.cartUId as CartId
	,MAX(p.id) as ProductId
	,MAX(p.[name]) as ProductName
	,CONVERT(VARCHAR(10), c.date, 111) as CurrentDate
	,SUM(c.qty)	as Qty
	,MAX(p.price) as Price
	,(
		c.qty * p.price
	) AS LineTotal
	FROM Cart c INNER JOIN Products p ON c.prodId = p.id
	WHERE 
	c.cartUId = @CartUId 
	AND 
	(@CartProdID IS NULL OR c.prodId = @CartProdID)
	GROUP BY c.cartUId,p.[name],c.date,c.qty,p.price
END
GO

/****** Object:  StoredProcedure dbo.updateCategory ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.updateCategory
	-- Add the parameters for the stored procedure here 
	@CategoryId INT,
	@CategoryName NVARCHAR(50),
	@Description NVARCHAR(MAX) = NULL

AS
    -- Insert statements for procedure here
	UPDATE VieKoreaRestaurant.dbo.Categories
	SET	   name = @CategoryName,
		   description = @Description
	WHERE  id = @CategoryId
GO

/****** Object:  StoredProcedure dbo.updateProduct ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
@ProductId INT,
@ProductName NVARCHAR(50) = NULL,
@ProductBriefDesc NVARCHAR(MAX) = NULL,
@ProductFullDesc NVARCHAR(MAX) = NULL,
@StatusCode BIT = NULL,
@StatusId INT = NULL,
@ProductPrice MONEY = NULL,
@Featured BIT = NULL,
@CategoryId INT = NULL,
@ImageName NVARCHAR(50) = NULL,
@ImageUploadDate DATETIME = NULL,
@AltText NVARCHAR(50) = NULL
AS
BEGIN TRANSACTION
	SET NOCOUNT ON
	BEGIN

	/*
		SiteImages PK Variable for Image Delete
	*/
	DECLARE @ImageId INT = NULL

	IF @ImageName IS NOT NULL
		BEGIN
			/*
				Get Old Image
			*/
			SET @ImageId = (
				SELECT imageId FROM Products WHERE id = @ProductId
			)

			DELETE FROM SiteImages
			WHERE id = @ImageID
	
			IF @@Error<>0
				BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('Delete SiteImage error. Transaction cancelled.',16,1)
				RETURN
				END

			/*
				All clear. Insert the product	 Image
				Get the SiteImages PK
			*/
			INSERT INTO SiteImages
			([name],uploadDate,altText)
			VALUES
			(@ImageName,@ImageUploadDate,@AltText)


			SET @ImageID = @@IDENTITY
		END
	
	UPDATE Products 
	SET
	[name] = ISNULL(@ProductName,[name])
	,briefDescription = ISNULL(@ProductBriefDesc,briefDescription)
	,fullDescription = ISNULL(@ProductFullDesc,fullDescription)
	,statusCode = ISNULL(@StatusCode,statusCode)
	,statusId = ISNULL(@StatusId,statusId)
	,price = ISNULL(@ProductPrice,price)
	,featured = ISNULL(@Featured, featured)
	,categoryId = ISNULL(@CategoryId,categoryId)
	,imageId = ISNULL(@ImageID,imageId)
	WHERE id= @ProductId
		
	IF @@Error<>0
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Update product error. Transaction cancelled.',16,1)
		RETURN
		END

	/*
		All clear.
	*/
	
	IF @@Error=0
		BEGIN
		COMMIT TRANSACTION
		END
END
GO

/****** Object:  StoredProcedure dbo.getProductDetails ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.getProductDetails
	-- Add the parameters for the stored procedure here
		@ProductID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.Products WHERE id = @ProductID
END
GO

/****** Object:  StoredProcedure dbo.getAllProductsDetails ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.getAllProductsDetails
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from dbo.Products order by name asc
END
GO


/****** Object:  StoredProcedure dbo.getCategoryDetails ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.getCategoryDetails
	-- Add the parameters for the stored procedure here
		@CategoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.Categories WHERE id = @CategoryId
END
GO


/****** Object:  StoredProcedure dbo.getAllCategoriesDetails ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.getAllCategoriesDetails
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from dbo.Categories order by name asc
END
GO

/****** Object:  StoredProcedure [dbo].[SelectProducts] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SelectProducts]
@ProductID INT = NULL,
@CategoryId INT = NULL,
@Keyword VARCHAR(50) = NULL,
@Price1 MONEY = NULL,
@Price2 MONEY = NULL,
@Featured BIT = NULL,
@StatusCode BIT = NULL 
AS
BEGIN 
	
	SELECT 
	p.id
	,p.[name]
	,p.price
	,p.briefDescription
	,p.fullDescription
	,i.[name] as ImageName
	,i.altText
	,p.statusCode
	,p.featured
	,(
		SELECT c.[name] FROM Categories c WHERE c.id = p.categoryId 
	) as CategoryName
	FROM Products p INNER JOIN SiteImages i ON p.imageId = i.id
	WHERE 
	(@ProductID IS NULL OR p.id = @ProductID)
	AND
	(@Featured IS NULL OR p.featured = @Featured)
	AND 
	(@StatusCode IS NULL OR p.statusCode = @StatusCode)
	AND 
	(@CategoryId IS NULL OR p.categoryId = @CategoryId)
	AND
	(
		(@Price1 IS NULL OR p.price >= @Price1)
		AND 
		(@Price2 IS NULL OR p.price <= @Price2)
	)
	ORDER BY p.[name],p.price,p.CategoryId

END


/****** Object:  StoredProcedure [dbo].[SelectCategories]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create   PROCEDURE [dbo].[SelectCategories]
@CategoryID INT = NULL
AS
BEGIN
	SELECT * FROM Categories
	WHERE @CategoryID IS NULL OR id = @CategoryID
	ORDER BY name ASC
END

/****** Object:  StoredProcedure [dbo].[SelectStatus]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create   PROCEDURE [dbo].[SelectStatus]
@StatusId INT = NULL
AS
BEGIN
	SELECT * FROM ProductStatus
	WHERE @StatusId IS NULL OR id = @StatusId
END
GO

/****** Object:  StoredProcedure [dbo].[UpdateValidation]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[UpdateValidation]
@Id INT = NULL,
@Validated BIT = NULL

AS
BEGIN
	UPDATE Customers SET
	validated = @Validated
	WHERE id = @Id
END

/****** Object:  StoredProcedure [dbo].[UpdateCart]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create   PROC [dbo].[UpdateCart]
@CartUId VARCHAR(50),
@ProdId INT,
@Qty INT
AS
BEGIN 
	IF @Qty = 0
		BEGIN
			DELETE FROM Cart WHERE 
			cartUId=@CartUId AND prodId=@ProdId
		END
	ELSE
		BEGIN
			UPDATE Cart 
			SET
			qty=@Qty
			WHERE 
			cartUId=@CartUId AND prodId=@ProdId
		END	
END

/****** Object:  StoredProcedure [dbo].[LoginAdmin]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[LoginAdmin]
@UserName NVARCHAR(50),
@Password NVARCHAR(50)
AS
SELECT userName,[password] FROM adminLogin 
WHERE userName=@UserName AND [password]=@Password

IF @@rowcount = 0 
	BEGIN
		RAISERROR('Username or password incorrect', 16, 1)
		RETURN
	END

/****** Object:  StoredProcedure [dbo].[SelectCustomersLookup] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SelectCustomersLookup]
@CustomerId INT = NULL
AS
BEGIN
	SELECT LastName + ', '+ FirstName FROM Customers
	WHERE
	@CustomerId IS NULL OR id = @CustomerId
	ORDER BY LastName,FirstName, City
END

/****** Object:  StoredProcedure [dbo].[SelectProductMaintenance] =******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SelectProductMaintenance] 
@ProductId INT = NULL,
@Keyword NVARCHAR(MAX) = NULL
AS
BEGIN

	SELECT p.*,
	( SELECT status FROM ProductStatus WHERE id = p.statusId
	) as StatusName,
	(
		SELECT name FROM Categories WHERE id = p.categoryId
	) as CategoryName,
	(
		SELECT name FROM SiteImages WHERE id=p.imageId
	) as ImageName
	FROM Products p
	WHERE 
	(@ProductId IS NULL OR p.id = @ProductId)
	AND
	(@Keyword IS NULL OR 
		(
			[name] LIKE '%'+@Keyword+'%' OR briefDescription LIKE '%'+@Keyword+'%' OR fullDescription LIKE '%'+@Keyword+'%' 
		)
	)
END
GO

/****** Object:  StoredProcedure [dbo].[SelectCustomerInfo] =******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE dbo.SelectCustomerInfo
@UserName NVARCHAR(50) = NULL
AS
BEGIN
	SELECT *
	FROM Customers
	WHERE (@UserName = userName) OR (@UserName = NULL)
END

/****** Object:  StoredProcedure [dbo].[UpdateCustomer] =******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[UpdateCustomer]
@Id int,
@UserName NVARCHAR(50),
@FirstName NVARCHAR(50),
@LastName NVARCHAR(50),
@Email NVARCHAR(50),
@Street NVARCHAR(50),
@City NVARCHAR(20),
@Province NVARCHAR(2),
@PostalCode NVARCHAR(6),
@Phone NVARCHAR(10),
@Password NVARCHAR(15),
@Birth DATE,
@Archived BIT,
@Validated BIT
AS
BEGIN
	UPDATE Customers
	SET
	userName = @UserName,
	firstName = @FirstName,
	lastName = @LastName,
	email = @Email,
	street = @Street,
	city = @City,
	province = @Province,
	postalCode = @PostalCode,
	phone = @Phone,
	[password] = @Password,
	birthday = @Birth,
	archived = @Archived,
	validated = @Validated
	WHERE id = @Id
END


/****** Object:  StoredProcedure [dbo].[SelectCustomers] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SelectCustomers]
@CustomerId INT = NULL,
@UserName NVARCHAR(50) = NULL
AS
BEGIN
	SELECT * FROM Customers
	WHERE
	(userName = @UserName OR id = @CustomerId OR userName = NULL OR id = NULL)
END

/****** Object:  StoredProcedure [dbo].[Validation] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE dbo.Validation
@UserName NVARCHAR(50) = NULL
AS
BEGIN
	SELECT validated  
	FROM Customers
	WHERE userName = @UserName

	IF @@rowcount = 0 
		BEGIN
			RAISERROR('Username incorrect', 15, 0)
		END
END

/****** Object:  StoredProcedure [dbo].[Archive] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE dbo.Archive
@UserName NVARCHAR(50) = NULL
AS
BEGIN
	SELECT archived  
	FROM Customers
	WHERE userName = @UserName

	IF @@rowcount = 0 
		BEGIN
			RAISERROR('Username incorrect', 15, 0)
		END
END

/****** Object:  StoredProcedure [dbo].[SelectOrderDetails] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SelectOrderDetails]
@OrderId INT
AS 
BEGIN
	SELECT 
	od.id
	,p.id as ProductId
	,p.[name] as ProductName
	,od.quantity
	,p.price
	,i.[name] as ImageName
	,SUM(od.quantity * p.price) as linetotal	
	 FROM OrderDetails od INNER JOIN Products p ON od.productId = p.id
	 INNER JOIN SiteImages i ON p.imageId = i.id
	WHERE 
	(@OrderId IS NULL OR od.orderNumber = @OrderId)
	GROUP BY od.id,p.id,p.[name]
	,p.price,od.quantity,i.[name]
END

/****** Object:  StoredProcedure [dbo].[SelectOrders] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectOrders]
@CustomerId INT = NULL
AS
BEGIN
	SELECT *
	FROM Orders
	WHERE (CustomerId = @CustomerId OR CustomerId = NULL);
END


/****** Object:  StoredProcedure [dbo].[DeleteOrders] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteOrders]
@OrderNumber INT
AS
BEGIN
	DELETE FROM OrderDetails WHERE orderNumber = @OrderNumber;
	DELETE FROM Orders WHERE orderNumber = @OrderNumber;
END

/****** Object:  StoredProcedure dbo.UpdateOrder ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

--CREATE   PROCEDURE dbo.UpdateOrder
--@OrderNumber Int,
--@OrderStatus NVARCHAR(50)
--AS
--BEGIN
--	UPDATE Orders 
--	SET orderStatus = @OrderStatus
--	WHERE orderNumber = @OrderNumber
--END

/****** Object:  StoredProcedure dbo.InsertSiteImage ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE dbo.InsertSiteImage
@Name NVARCHAR(50),
@AltText NVARCHAR(50),
@Id INT OUTPUT
AS
IF EXISTS (SELECT * FROM SiteImages WHERE name = @Name)
	BEGIN
	RAISERROR('That image already exists',16, 1)
	RETURN
	END
ELSE
	BEGIN
	INSERT INTO SiteImages(name, altText) 
	VALUES(@Name, @AltText)
	SET @Id = @@IDENTITY
	END
GO

/****** Object:  StoredProcedure [dbo].[SearchProductsInAdmin] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[SearchProductsInAdmin]
@MatchAllWords BIT,
@CategoryId INT = NULL,
@Keyword1 NVARCHAR(50)=NULL,
@Keyword2 NVARCHAR(50)=NULL,
@Keyword3 NVARCHAR(50)=NULL,
@Keyword4 NVARCHAR(50)=NULL,
@Keyword5 NVARCHAR(50)=NULL,
@StatusCode BIT = NULL 
AS
BEGIN
	IF @MatchAllWords = 0
		BEGIN
			SELECT p.*,
			( SELECT status FROM ProductStatus WHERE id = p.statusId
			) as StatusName,
			(
				SELECT name FROM Categories WHERE id = p.categoryId
			) as CategoryName,
			(
				SELECT name FROM SiteImages WHERE id=p.imageId
			) as ImageName 	
			FROM Products p INNER JOIN Categories c ON p.categoryId = c.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%' OR c.name LIKE '%'+@Keyword1+'%')
			OR (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%' OR c.name LIKE '%'+@Keyword2+'%')
			OR (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%' OR c.name LIKE '%'+@Keyword3+'%')
			OR (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%' OR c.name LIKE '%'+@Keyword4+'%')
			OR (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%' OR c.name LIKE '%'+@Keyword5+'%')
			AND 
			(@StatusCode IS NULL OR p.statusCode = @StatusCode)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.id, p.[name],p.price,p.CategoryId
		END
	ELSE
		BEGIN
			SELECT p.*,
			( SELECT status FROM ProductStatus WHERE id = p.statusId
			) as StatusName,
			(
				SELECT name FROM Categories WHERE id = p.categoryId
			) as CategoryName,
			(
				SELECT name FROM SiteImages WHERE id=p.imageId
			) as ImageName 	
			FROM Products p INNER JOIN Categories c ON p.categoryId = c.id
			WHERE 
			(p.[name] LIKE '%'+@Keyword1+'%' OR briefDescription LIKE '%'+@Keyword1+'%' OR fullDescription LIKE '%'+@Keyword1+'%' OR c.name LIKE '%'+@Keyword1+'%')
			AND (p.[name] LIKE '%'+@Keyword2+'%' OR briefDescription LIKE '%'+@Keyword2+'%' OR fullDescription LIKE '%'+@Keyword2+'%' OR c.name LIKE '%'+@Keyword2+'%')
			AND (p.[name] LIKE '%'+@Keyword3+'%' OR briefDescription LIKE '%'+@Keyword3+'%' OR fullDescription LIKE '%'+@Keyword3+'%' OR c.name LIKE '%'+@Keyword3+'%')
			AND (p.[name] LIKE '%'+@Keyword4+'%' OR briefDescription LIKE '%'+@Keyword4+'%' OR fullDescription LIKE '%'+@Keyword4+'%' OR c.name LIKE '%'+@Keyword4+'%')
			AND (p.[name] LIKE '%'+@Keyword5+'%' OR briefDescription LIKE '%'+@Keyword5+'%' OR fullDescription LIKE '%'+@Keyword5+'%' OR c.name LIKE '%'+@Keyword5+'%')
			AND 
			(@StatusCode IS NULL OR p.statusCode = @StatusCode)
			AND 
			(@CategoryId IS NULL OR p.categoryId = @CategoryId)
			ORDER BY p.id, p.[name],p.price,p.CategoryId
		END
END
GO

/****************************************************************************************************************/

