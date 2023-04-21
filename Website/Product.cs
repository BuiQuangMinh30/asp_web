using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website
{
    public class Product
    {
        public int idSanPham { get; set; }
        public int iSoLuong { get; set; }
        public string sAnh { get; set; }
        public string sTenSanPham { get; set; }
        public float fDonGia { get; set; }
        public string sMoTa { get; set; }
        public int idDanhmuc { get; set; }
        public DateTime dThoiGianTao { get; set; }
        public string uniqueIdentifier { get; set; } // thuộc tính ID duy nhất cho sản phẩm
        public Product()
        {

        }
        public Product(int idSanPham, string sAnh, string sTenSanPham, float fDonGia, string sMoTa, int idDanhmuc, DateTime dThoiGianTao)
        {
            this.idSanPham = idSanPham;
            this.sAnh = sAnh;
            this.sTenSanPham = sTenSanPham;
            this.fDonGia = fDonGia;
            this.sMoTa = sMoTa;
            this.idDanhmuc = idDanhmuc;
            this.dThoiGianTao = dThoiGianTao;
        }
    }
}