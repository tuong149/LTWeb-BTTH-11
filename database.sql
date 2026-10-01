IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'KTQT_WebDB')
BEGIN
    CREATE DATABASE KTQT_WebDB;
END
GO

USE KTQT_WebDB;
GO

-- Xóa bảng cũ nếu tồn tại
IF OBJECT_ID('OrderDetails', 'U') IS NOT NULL DROP TABLE OrderDetails;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Shares', 'U') IS NOT NULL DROP TABLE Shares;
IF OBJECT_ID('Favorites', 'U') IS NOT NULL DROP TABLE Favorites;
IF OBJECT_ID('Videos', 'U') IS NOT NULL DROP TABLE Videos;
IF OBJECT_ID('Category', 'U') IS NOT NULL DROP TABLE Category;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
GO

-- Bảng Users
CREATE TABLE Users (
    Username NVARCHAR(50) NOT NULL PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15) NULL,
    Fullname NVARCHAR(50) NULL,
    Email NVARCHAR(150) NULL,
    Admin BIT DEFAULT 0,
    Active BIT DEFAULT 1,
    Images NVARCHAR(500) NULL
);
GO

-- Bảng Category
CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Categoryname NVARCHAR(100) NOT NULL,
    Categorycode NVARCHAR(100) NULL,
    Images NVARCHAR(500) NULL,
    Status BIT DEFAULT 1
);
GO

-- Bảng Videos
CREATE TABLE Videos (
    VideoId NVARCHAR(50) NOT NULL PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Poster NVARCHAR(50) NULL,
    Views INT DEFAULT 0,
    Description NVARCHAR(500) NULL,
    Active BIT DEFAULT 1,
    CategoryId INT NOT NULL,
    CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
);
GO

-- Bảng Shares
CREATE TABLE Shares (
    ShareId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Emails NVARCHAR(50) NULL,
    SharedDate DATE DEFAULT GETDATE(),
    Username NVARCHAR(50) NOT NULL,
    VideoId NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE,
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- Bảng Favorites
CREATE TABLE Favorites (
    FavoriteId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    LikedDate DATE DEFAULT GETDATE(),
    VideoId NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE,
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- Bảng Orders (Thanh toán / Đơn hàng)
CREATE TABLE Orders (
    OrderId NVARCHAR(50) NOT NULL PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE(),
    Username NVARCHAR(50) NOT NULL,
    RecipientName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Address NVARCHAR(300) NOT NULL,
    Note NVARCHAR(500) NULL,
    TotalAmount FLOAT NOT NULL,
    PaymentMethod NVARCHAR(50) DEFAULT 'COD',
    PaymentStatus NVARCHAR(50) DEFAULT 'UNPAID',
    OrderStatus NVARCHAR(50) DEFAULT 'PENDING',
    CONSTRAINT FK_Orders_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE
);
GO

-- Bảng OrderDetails (Chi tiết đơn hàng)
CREATE TABLE OrderDetails (
    DetailId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId NVARCHAR(50) NOT NULL,
    VideoId NVARCHAR(50) NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    Price FLOAT NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- DỮ LIỆU MẪU

INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images)
VALUES 
('admin', '123', '0901234567', N'Quản Trị Viên', 'admin@ute.edu.vn', 1, 1, 'admin.jpg'),
('user1', '123', '0987654321', N'Nguyễn Văn A', 'user1@gmail.com', 0, 1, 'user.jpg');

INSERT INTO Category (Categoryname, Categorycode, Images, Status)
VALUES 
(N'Lập trình Java', 'JAVA', 'java.png', 1),
(N'Lập trình Web', 'WEB', 'web.png', 1),
(N'Cơ sở dữ liệu', 'CSDL', 'db.png', 1);

INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId)
VALUES 
('VID01', N'Hướng dẫn Servlet và JSP', 'poster1.jpg', 1500, N'Học Servlet, JSP cơ bản.', 1, 2),
('VID02', N'Xây dựng kiến trúc 3 lớp', 'poster2.jpg', 2300, N'Tìm hiểu kiến trúc MVC 3 tier.', 1, 2),
('VID03', N'Tích hợp SiteMesh Decorator', 'poster3.jpg', 800, N'Tạo layout dùng chung Header Footer.', 1, 2),
('VID04', N'Xác thực bằng OTP Email', 'poster4.jpg', 1200, N'Tạo tính năng gửi mã OTP.', 1, 2),
('VID05', N'Java Core OOP nâng cao', 'poster5.jpg', 3200, N'OOP trong ngôn ngữ Java.', 1, 1),
('VID06', N'Collections Framework Java', 'poster6.jpg', 1900, N'List, Set, Map thực tế.', 1, 1),
('VID07', N'Thiết kế CSDL 3NF', 'poster7.jpg', 2100, N'Chuẩn hóa cơ sở dữ liệu.', 1, 3);
GO
