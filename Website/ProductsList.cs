using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class ProductsList
    {
<<<<<<< HEAD
        public int iSanPhamId { get; set; }
=======
        public int idSanPham { get; set; }
>>>>>>> NhanhCuaHung
        public string sAnh { get; set; }
        public string sTenSanPham { get; set; }
        public float fDonGia { get; set; }
        public string sMoTa { get; set; }
<<<<<<< HEAD
        public int iDanhMucId { get; set; }
        public string dThoiGianTao { get; set; }
=======
        public int idDanhmuc { get; set; }
        public DateTime dThoiGianTao { get; set; }
>>>>>>> NhanhCuaHung
        public ProductsList()
        {

        }
<<<<<<< HEAD
        public ProductsList(int iSanPhamId, string sAnh, string sTenSanPham, 
            float fDonGia, string sMoTa,  int iDanhMucId, string dThoiGianTao)
        {
            this.iSanPhamId = iSanPhamId;
=======
        public ProductsList(int idSanPham, string sAnh, string sTenSanPham, float fDonGia, string sMoTa, int idDanhmuc, DateTime dThoiGianTao)
        {
            this.idSanPham = idSanPham;
>>>>>>> NhanhCuaHung
            this.sAnh = sAnh;
            this.sTenSanPham = sTenSanPham;
            this.fDonGia = fDonGia;
            this.sMoTa = sMoTa;
<<<<<<< HEAD
            this.iDanhMucId = iDanhMucId;
=======
            this.idDanhmuc = idDanhmuc;
>>>>>>> NhanhCuaHung
            this.dThoiGianTao = dThoiGianTao;
        }
    }
}