CREATE DATABASE PetFoodStore;
USE PetFoodStore;

CREATE TABLE tblDanhMuc (
   iDanhMucId INT PRIMARY KEY IDENTITY(1,1),
   sTenDanhMuc NVARCHAR(50) NOT NULL,
   sMoTa NVARCHAR(255) NULL,
   dThoiGianTao DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE tblSanPham (
   iSanPhamId INT PRIMARY KEY IDENTITY(1,1),
   sTenSanPham NVARCHAR(50) NOT NULL,
   iDanhMucId INT NOT NULL,
   fDonGia FLOAT NOT NULL,
   sMoTa NVARCHAR(255) NULL,
   sAnh NVARCHAR(255) NULL,
   dThoiGianTao DATETIME NOT NULL DEFAULT GETDATE(),
   FOREIGN KEY (iDanhMucId) REFERENCES tblDanhMuc(iDanhMucId)
);
alter table tblSanPham
alter column sMoTa nvarchar(600)

CREATE TABLE tblKhachHang (
   iKhachHangId INT PRIMARY KEY IDENTITY(1,1),
   sHoTen NVARCHAR(50) NOT NULL,
   sEmail NVARCHAR(255) NOT NULL,
   sMatKhau NVARCHAR(255) NOT NULL,
   sDiaChi NVARCHAR(255) NOT NULL,
   sDienThoai NVARCHAR(20) NOT NULL,
   dThoiGianTao DATETIME NOT NULL DEFAULT GETDATE()
);
alter table tblKhachHang
add sRole nvarchar(15)

alter table tblKhachHang
alter column sDiaChi nvarchar(255)

CREATE TABLE tblDonHang (
   iDonHangId INT PRIMARY KEY IDENTITY(1,1),
   iKhachHangId INT NOT NULL,
   dNgayDat DATETIME NOT NULL DEFAULT GETDATE(),
   fTongTien FLOAT NOT NULL,
   sDiaChiGiao NVARCHAR(255) NOT NULL,
   sPhuongThucThanhToan NVARCHAR(50) NOT NULL,
   FOREIGN KEY (iKhachHangId) REFERENCES tblKhachHang(iKhachHangId)
);
/*Sửa cột*/
ALTER TABLE tblDonHang
Add iTrangThai INT null;
/*Đổi tên cột*/
EXEC sp_rename 'Orders.mTotalAmount', 'fTotalAmount', 'COLUMN';

CREATE TABLE tblChiTietDonHang (
   iChiTietDonHangId INT PRIMARY KEY IDENTITY(1,1),
   iDonHangId INT NOT NULL,
   iSanPhamId INT NOT NULL,
   iSoLuong INT NOT NULL,
   fDonGia FLOAT NOT NULL,
   FOREIGN KEY (iDonHangId) REFERENCES tblDonHang(iDonHangId),
   FOREIGN KEY (iSanPhamId) REFERENCES tblSanPham(iSanPhamId)
);
ALTER TABLE tblChiTietDonHang
Add sTenSanPham NVARCHAR(255) NULL;
ALTER TABLE tblChiTietDonHang
Add sAnh NVARCHAR(255) NULL;   

/*---------------Thêm dữ liệu cho danh mục---------------*/
GO
SET IDENTITY_INSERT tblDanhMuc ON 
GO
INSERT INTO tblDanhMuc (iDanhMucId,sTenDanhMuc, sMoTa)
VALUES (1, N'Chó', N'Thức ăn cho chó'),
       (2, N'Mèo', N'Thức ăn cho mèo'),
	   (3, N'Cá', N'Thức ăn cho cá');
GO
SET IDENTITY_INSERT tblDanhMuc OFF

Delete tblDanhMuc where iDanhMucId = 1 or iDanhMucId = 2 or iDanhMucId = 3
select * from tblDanhMuc

/*-----------------Thêm dữ liệu cho bảng Sản phẩm--------------*/

/*Bật tự nhập id*/
GO
SET IDENTITY_INSERT tblSanPham ON 
GO
INSERT INTO tblSanPham (iSanPhamId,sTenSanPham, fDonGia, iDanhMucId, sMoTa)
VALUES (1, N'Thức ăn đóng hộp Royal Canin', 530000, 1, N'Thực phẩm ướt chất lượng cao trong hộp'),
       (2, N'Thức ăn khô Pedigree', 410000, 2, N'Thức ăn khô dành cho mèo trưởng thành'),
       (3, N'Món ăn từ xương sữa cho chó', 1000000, 1, N'Món ăn ngon cho chó với nhiều hương vị khác nhau');
INSERT INTO tblSanPham (iSanPhamId,sTenSanPham, fDonGia, iDanhMucId, sMoTa, sAnh)
VALUES (9, N'Thức ăn cho chó con cỡ nhỏ ROYAL CANIN Mini Puppy', 215000, 1, N'Thức ăn cho chó con cỡ nhỏ ROYAL CANIN Mini Puppy dành cho các giống chó con dưới 10 tháng tuổi. Với công thức đặc chế riêng cho nhu cầu dinh dưỡng của chó con thuộc các giống cỡ nhỏ. Thức ăn cho chó con (các giống chó cỡ nhỏ) được nghiên cứu để cung cấp dinh dưỡng theo nhu cầu thực tế của chó con.Duy trì sức đề kháng cho chó con: chất chống oxy hóa CELT. Hỗ trợ hệ tiêu hóa hoạt động ổn định: L.I.P, đường FOS. Cung cấp dinh dưỡng toàn diện cho chó: chế biến theo công thức cung cấp năng lượng cao.', N'./Images/ImgCho/thuc-an-cho-cho-con-co-nho-royal-canin-mini-puppy1.jpg'),
       (11, N'Thức ăn cho chó Poodle con ROYAL CANIN Poodle Puppy', 175000, 1, N'Thức ăn cho chó Poodle con ROYAL CANIN Poodle Puppy dành riêng cho tất cả các giống chó Teacup, Tiny Poodle, Toy Poodle, Standard Poodle dưới 10 tháng tuổi.', N'./Images/ImgCho/thuc-an-cho-cho-poodle-con-royal-canin-poodle-puppy1.jpg'),
       (10, N'Thức ăn cho chó Poodle MKB All Life Stages Formula Nutrition', 315000 , 1, N'Thức ăn cho chó Poodle MKB All Life Stages Formula Nutrition, dành riêng cho chó Poodle, bao gồm tất cả các giai đoạn phát triển.', N'./Images/ImgCho/thuc-an-cho-cho-poodle-mkb-all-life-stages-formula-nutrition.jpg'),
	   (6, N'Thức ăn cho chó con hạt mềm ZENITH Puppy Chicken Potato', 220000, 1, N'Thức ăn cho chó con hạt mềm ZENITH Puppy Chicken Potato được chế biến từ thịt cừu tươi, thịt nạc gà rút xương, gạo lứt, yến mạch và dầu cá hồi. Với các thành phần tươi sạch, giàu dinh dưỡng, Zenith Puppy hạt mềm, cung cấp độ ẩm cao và lượng muối thấp, thơm ngon, dễ nhai, dễ tiêu hóa và tốt cho sức khỏe chó con.', N'./Images/ImgCho/zenith-puppy-chicken-potato-400x400.jpg'),
       (7, N'Thức ăn cho chó trưởng thành cỡ nhỏ ROYAL CANIN Mini Adult', 180000 , 1, N'Thức ăn cho chó ROYAL CANIN Mini Adult từ 10 tháng tuổi trở lên. Với công thức đặc chế riêng cho nhu cầu dinh dưỡng của chó trưởng thành thuộc các giống cỡ nhỏ.
ROYAL CANIN Mini Adult được nghiên cứu để cung cấp dinh dưỡng theo nhu cầu thực tế của chó. Cung cấp năng lượng theo nhu cầu dinh dưỡng của chó. Duy trì da và lông khỏe mạnh: EPA, DHA. Kiểm soát cân nặng lý tưởng cho chó: L-Carnitine', N'./Images/ImgCho/thuc-an-cho-cho-truong-thanh-co-nho-royal-canin-mini-adult1.jpg'),
       (8, N'Thức ăn cho chó trưởng thành cỡ lớn ROYAL CANIN Maxi Adult', 165000, 1, N'Thức ăn cho chó trưởng thành cỡ lớn ROYAL CANIN Maxi Adult từ 15 tháng tuổi trở lên. Thường được dùng cho các giống chó có kích thước lớn như: Alaskan Malamute, Husky, Samoyed, Becgie GSD, Golden Retriever, Labrado, Akita, Beauceron, Rottweiler…
Với công thức đặc chế riêng cho nhu cầu dinh dưỡng của chó trưởng thành.', N'./Images/ImgCho/thuc-an-cho-cho-truong-thanh-royal-canin-maxi-adult1.jpg');
GO
delete tblSanPham where iSanPhamId = 1
update tblSanPham set sTenSanPham = N'Thức ăn khô dành cho mèo trưởng thành' where iSanPhamId = 2

select * from tblSanPham
/*id tự tăng*/
SET IDENTITY_INSERT tblSanPham OFF

Update tblSanPham set sMoTa = N'Thức ăn khô Pedigree' where iSanPhamId = 2
Delete tblSanPham where iSanPhamId = 3 or iSanPhamId = 2 or iSanPhamId = 1
select * from tblSanPham


/*-----------------Thêm dữ liệu cho bảng Khách Hàng--------------*/
GO
SET IDENTITY_INSERT tblKhachHang ON
GO
INSERT INTO tblKhachHang(iKhachHangId, sHoTen, sEmail, sDiaChi, sMatKhau, sDienThoai)
VALUES (1, N'Đỗ Mạnh Hùng', 'manhhung@gmail.com', N'Hưng yên' ,'123456', '0862-210-801'),
       (2, N'Trần Trung Kien', 'trungkien@gmail.com', N'Ninh Bình', '123456', '0123-456-789'),
	   (3, N'Bùi Quang Minh', 'quangminh@gmail.com', N'Thái Bình', '123456', '0123-456-782');
GO
SET IDENTITY_INSERT tblKhachHang OFF
delete tblKhachHang where iKhachHangId=1 or iKhachHangId=2 or iKhachHangId=3
select * from tblKhachHang

update tblKhachHang set sRole= N'1' where sMatKhau = '123456'


/*-----------------Thêm dữ liệu cho bảng đơn hàng--------------*/
GO
SET IDENTITY_INSERT tblDonHang ON
GO
INSERT INTO tblDonHang(iKhachHangId, fTongTien, sDiaChiGiao, sPhuongThucThanhToan)
VALUES (2, 940000, N'281 Trương Định, Hoàng Mai, Hà Nội', N'Credit Card');
GO
SET IDENTITY_INSERT tblDonHang OFF
delete tblDonHang where iKhachHangId=2
select * from tblDonHang

/*-----------------Thêm dữ liệu cho bảng chi tiết đơn hàng--------------*/
INSERT INTO tblChiTietDonHang(iDonHangId, iSanPhamId, iSoLuong, fDonGia)
VALUES (7, 1, 2, 530000);
INSERT INTO tblChiTietDonHang(iDonHangId, iSanPhamId, iSoLuong, fDonGia)
VALUES (8, 2, 3, 410000);

select * from tblChiTietDonHang
delete tblChiTietDonHang where iDonHangId=2

-------------------------------Proceduces----------------------------------------


/*---------------------------------Category-------------------------------------*/
-------Proc_getAll_DanhMuc----
GO
create proc sp_getAll_DanhMuc
as
begin
	select * from tblDanhMuc
end
exec sp_getAll_DanhMuc

-------Proc_addCategory------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_add_Category]
(
@sTenDanhMuc nvarchar(50),
@sMota nvarchar(500),
@id_TD int output
)
as
begin
	insert tblDanhMuc(sTenDanhMuc,sMoTa)
	values (@sTenDanhMuc,@sMota)

	set @id_TD = SCOPE_IDENTITY();
end

---proc_UpdateCategory----
GO
create proc sp_updateCategory
@sTenDanhMuc nvarchar(50),
@sMoTa nvarchar(255),
@id int
as
begin
	update tblDanhMuc 
	set sTenDanhMuc=@sTenDanhMuc, 
		sMoTa=@sMoTa, 
		dThoiGianTao = GETDATE() 
		where iDanhMucId=@id
end

select * from tblDanhMuc
---proc_deleteCategory----
GO
create proc sp_deleteCategory
@iDanhMucId int
as
begin
	Delete tblDanhMuc where tblDanhMuc.iDanhMucId = @iDanhMucId;
end

select * from tblDanhMuc

/*-------------------------------Product-----------------------------------------*/

-------Danh sách sản phẩm lấy ra tên danh mục-------------
GO
create proc sp_listProduct 
as
begin
	select b.sTenDanhMuc, a.*   from tblSanPham as a,tblDanhMuc as b where a.iDanhMucId = b.iDanhMucId
end
exec sp_listProduct 
Update tblSanPham set sAnh = N'./Images/ImgMeo/meo1.png' where iSanPhamId=2



--------Select product với nhiều điều kiện nhập vào-------
GO
Alter PROCEDURE sp_get_Product
	@iDanhMucId int = NULL,
    @sTenSanPham NVARCHAR(50) = NULL,
	@fDonGia float = NULL
AS
BEGIN
    SELECT *
    FROM tblSanPham
    WHERE (ISNULL(@sTenSanPham, '') = '' OR sTenSanPham LIKE '%' + @sTenSanPham + '%')
        AND (@iDanhMucId IS NULL OR iDanhMucId = @iDanhMucId)
        AND (@fDonGia IS NULL OR fDonGia >= @fDonGia)
END
exec sp_get_Product @sTenSanPham='', @iDanhMucId=3, @fDonGia=100000
select * from tblSanPham
select * from tblDanhMuc as a, tblSanPham as b where a.iDanhMucId = b.iDanhMucId 

-------------select search product-----------------
GO
Create PROCEDURE sp_search_Product
    @sTenSanPham NVARCHAR(50) = NULL
AS
BEGIN
    SELECT *
    FROM tblSanPham
    WHERE sTenSanPham LIKE '%' + @sTenSanPham + '%'
END
exec sp_search_Product @sTenSanPham="rùa"
-------------proc ChiTietSanPham----------
GO
create PROCEDURE sp_get_ChiTietSP
	@iSanPhamId int = NULL,
    @sTenSanPham NVARCHAR(50) = NULL,
	@fDonGia float = NULL
AS
BEGIN
    SELECT *
    FROM tblSanPham
    WHERE (ISNULL(@sTenSanPham, '') = '' OR sTenSanPham LIKE '%' + @sTenSanPham + '%')
        AND (@iSanPhamId IS NULL OR iSanPhamId = @iSanPhamId)
        AND (@fDonGia IS NULL OR fDonGia >= @fDonGia)
END

----proc_insertProduct-----
GO
create proc sp_addProduct
(
	@sTenSanPham nvarchar(255),
	@iDanhMucId int,
	@fDonGia float,
	@sMoTa nvarchar(500),
	@sAnh nvarchar(255)
)
as
begin
	insert tblSanPham(sTenSanPham,iDanhMucId, fDonGia, sMoTa, sAnh)
	values (@sTenSanPham,@iDanhMucId,@fDonGia,@sMota,@sAnh)
end
---proc_deleteProduct----
GO
create proc sp_deleteProduct
@iSanPhamId int
as
begin
	Delete tblSanPham where tblSanPham.iSanPhamId = @iSanPhamId;
end

select * from tblSanPham

/*----------------------------SignIn, SignUp -------------------------------------------*/
---Proc_DangNhap---
GO
alter proc sp_dangNhap 
(
	@sEmail nvarchar(255),
	@sMatKhau nvarchar(255)
)
as
begin
	select * from tblKhachHang where sEmail=@sEmail and sMatKhau = @sMatKhau 
end
exec sp_dangNhap @sEmail=N'manhhung@gmail.com', @sMatKhau = N'123456'


------Proc_DangKy-----
GO
alter proc sp_dangKy 
(
	@sHoTen nvarchar(50),
	@sEmail nvarchar(255),
	@sMatKhau nvarchar(20),
	@sDiaChi nvarchar(255),
	@sDienThoai nvarchar(20)
)
as
begin
	 INSERT INTO tblKhachHang(sHoTen, sEmail, sMatKhau, sDiaChi, sDienThoai, sRole)
	 VALUES (@sHoTen, @sEmail, @sMatKhau, @sDiaChi, @sDienThoai, '1')
end

exec sp_dangKy  @sHoTen=N'Admin', @sEmail='Admin', @sMatKhau='123456', @sDiaChi= N'Hà Nội', @sDienThoai=N'123456'

INSERT INTO tblKhachHang(sHoTen, sEmail, sMatKhau, sDienThoai, sRole)
	 VALUES ('Admin', 'Admin', '123456', '0862210801', '0')
Update tblKhachHang set iKhachHangId=4 where tblKhachHang.iKhachHangId = 22

select * from tblKhachHang

delete tblKhachHang where iKhachHangId=20


-----------------------------Cart-------------
GO
alter proc sp_order_Cart 
(
	
	@iKhachHangId int,
	@sTenKhachHang nvarchar(255),
	@sEmail nvarchar(20),
	@sPhuongThucThanhToan nvarchar(255),
	@sPhone nvarchar(20),
	@sDiaChiGiao nvarchar(255),
	@dNgayDat datetime,
	@fTongTien float,
	@iTrangThai int
)
as
begin
	 INSERT INTO tblDonHang(iKhachHangId, sTenKhachHang, sEmail, sPhuongThucThanhToan, sPhone, sDiaChiGiao,dNgayDat,fTongTien, iTrangThai)
	 VALUES (@iKhachHangId, @sTenKhachHang, @sEmail, @sPhuongThucThanhToan, @sPhone, @sDiaChiGiao,@dNgayDat,@fTongTien,@iTrangThai)
	
end
select * from tblChiTietDonHang
select * from tblDonHang


create proc sp_getAll_Order
as
begin
	select * from tblDonHang
end


alter proc sp_updateCart
@iTrangThai int,
@iDonHangId int
as
begin
	update tblDonHang
	set iTrangThai=@iTrangThai
		where iDonHangId=@iDonHangId
end

-------Proc_getAll_Cart----
GO
create proc sp_getAll_Cart
as
begin
	select * from tblChiTietDonHang
end
exec sp_getAll_Cart

SELECT * FROM tblSanPham WHERE fDonGia >=  500000 and fDonGia <= 2000000;