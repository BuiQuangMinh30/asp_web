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
ALTER COLUMN mTotalAmount FLOAT not null;
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
GO
/*id tự tăng*/
SET IDENTITY_INSERT tblSanPham OFF

Update tblSanPham set sAnh = './Images/Nike/Nike_1-Red.svg' where iSanPhamId = 3
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
VALUES (3, 1, 2, 530000);
INSERT INTO tblChiTietDonHang(iDonHangId, iSanPhamId, iSoLuong, fDonGia)
VALUES (3, 2, 3, 410000);

select * from tblChiTietDonHang
delete tblChiTietDonHang where iDonHangId=2

-------------------------------Proceduces----------------------------------------
GO
create proc sp_getAll_Product 
as
begin
	select * from tblSanPham
end
exec sp_getAll_Product 

----------------------Select với nhiều điều kiện nhập vào--------------------
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
-------------------------------proc_get_ChiTietSanPham------------------------
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

exec sp_get_ChiTietSP @iSanPhamId='1'

-------------------------------Category----------------------------------------
GO
create proc sp_getAll_Category 
as
begin
	select * from tblDanhMuc
end
exec sp_getAll_Category 


/*----------------------Proc_DangNhap-------------------------*/
GO
create proc sp_dangNhap 
(
	@sEmail nvarchar(255),
	@sMatKhau nvarchar(255)
)
as
begin
	select * from tblKhachHang where sEmail=@sEmail and sMatKhau = @sMatKhau 
end
exec sp_dangNhap @sEmail=N'manhhung@gmail.com', @sMatKhau = N'123456'


----------------------------Proc_DangKy--------------------------
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

----------------------Proc_getAll_DanhMuc-----------------
GO
create proc sp_getAll_DanhMuc
as
begin
	select * from tblDanhMuc
end

exec sp_getAll_DanhMuc
